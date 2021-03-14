class CategoriaModel {
  int id;
  String nombre;

  CategoriaModel({
    this.id,
    this.nombre,
  });

  factory CategoriaModel.fromMap(Map map) => CategoriaModel(
        id: map['id'],
        nombre: map['nombre'],
      );

  static List<CategoriaModel> fromMapList(List list) =>
      list.map((e) => CategoriaModel.fromMap(e)).toList();
}
