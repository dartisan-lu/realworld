import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import 'environment_config.dart';
import 'system_values.dart';

class ApiMiddlewareConfig {
  late final String tokenSecret;

  ApiMiddlewareConfig(EnvironmentConfig environmentConfig) {
    tokenSecret = environmentConfig.tokenSecrect;
  }

  /// JSON Header
  Middleware jsonHeader() => (innerHandler) {
        return (request) async {
          final response = await innerHandler(request);
          final contentTypeJson = {'content-type': 'application/json; charset=utf-8'};
          return response.change(headers: {...response.headersAll, ...contentTypeJson});
        };
      };

  /// Logging
  Middleware logging() => (innerHandler) {
        return (request) async {
          print('API LOGGING: ${request.method} ${request.url}');
          return innerHandler(request);
        };
      };

  /// Security
  Middleware security() => (innerHandler) {
        return (request) async {
          var headers = Map.from(request.headers);
          headers.remove(sysValCurrentUser);
          if (headers['authorization'] != null) {
            try {
              final token = (headers['authorization'] as String).substring(6);
              final jwt = JWT.verify(token, SecretKey(tokenSecret));
              headers.putIfAbsent(sysValCurrentUser, () => jwt.payload);
              var secured = request.change(headers: {...headers});
              return innerHandler(secured);
            } on JWTExpiredError {
              print('JWT Expired ');
            } on JWTError catch (ex) {
              print(ex.message);
            }
          }
          return innerHandler(request);
        };
      };
}
