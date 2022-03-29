import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../config/environment_config.dart';
import '../config/mongo_config.dart';
import '../exception/application_exceptions.dart';
import '../exception/security_exceptions.dart';
import '../exception/user_exceptions.dart';
import '../model/user_model.dart';

class UserService {
  final Db db;
  final EnvironmentConfig environmentConfig;

  UserService(this.db, this.environmentConfig);

  /// Create User
  Future<UserDetails> createUser(UserRegister user) async {
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(user.email)) {
      throw ApplicationException('Invalid Email Address');
    }
    var col = db.collection(MongoCollection.user);
    var check = await col.find(where.eq('email', user.email).or(where.eq('username', user.username))).toList();
    if (check.isEmpty) {
      await col.insert(user.toMap());
      var userDetails = await getUserDetails(user.username);
      userDetails.token = _generateToken(userDetails.username);
      return userDetails;
    } else {
      throw ApplicationException('username or email already in use');
    }
  }

  /// Login
  Future<UserDetails> login(UserLogin user) async {
    var col = db.collection(MongoCollection.user);
    var check = await col.find(where.eq('email', user.email)).toList();
    if (check.isEmpty) {
      throw UserLoginException('Unknown user');
    }
    var checkUser = UserRegister.fromMap(check.first);
    if (checkUser.password != user.password) {
      throw UserLoginException('Invalid credentials');
    }
    var userDetails = UserDetails.fromMap(check.first);
    userDetails.token = _generateToken(userDetails.username);
    return userDetails;
  }

  /// Update User
  Future<UserDetails> updateUserDetails(Map<String, dynamic> userResponse, String? currentUser) async {
    if (currentUser == null) {
      throw UnauthorizedException('User not logged in');
    }
    var col = db.collection(MongoCollection.user);
    var check = await col.find(where.eq('username', currentUser)).toList();
    if (check.isEmpty) {
      throw UserLoginException('Unknown user');
    }
    var user = check.first;

    if (userResponse.containsKey('email')) user['email'] = userResponse['email'];
    if (userResponse.containsKey('bio')) user['bio'] = userResponse['bio'];
    if (userResponse.containsKey('image')) user['image'] = userResponse['image'];
    await col.update({"username": currentUser}, user);

    return UserDetails.fromMap(user);
  }

  /// Get User Details
  Future<UserDetails> getUserDetails(String currentUser) async {
    var col = db.collection(MongoCollection.user);
    var check = await col.find(where.eq('username', currentUser)).toList();
    if (check.isNotEmpty) {
      return UserDetails.fromMap(check.first);
    } else {
      throw ApplicationException('username not exists');
    }
  }

  /// Get User Profile
  Future<UserProfile> getUserProfile(String username) async {
    var col = db.collection(MongoCollection.user);
    var check = await col.find(where.eq('username', username)).toList();
    if (check.isNotEmpty) {
      return UserProfile.fromMap(check.first);
    } else {
      throw ApplicationException('username not exists');
    }
  }

  /// Follow User
  Future<UserProfile> followUser(String username, String? currentUser) async {
    if (currentUser == null) {
      throw UnauthorizedException('User not logged in');
    }
    var col = db.collection(MongoCollection.user);
    var check = await col.find(where.eq('username', currentUser)).toList();
    if (check.isEmpty) {
      throw UserLoginException('Unknown user');
    }

    var follow = await col.find(where.eq('username', username)).toList();
    if (follow.isEmpty) {
      throw UserLoginException('Unknown user to follow');
    }
    var rtn = UserProfile.fromMap(follow.first);

    var user = check.first;
    if (user['follow'] == null) {
      user['follow'] = [username];
    } else {
      (user['follow'] as List).add(username);
    }
    await col.update({"username": currentUser}, user);

    rtn.following = true;

    return rtn;
  }

  /// Unfollow User
  Future<UserProfile> unfollowUser(String username, String? currentUser) async {
    if (currentUser == null) {
      throw UnauthorizedException('User not logged in');
    }
    var col = db.collection(MongoCollection.user);
    var check = await col.find(where.eq('username', currentUser)).toList();
    if (check.isEmpty) {
      throw UserLoginException('Unknown user');
    }

    var unfollow = await col.find(where.eq('username', username)).toList();
    if (unfollow.isEmpty) {
      throw UserLoginException('Unknown user to unfollow');
    }
    var rtn = UserProfile.fromMap(unfollow.first);

    var user = check.first;
    if (user['follow'] != null) {
      (user['follow'] as List).remove(username);
    }
    await col.update({"username": currentUser}, user);

    rtn.following = false;

    return rtn;
  }

  /// Generate JWT Token
  _generateToken(String username) {
    final jwt = JWT(username);
    return jwt.sign(SecretKey(environmentConfig.tokenSecrect));
  }

  Future<List<String>> following(String currentUser) async {
    var col = db.collection(MongoCollection.user);
    var check = await col.find(where.eq('username', currentUser)).toList();
    if (check.isNotEmpty) {
      return List<String>.from(check.first['follow'] ?? []);
    } else {
      throw ApplicationException('username not exists');
    }
  }
}
