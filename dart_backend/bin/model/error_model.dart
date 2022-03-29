import 'dart:convert';

class ErrorReport {
  final _errors = <String>[];

  ErrorReport();

  ErrorReport.singleError(String error) {
    _errors.add(error);
  }

  addError(String error) {
    _errors.add(error);
  }

  bool isEmpty() {
    return _errors.isEmpty;
  }

  bool isNotEmpty() {
    return _errors.isNotEmpty;
  }

  addAll(ErrorReport other) {
    _errors.addAll(other._errors);
  }

  String toJson() {
    return '''
    {
      "errors": {
        "body": ${jsonEncode(_errors)}
      }
    }
    ''';
  }
}
