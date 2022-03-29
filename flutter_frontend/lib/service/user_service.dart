import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/system_values.dart' as config;
import '../model/user_model.dart';
import '../state/login_state.dart';

class UserService {
  final http.Client client;

  UserService(this.client);

  void create(LoginUser user, LoginState loginState, Function() success) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var encode = jsonEncode(user.toJson());
    final response = await client.post(Uri.parse('${config.sysValRoot}/users'), body: encode, headers: headers);
    if (response.statusCode == 200) {
      var user = parseUser(response.body);
      if (user != null) {
        loginState.loginSuccess(user);
        success();
      } else {
        loginState.loginError('unknown Error');
      }
    } else {
      loginState.loginError('• email or password has already been taken');
    }
  }

  void login(LoginUser user, LoginState loginState, Function success) async {
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var encode = jsonEncode(user.toJson());
    final response = await client.post(Uri.parse('${config.sysValRoot}/users/login'), body: encode, headers: headers);
    if (response.statusCode == 200) {
      var user = parseUser(response.body);
      if (user != null) {
        loginState.loginSuccess(user);
        success();
      } else {
        loginState.loginError('unknown Error');
      }
    } else if (response.statusCode == 403) {
      loginState.loginError('• email or password is invalid');
    } else {
      loginState.loginError('• unknown Error');
    }
  }

  User? parseUser(dynamic responseBody) {
    if (responseBody != null && responseBody.isNotEmpty) {
      var jsonObj = jsonDecode(responseBody);
      return User.fromJson(jsonObj['user']);
    }
    return null;
  }
}
