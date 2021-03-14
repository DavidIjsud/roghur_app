import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:roghurapp/constants/common_text.dart';
import 'package:roghurapp/constants/data.dart';
import 'package:roghurapp/constants/ui.dart';
import 'package:roghurapp/models/categoria_model.dart';
import 'package:roghurapp/models/grafica_model.dart';
import 'package:roghurapp/providers/categoria_provider.dart';
import 'package:roghurapp/providers/graph_provider.dart';
import 'package:roghurapp/utils/utils.dart';
import 'package:roghurapp/widgets/ButtonCustom.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PrediccionPage extends StatefulWidget {
  static final routeName = 'prediccion';

  @override
  _PrediccionPageState createState() => _PrediccionPageState();
}

class _PrediccionPageState extends State<PrediccionPage> {
  List<CategoriaModel> _categorias = [];
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GraphProvider _graphProvider = new GraphProvider();
  ProgressDialog _pr;
  int _categoriaId;
  int _cantidad;
  List<Grafica> _datosGrafica;
  final _categoriaProvider = new CategoriaProvider();

  @override
  void initState() {
    _pr = ProgressDialog(context, isDismissible: false);
    _pr.style(message: CommonText.wait);
    // _categorias = CategoriaModel.fromMapList(categoriasData);
    _categoriaProvider
        .getAll()
        .then((value) => setState(() => _categorias = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Predicción compra'),
      ),
      body: Column(
        children: [
          _form(),
          if (_datosGrafica != null) Expanded(child: _barChart()),
        ],
      ),
    );
  }

  Widget _form() {
    return Container(
      padding: EdgeInsets.only(
          right: UI.padding, left: UI.padding, bottom: UI.padding),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 5,
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    value: _categoriaId,
                    decoration: InputDecoration(
                        labelText: 'Categoria',
                        contentPadding: EdgeInsets.symmetric(vertical: 10)),
                    items: [
                      ..._categorias.map((e) => DropdownMenuItem(
                            child: Text(
                              e.nombre,
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: e.id,
                          ))
                    ],
                    onChanged: (value) => _categoriaId = value,
                    validator: (value) {
                      if (value != null) return null;
                      return 'Es obligatorio';
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 5,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Cantidad meses'),
                    validator: (value) {
                      if (isNumber(value)) return null;
                      return 'Es un numero';
                    },
                    onSaved: (value) => _cantidad = num.parse(value),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ButtonCustom(title: CommonText.search, onPressed: _handleSearch)
          ],
        ),
      ),
    );
  }

  Widget _barChart() {
    final List<charts.Series<Grafica, String>> seriesBarchart = [];
    seriesBarchart.add(new charts.Series(
      id: 'compra',
      data: _datosGrafica,
      domainFn: (Grafica pre, _) => pre.producto,
      measureFn: (Grafica pre, _) => pre.cantidad,
      fillColorFn: (pre, _) =>
          charts.ColorUtil.fromDartColor(Theme.of(context).accentColor),
      labelAccessorFn: (pre, index) => '${pre.cantidad} u.',
    ));

    return Container(
      padding: EdgeInsets.all(UI.padding),
      child: charts.BarChart(
        seriesBarchart,
        defaultRenderer: charts.BarRendererConfig(
            barRendererDecorator: charts.BarLabelDecorator()),
      ),
    );
  }

  void _handleSearch() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    _pr.show();
    try {
      final res =
          await _graphProvider.compraByCategoria(_categoriaId, _cantidad);
      setState(() => _datosGrafica = Grafica.fromMapList(res['data']));
      showMessage(_scaffoldKey, res['message']);
    } catch (e) {
      showMessage(_scaffoldKey, e.message);
    } finally {
      _pr.hide();
    }
  }
}
