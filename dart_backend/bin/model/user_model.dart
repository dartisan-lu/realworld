import 'dart:convert';

class UserLogin {
  late final String email;
  late final String password;

  UserLogin({required this.email, required this.password});

  UserLogin.fromMap(Map<String, dynamic> data) {
    email = data['email'];
    password = data['password'];
  }
}

class UserRegister {
  late final String email;
  late final String username;
  late final String password;

  UserRegister(this.email, this.username, this.password);

  Map<String, dynamic> toMap() {
    return {'email': email, 'username': username, 'password': password};
  }

  UserRegister.fromMap(Map<String, dynamic> data) {
    email = data['email'];
    username = data['username'];
    password = data['password'];
  }
}

class UserDetails {
  late final String email;
  late final String username;
  String? token;
  String? bio;
  String? image;

  UserDetails({required this.email, required this.username, this.token, this.bio, this.image});

  String toJson() {
    return '''
    {"user": {
      "email": ${jsonEncode(email)},
      "username": ${jsonEncode(username)},
      "token": ${jsonEncode(token)},
      "bio": ${jsonEncode(bio)},
      "image": ${jsonEncode(image)}
    }}
    ''';
  }

  UserDetails.fromMap(Map<String, dynamic> data) {
    email = data['email'];
    username = data['username'];
    bio = data['bio'];
    image = data['image'];
  }
}

class UserProfile {
  late final String username;
  String? bio;
  String? image;
  bool? following;

  UserProfile({required this.username, this.bio, this.image, this.following});

  String toJson() {
    return '''
    {"profile": {
      "username": ${jsonEncode(username)},
      "following": ${jsonEncode(following)},
      "bio": ${jsonEncode(bio)},
      "image": ${jsonEncode(image)}
    }}
    ''';
  }

  UserProfile.fromMap(Map<String, dynamic> data) {
    username = data['username'];
    bio = data['bio'];
    image = data['image'];
  }

  toMap() {
    return {'username': username, 'bio': bio, 'image': image};
  }
}
