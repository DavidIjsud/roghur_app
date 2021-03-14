import 'package:roghurapp/constants/fecha.dart';
import 'package:roghurapp/models/producto_model.dart';

class MetaModel {
  int id;
  int mes;
  int year;
  int cantidad;
  ProductoModel producto;
  int productoId;

  MetaModel({
    this.id,
    this.mes,
    this.year,
    this.cantidad,
    this.producto,
  });

  factory MetaModel.fromMap(dynamic map) => MetaModel(
      id: map['id'],
      mes: map['mes'],
      year: map['year'],
      cantidad: map['cantidad'],
      producto: ProductoModel.fromMap(map['producto']));

  static List<MetaModel> fromMapList(List list) =>
      list.map((e) => MetaModel.fromMap(e)).toList();

  String get mesName => meses[this.mes - 1];

  Map<String, dynamic> toJson() => {
        'mes': mes,
        'year': year,
        'cantidad': cantidad,
        'producto_id': productoId,
      };
}
