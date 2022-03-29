import 'package:mongo_dart/mongo_dart.dart';

import '../config/mongo_config.dart';
import '../model/tag_model.dart';

class TagService {
  final Db db;

  TagService(this.db);

  /// Get Tags
  Future<TagList> getTags() async {
    var col = db.collection(MongoCollection.article);
    var check = await col.modernFind(projection: {'tagList': 1}).toList();
    var set = <String>{};
    for (var tags in check) {
      set.addAll(Set<String>.from(tags['tagList']));
    }
    var rtn = TagList();
    rtn.tagList.addAll(set);
    return rtn;
  }
}
