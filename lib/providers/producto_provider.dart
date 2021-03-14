import 'package:roghurapp/constants/api.dart';
import 'package:roghurapp/constants/fetch.dart';
import 'package:roghurapp/models/producto_model.dart';

class ProductoProvider {
  Future<List<ProductoModel>> getAll() async {
    final resp = await Fetch.get(Api.productoListar);
    return ProductoModel.fromMapList(resp['data']);
  }
}
