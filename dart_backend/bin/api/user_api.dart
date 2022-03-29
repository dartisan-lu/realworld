import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../config/system_values.dart';
import '../exception/application_exceptions.dart';
import '../exception/security_exceptions.dart';
import '../model/error_model.dart';
import '../service/user_service.dart';

class UserApi {
  final UserService userService;

  UserApi(this.userService);

  /// Get User Details
  Future<Response> getUserDetails(Request request) async {
    try {
      final currentUser = request.headers[sysValCurrentUser];
      if (currentUser == null) {
        throw ApplicationException('User not logged in');
      }
      var json = await userService.getUserDetails(currentUser);
      return Response(200, body: json.toJson());
    } on UnauthorizedException catch (error) {
      return Response(401, body: error.report.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Update User Details
  Future<Response> updateUserDetails(Request request) async {
    final body = await request.readAsString();
    final Map<String, dynamic> data = json.decode(body);

    var errors = validateUserUpdate(data['user']);
    if (errors.isNotEmpty()) {
      return Response(422, body: errors.toJson());
    }

    try {
      final currentUser = request.headers[sysValCurrentUser];
      var json = await userService.updateUserDetails(data['user'], currentUser);
      return Response(200, body: json.toJson());
    } on UnauthorizedException catch (error) {
      return Response(401, body: error.report.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Handler
  Handler get handler {
    final _handler = Router()
      ..get('/', (Request request) => getUserDetails(request))
      ..put('/', (Request request) => updateUserDetails(request));
    return _handler;
  }

  /// Validate User Details
  ErrorReport validateUserDetails(dynamic user) {
    if (user == null) {
      return ErrorReport.singleError('user is required');
    }
    var report = ErrorReport();

    if (user['email'] == null) {
      report.addError('email is required');
    }
    if (user['username'] == null) {
      report.addError('username is required');
    }
    return report;
  }

  /// Validate User for Update
  ErrorReport validateUserUpdate(dynamic user) {
    if (user == null) {
      return ErrorReport.singleError('user is required');
    }
    var report = ErrorReport();
    if (user['email'] == null && user['bio'] == null && user['image'] == null) {
      report.addError('At least one element [email,bio,image] is required');
    }
    return report;
  }
}
