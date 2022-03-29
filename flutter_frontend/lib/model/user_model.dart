class User {
  final String email;
  final String token;
  final String username;
  final String bio;
  final String image;

  User({required this.email, required this.token, required this.username, required this.bio, required this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'] != null ? json['email'] as String : '',
        token: json['token'] != null ? json['token'] as String : '',
        username: json['username'] != null ? json['username'] as String : '',
        bio: json['bio'] != null ? json['bio'] as String : '',
        image: json['image'] != null ? json['image'] as String : '');
  }
}

class Profile {
  final String username;
  final String bio;
  final String image;
  final bool following;

  Profile({required this.username, required this.bio, required this.image, required this.following});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        username: json['username'] as String,
        bio: json['bio'] != null ? json['bio'] as String : '',
        image: json['image'] != null ? json['image'] as String : '',
        following: json['following'] != null ? json['following'] as bool : false);
  }
}

class LoginUser {
  final String email;
  final String password;
  final String? username;

  LoginUser({required this.email, required this.password, this.username});

  factory LoginUser.fromJson(Map<String, dynamic> json) {
    return LoginUser(
        email: json['email'] != null ? json['email'] as String : '',
        username: json['user'] != null ? json['user'] as String : null,
        password: json['password'] != null ? json['password'] as String : '');
  }

  Map<String, dynamic> toJson() {
    var data = username == null
        ? {
            'user': {'email': email, 'password': password}
          }
        : {
            'user': {'email': email, 'password': password, 'username': username}
          };
    return data;
  }
}
