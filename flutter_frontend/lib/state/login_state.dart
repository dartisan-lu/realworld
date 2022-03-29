import 'package:flutter/foundation.dart';

import '../model/user_model.dart';

class LoginState extends ChangeNotifier {
  User? user;
  String? errorMessage;

  loginError(String message) {
    user = null;
    errorMessage = message;
    notifyListeners();
  }

  loginSuccess(User user) {
    this.user = user;
    errorMessage = null;
    notifyListeners();
  }

  logout() {
    user = null;
    errorMessage = null;
    notifyListeners();
  }
}
