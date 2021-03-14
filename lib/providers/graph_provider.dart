import 'package:roghurapp/constants/api.dart';
import 'package:roghurapp/constants/fetch.dart';
import 'package:roghurapp/models/best_request.dart';

class GraphProvider {
  Future<Map> getStock(int id) async {
    return await Fetch.get(Api.setParam(Api.stock, id));
  }

  Future<Map> metaGraph(int id) async {
    final resp = await Fetch.post(Api.metaAlcanzada, {'id': id});
    return resp['data'];
  }

  Future<Map> compraByCategoria(int id, int cantidad) async {
    print(cantidad);
    return await Fetch.get(
        '${Api.setParam(Api.compraByCategoria, id)}?meses=$cantidad');
  }

  Future<Map> top(BestRequest best) async {
    return await Fetch.post(Api.top, best);
  }
}
