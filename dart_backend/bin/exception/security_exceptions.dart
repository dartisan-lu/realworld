import '../model/error_model.dart';

class UnauthorizedException implements Exception {
  late final ErrorReport report;

  UnauthorizedException(String cause) {
    report = ErrorReport.singleError(cause);
  }
}
