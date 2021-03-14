import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:roghurapp/constants/common_text.dart';
import 'package:roghurapp/constants/ui.dart';
import 'package:roghurapp/models/producto_model.dart';
import 'package:roghurapp/providers/graph_provider.dart';
import 'package:roghurapp/providers/producto_provider.dart';
import 'package:roghurapp/utils/utils.dart';
import 'package:roghurapp/widgets/ButtonCustom.dart';
import 'package:roghurapp/widgets/ErrorCustom.dart';

class DisponiblePage extends StatefulWidget {
  static final routeName = 'disponible';

  @override
  _DisponiblePageState createState() => _DisponiblePageState();
}

class _DisponiblePageState extends State<DisponiblePage> {
  Future<List<ProductoModel>> _productos;
  final _formKey = new GlobalKey<FormState>();
  final ProductoProvider _productoProvider = new ProductoProvider();
  final GraphProvider _graphProvider = new GraphProvider();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  ProgressDialog _pr;
  int _productoId;
  int _stock;

  @override
  void initState() {
    // _productos = ProductoModel.fromMapList(productosData);
    _productos = _productoProvider.getAll();
    _pr = ProgressDialog(context, isDismissible: false);
    _pr.style(message: CommonText.wait);
    // .then((value) => setState(() => _productos = value))
    // .catchError((err) => showMessage(_scaffoldKey, err.message));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Disponible'),
      ),
      body: Column(
        children: [
          _getBuilder(),
          if (_stock != null) _resultadoContent(),
        ],
      ),
    );
  }

  Widget _getBuilder() {
    return FutureBuilder(
      future: _productos,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) return _form(snapshot.data);
        if (snapshot.hasError) {
          return ErrorCustom(message: (snapshot.error as dynamic).message);
        }
        return Expanded(child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _form(List<ProductoModel> productos) {
    return Container(
      padding: EdgeInsets.only(
          right: UI.padding, left: UI.padding, bottom: UI.padding),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField(
              isExpanded: true,
              value: _productoId,
              decoration: InputDecoration(labelText: 'Producto'),
              items: [
                ...productos.map((e) => DropdownMenuItem(
                      child: Text(e.nombre),
                      value: e.id,
                    ))
              ],
              onChanged: (value) => _productoId = value,
              validator: (value) {
                if (value != null) return null;
                return 'Es obligatorio';
              },
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

  Widget _resultadoContent() {
    final textStyle =
        TextStyle(fontSize: 24, fontWeight: FontWeight.w500, height: 1.4);
    final stockStyle = TextStyle(fontSize: 20, height: 1.4);
    final isDisponible = _stock > 0 ? true : false;
    return Container(
      padding: EdgeInsets.all(UI.padding),
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isDisponible ? 'Disponible' : 'No Disponible :(',
            style: textStyle,
          ),
          Text(
            '$_stock u.',
            style: stockStyle,
          ),
        ],
      ),
    );
  }

  void _handleSearch() async {
    if (!_formKey.currentState.validate()) return;
    _pr.show();
    try {
      final res = await _graphProvider.getStock(_productoId);
      setState(() => _stock = res['data']);
      showMessage(_scaffoldKey, res['message']);
    } catch (e) {
      showMessage(_scaffoldKey, e.message);
    } finally {
      _pr.hide();
    }
  }
}
