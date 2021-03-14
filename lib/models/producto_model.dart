class ProductoModel {
  int id;
  String nombre;
  String descripcion;
  double precio;
  int stock;

  ProductoModel({
    this.id,
    this.nombre,
    this.descripcion,
    this.precio,
    this.stock,
  });

  factory ProductoModel.fromMap(dynamic map) => ProductoModel(
        id: map['id'],
        nombre: map['nombre'],
        descripcion: map['descripcion'],
        precio: double.parse('${map['precio']}'),
        stock: map['stock'],
      );

  String get initialName => nombre.substring(0, 1).toUpperCase();

  static List<ProductoModel> fromMapList(List list) =>
      list.map((e) => ProductoModel.fromMap(e)).toList();
}
