import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../service/tag_service.dart';

class TagsApi {
  final TagService tagService;

  TagsApi(this.tagService);

  /// Get Tag List
  Future<Response> getTagList(Request request) async {
    try {
      var json = await tagService.getTags();
      return Response(200, body: json.toJson());
    } catch (error) {
      print(error);
      return Response(422);
    }
  }

  /// Handler
  Handler get handler {
    final _handler = Router()..get('/', (Request request) => getTagList(request));
    return _handler;
  }
}
