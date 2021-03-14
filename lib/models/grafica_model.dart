class Grafica {
  String producto;
  int cantidad;

  Grafica({this.producto, this.cantidad});

  factory Grafica.fromMap(Map map) => Grafica(
        cantidad: map['cantidad'],
        producto: map['nombre'],
      );

  static List fromMapList(List list) =>
      list.map((e) => Grafica.fromMap(e)).toList();
}
