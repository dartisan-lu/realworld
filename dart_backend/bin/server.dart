import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

import 'config/api_middleware_config.dart';
import 'config/api_route_config.dart';
import 'config/environment_config.dart';
import 'config/mongo_config.dart';
import 'config/service_config.dart';

void main(List<String> arguments) async {
  final environmentConfig = EnvironmentConfig();
  final mongoConfig = MongoConfig(environmentConfig);
  final serviceConfig = ServiceConfig(mongoConfig.getConnection(), environmentConfig);
  final apiConfig = ApiRouteConfig(serviceConfig);
  final apiMiddleware = ApiMiddlewareConfig(environmentConfig);

  var handlerPipeline = Pipeline()
      .addMiddleware(apiMiddleware.logging())
      .addMiddleware(apiMiddleware.security())
      .addMiddleware(corsHeaders())
      .addMiddleware(apiMiddleware.jsonHeader())
      .addHandler(apiConfig.handler);

  final server = await io.serve(handlerPipeline, environmentConfig.webServer, environmentConfig.webPort);
  print('API Service: http://${server.address.host}:${server.port}/api');
}
