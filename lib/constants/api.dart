class Api {
  //static final host = 'http://192.168.0.12:8080/roghur-server/public/api';
  static final host = 'http://safe-sands-31125.herokuapp.com/api';
  static final login = '$host/movil/auth/login';
  static final productoListar = '$host/movil/producto';
  static final categoriaListar = '$host/movil/categoria';
  static final metaListar = '$host/movil/meta';
  static final metaEditar = '$host/movil/meta/:id';
  static final metaAlcanzada = '$host/movil/meta_graph';
  static final compraByCategoria = '$host/movil/compra_grahp/:id';
  static final stock = '$host/movil/stock/:id';
  static final top = '$host/movil/top';

  static String setParam(String path, dynamic value) {
    return path.replaceAll(':id', '$value');
  }
}
