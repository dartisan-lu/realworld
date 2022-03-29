import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../exception/user_exceptions.dart';
import '../model/error_model.dart';
import '../model/user_model.dart';
import '../service/user_service.dart';

class UsersApi {
  final UserService userService;

  UsersApi(this.userService);

  /// Create User
  Future<Response> createUser(Request request) async {
    final body = await request.readAsString();
    final data = json.decode(body);

    var errors = validateUserRegister(data['user']);
    if (errors.isNotEmpty()) {
      return Response(422, body: errors.toJson());
    }

    try {
      final user = UserRegister.fromMap(data['user']);
      var json = await userService.createUser(user);
      return Response(200, body: json.toJson());
    } on UserCreationException catch (error) {
      return Response(422, body: error.report.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Login User
  Future<Response> loginUser(Request request) async {
    final body = await request.readAsString();
    final data = json.decode(body);

    var errors = validateUserLogin(data['user']);
    if (errors.isNotEmpty()) {
      return Response(422, body: errors.toJson());
    }

    try {
      final user = UserLogin.fromMap(data['user']);
      var json = await userService.login(user);
      return Response(200, body: json.toJson());
    } on UserLoginException catch (error) {
      return Response(422, body: error.report.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Handler
  Handler get handler {
    final _handler = Router()
      ..post('/', (Request request) => createUser(request))
      ..post('/login', (Request request) => loginUser(request));
    return _handler;
  }

  /// Validate User for Registration
  ErrorReport validateUserRegister(dynamic user) {
    if (user == null) {
      return ErrorReport.singleError('user is required');
    }
    var report = ErrorReport();

    if (user['username'] == null) {
      report.addError('username is required');
    }
    if (user['email'] == null) {
      report.addError('email is required');
    }
    if (user['password'] == null) {
      report.addError('password is required');
    }
    return report;
  }

  /// Validate User for Registration
  ErrorReport validateUserLogin(dynamic user) {
    if (user == null) {
      return ErrorReport.singleError('user is required');
    }
    var report = ErrorReport();

    if (user['email'] == null) {
      report.addError('email is required');
    }
    if (user['password'] == null) {
      report.addError('password is required');
    }
    return report;
  }
}
