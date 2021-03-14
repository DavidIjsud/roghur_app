import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:roghurapp/blocs/meta_bloc.dart';
import 'package:roghurapp/constants/common_text.dart';
import 'package:roghurapp/constants/fecha.dart';
import 'package:roghurapp/constants/ui.dart';
import 'package:roghurapp/models/meta_model.dart';
import 'package:roghurapp/models/producto_model.dart';
import 'package:roghurapp/providers/producto_provider.dart';
import 'package:roghurapp/utils/utils.dart';
import 'package:roghurapp/widgets/ButtonCustom.dart';
import 'package:roghurapp/widgets/ErrorCustom.dart';

class MetaCreate extends StatefulWidget {
  static final routeName = 'metaCreate';

  @override
  _MetaCreateState createState() => _MetaCreateState();
}

class _MetaCreateState extends State<MetaCreate> {
  final _ahora = DateTime.now();
  final MetaModel _meta = new MetaModel();
  Future<List<ProductoModel>> _productos;
  final ProductoProvider _productoProvider = new ProductoProvider();
  // final MetaProvider _metaProvider = new MetaProvider();
  final MetaBloc _metaBloc = new MetaBloc();
  final _formKey = new GlobalKey<FormState>();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  ProgressDialog _pr;

  @override
  void initState() {
    _meta.year = _ahora.year;
    _meta.mes = _ahora.month;
    // _productos = ProductoModel.fromMapList(productosData);
    _productos = _productoProvider.getAll();
    _pr = ProgressDialog(context, isDismissible: false);
    _pr.style(message: CommonText.wait);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Crear Meta'),
      ),
      body: _getBuilder(),
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
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _form(List<ProductoModel> productos) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            left: UI.padding, right: UI.padding, bottom: UI.padding),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                  value: _meta.productoId,
                  decoration: InputDecoration(labelText: 'Producto'),
                  items: [
                    if (_productos != null)
                      ...productos.map((e) => DropdownMenuItem(
                            child: Text(e.nombre),
                            value: e.id,
                          )),
                  ],
                  onChanged: (value) => _meta.productoId = value,
                  validator: (value) {
                    if (value != null) return null;
                    return 'Es obligatorio';
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Cantidad (meta)'),
                  onSaved: (value) => _meta.cantidad = int.parse(value),
                  validator: (value) {
                    if (isNumber(value)) return null;
                    return 'Es obligatorio';
                  },
                ),
                DropdownButtonFormField(
                  value: _meta.mes,
                  decoration: InputDecoration(labelText: 'Mes'),
                  items: [
                    ...messesOptions.map((e) => DropdownMenuItem(
                          child: Text(e['option']),
                          value: e['value'],
                        ))
                  ],
                  onChanged: (value) => _meta.mes = value,
                  validator: (value) {
                    if (value != null) return null;
                    return 'Es obligatorio';
                  },
                ),
                DropdownButtonFormField(
                  value: _meta.year,
                  decoration: InputDecoration(labelText: 'Año'),
                  items: [
                    ...generateYears(5).map((e) => DropdownMenuItem(
                          child: Text('$e'),
                          value: e,
                        ))
                  ],
                  onChanged: (value) => _meta.mes = value,
                  validator: (value) {
                    if (value != null) return null;
                    return 'Es obligatorio';
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonCustom(title: CommonText.save, onPressed: _handleSave)
              ],
            )),
      ),
    );
  }

  List<int> generateYears(int count) {
    final List<int> years = [];
    for (var i = 0; i < count; i++) {
      years.add(_ahora.year + i);
    }
    print(years);
    return years;
  }

  void _handleSave() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    _pr.show();
    try {
      final res = await _metaBloc.create(_meta);
      showMessage(_scaffoldKey, res['message']);
      Navigator.of(context).pop();
    } catch (e) {
      showMessage(_scaffoldKey, e.message);
    } finally {
      _pr.hide();
    }
    print(_meta.toJson());
  }
}
