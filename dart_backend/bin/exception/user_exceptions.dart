import '../model/error_model.dart';

class UserCreationException implements Exception {
  late final ErrorReport report;

  UserCreationException(String cause) {
    report = ErrorReport.singleError(cause);
  }
}

class UserLoginException implements Exception {
  late final ErrorReport report;

  UserLoginException(String cause) {
    report = ErrorReport.singleError(cause);
  }
}
