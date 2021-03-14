import 'package:roghurapp/constants/api.dart';
import 'package:roghurapp/constants/fetch.dart';
import 'package:roghurapp/models/meta_model.dart';

class MetaProvider {
  Future<List<MetaModel>> getAll() async {
    final res = await Fetch.get(Api.metaListar);
    return MetaModel.fromMapList(res['data']);
  }

  Future<Map> create(MetaModel meta) async {
    return await Fetch.post(Api.metaListar, meta);
  }

  Future<Map> delete(int id) async {
    return await Fetch.delete(Api.setParam(Api.metaEditar, id));
  }
}
