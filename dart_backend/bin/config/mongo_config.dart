import 'package:mongo_dart/mongo_dart.dart';

import 'environment_config.dart';

class MongoConfig {
  EnvironmentConfig environmentConfig;

  MongoConfig(this.environmentConfig);

  /// Connection Driver
  Db getConnection() {
    var rtn = Db(environmentConfig.mongoUrl)
      ..collection(environmentConfig.mongoCollection)
      ..open();
    print('Mongo DB [${environmentConfig.mongoUrl}] connected...');
    return rtn;
  }
}

/// Collection Constants
class MongoCollection {
  static const user = 'USER';
  static const article = 'ARTICLE';
  static const comment = 'COMMENT';
}
