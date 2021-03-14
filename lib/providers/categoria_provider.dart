import 'package:roghurapp/constants/api.dart';
import 'package:roghurapp/constants/fetch.dart';
import 'package:roghurapp/models/categoria_model.dart';

class CategoriaProvider {
  Future<List<CategoriaModel>> getAll() async {
    final resp = await Fetch.get(Api.categoriaListar);
    return CategoriaModel.fromMapList(resp['data']);
  }
}
