import 'package:shelf/shelf.dart';
import 'package:shelf_router/src/router.dart';

import '../api/articles_api.dart';
import '../api/profiles_api.dart';
import '../api/tags_api.dart';
import '../api/user_api.dart';
import '../api/users_api.dart';
import 'service_config.dart';

class ApiRouteConfig {
  late final UsersApi _usersApi;
  late final UserApi _userApi;
  late final ProfilesApi _profilesApi;
  late final ArticlesApi _articlesApi;
  late final TagsApi _tagsApi;
  late final Router handler;

  ApiRouteConfig(ServiceConfig serviceConfig) {
    _userApi = UserApi(serviceConfig.userService);
    _usersApi = UsersApi(serviceConfig.userService);
    _profilesApi = ProfilesApi(serviceConfig.userService);
    _articlesApi =
        ArticlesApi(serviceConfig.articleService, serviceConfig.articleFavoriteService, serviceConfig.commentService);
    _tagsApi = TagsApi(serviceConfig.tagService);

    handler = Router()
      ..mount('/api/users', (request) => _usersApi.handler(request))
      ..mount('/api/user', (request) => _userApi.handler(request))
      ..mount('/api/profiles', (request) => _profilesApi.handler(request))
      ..mount('/api/articles', (request) => _articlesApi.handler(request))
      ..mount('/api/tags', (request) => _tagsApi.handler(request))
      ..mount('/api/health', (request) => Response.ok(DateTime.now().toString()));
  }
}
