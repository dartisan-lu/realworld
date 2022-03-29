import '../model/error_model.dart';

class ApplicationException implements Exception {
  late final ErrorReport report;

  ApplicationException(String cause) {
    report = ErrorReport.singleError(cause);
  }
}
