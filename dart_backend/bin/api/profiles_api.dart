import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../config/system_values.dart';
import '../exception/security_exceptions.dart';
import '../model/error_model.dart';
import '../service/user_service.dart';

class ProfilesApi {
  final UserService userService;

  ProfilesApi(this.userService);

  /// Get User Profile
  Future<Response> getUserProfile(Request request) async {
    try {
      final username = request.params['username'];
      if (username == null) {
        var errors = ErrorReport.singleError('username is required');
        return Response(422, body: errors.toJson());
      }

      var json = await userService.getUserProfile(username);
      return Response(200, body: json.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Follow User
  Future<Response> followUser(Request request) async {
    try {
      final username = request.params['username'];
      if (username == null) {
        var errors = ErrorReport.singleError('username is required');
        return Response(422, body: errors.toJson());
      }

      final currentUser = request.headers[sysValCurrentUser];
      var json = await userService.followUser(username, currentUser);
      return Response(200, body: json.toJson());
    } on UnauthorizedException catch (error) {
      return Response(401, body: error.report.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Unfollow User
  Future<Response> unfollowUser(Request request) async {
    try {
      final username = request.params['username'];
      if (username == null) {
        var errors = ErrorReport.singleError('username is required');
        return Response(422, body: errors.toJson());
      }

      final currentUser = request.headers[sysValCurrentUser];
      var json = await userService.unfollowUser(username, currentUser);
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
      ..get('/<username>', (Request request) => getUserProfile(request))
      ..post('/<username>/follow', (Request request) => followUser(request))
      ..delete('/<username>/follow', (Request request) => unfollowUser(request));
    return _handler;
  }
}
