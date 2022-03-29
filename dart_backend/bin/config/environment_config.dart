import 'package:dotenv/dotenv.dart' show load, env;

class EnvironmentConfig {
  late final String tokenSecrect;
  late final String webServer;
  late final int webPort;
  late final String mongoUrl;
  late final String mongoCollection;

  EnvironmentConfig() {
    load();
    tokenSecrect = env['token.secret']!;
    webServer = env['server.url']!;
    webPort = int.parse(env['server.port']!);
    mongoUrl = env['mongo.url']!;
    mongoCollection = env['mongo.collection']!;
  }
}
