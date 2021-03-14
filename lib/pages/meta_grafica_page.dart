import 'package:flutter/material.dart';
import 'package:roghurapp/models/meta_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:roghurapp/providers/graph_provider.dart';
import 'package:roghurapp/widgets/ErrorCustom.dart';

class MetaGraficaPage extends StatelessWidget {
  static final routeName = 'metaGrafica';
  final GraphProvider _graphProvider = new GraphProvider();

  @override
  Widget build(BuildContext context) {
    final MetaModel meta = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Grafica'),
      ),
      body: _chartGet(meta),
    );
  }

  Widget _chartGet(MetaModel meta) {
    return FutureBuilder(
      future: _graphProvider.metaGraph(meta.id),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) return _pieChart(snapshot.data, meta);
        if (snapshot.hasError) {
          return ErrorCustom(message: (snapshot.error as dynamic).message);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _pieChart(Map res, MetaModel meta) {
    List<charts.Series<MetaGraph, String>> seriesPieChart = [];
    int cantidad = res['cantidad'] ?? 0;
    final diferencia = meta.cantidad - cantidad;
    final data = [
      MetaGraph(tipo: 'vendido', cantidad: cantidad),
      MetaGraph(tipo: 'faltante', cantidad: diferencia < 0 ? 0 : diferencia),
    ];
    final int total = gettotal(data);

    seriesPieChart.add(new charts.Series(
        id: 'piechart',
        data: data,
        domainFn: (MetaGraph met, _) => met.tipo,
        measureFn: (MetaGraph met, _) => met.cantidad,
        labelAccessorFn: (MetaGraph met, _) =>
            '${((met.cantidad / total) * 100).round()}%'));

    return Container(
      child: charts.PieChart(
        seriesPieChart,
        behaviors: [charts.DatumLegend()],
        defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [
          charts.ArcLabelDecorator(
              insideLabelStyleSpec:
                  charts.TextStyleSpec(fontSize: 16, color: charts.Color.white))
        ]),
      ),
    );
  }

  int gettotal(List<MetaGraph> list) {
    int total = 0;
    list.forEach((element) => total += element.cantidad);
    return total;
  }
}

class MetaGraph {
  String tipo;
  int cantidad;

  MetaGraph({this.tipo, this.cantidad});
}
