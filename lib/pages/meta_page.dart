import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:roghurapp/blocs/meta_bloc.dart';
import 'package:roghurapp/constants/common_text.dart';
import 'package:roghurapp/constants/ui.dart';
import 'package:roghurapp/models/meta_model.dart';
import 'package:roghurapp/pages/meta_create_page.dart';
import 'package:roghurapp/pages/meta_grafica_page.dart';
// import 'package:roghurapp/providers/meta_provider.dart';
import 'package:roghurapp/utils/utils.dart';
import 'package:roghurapp/widgets/ErrorCustom.dart';

class MetaPage extends StatelessWidget {
  static final routeName = 'meta';
  // final MetaProvider _metaProvider = new MetaProvider();
  final MetaBloc _metaBloc = new MetaBloc();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _metaBloc.getAll();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Meta'),
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: () {})],
      ),
      body: _metaGet(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed(MetaCreate.routeName),
      ),
    );
  }

  Widget _metaGet() {
    return StreamBuilder(
      stream: _metaBloc.metaStream,
      builder: (BuildContext context, AsyncSnapshot<List<MetaModel>> snapshot) {
        if (snapshot.hasData) {
          final metas = snapshot.data;
          if (metas.isEmpty) return ErrorCustom(message: CommonText.noData);
          return _metaList(snapshot.data);
        }
        if (snapshot.hasError)
          return ErrorCustom(message: (snapshot.error as dynamic).message);
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _metaList(List<MetaModel> metas) {
    // final metas = MetaModel.fromMapList(metaData);

    return ListView.builder(
      itemCount: metas.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onLongPress: () => _showDeleteDialog(metas[index], context),
            onTap: () => Navigator.of(context)
                .pushNamed(MetaGraficaPage.routeName, arguments: metas[index]),
            child: _metaBox(metas[index], context));
      },
    );
  }

  Widget _metaBox(MetaModel meta, BuildContext context) {
    final styleTitle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.4);
    return Container(
      padding: EdgeInsets.symmetric(vertical: UI.padding),
      margin: EdgeInsets.symmetric(horizontal: UI.margin),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey[300], width: 0.5))),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            radius: 27,
            child: Text(
              meta.producto.initialName,
              style: styleTitle,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meta.producto.nombre,
                  style: styleTitle,
                ),
                Text(
                  '${meta.cantidad} u.',
                  style: TextStyle(height: 1.4),
                )
              ],
            ),
          ),
          Spacer(),
          Chip(
            label: Text(
              meta.mesName,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).accentColor,
          ),
          SizedBox(
            width: 5,
          ),
          Chip(label: Text('${meta.year}'))
        ],
      ),
    );
  }

  void _showDeleteDialog(MetaModel meta, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar'),
        content: Text('¿Esta seguro de eliminarlo?'),
        actions: [
          FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: () => Navigator.of(context).pop(),
              child: Text(CommonText.close)),
          FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
                _deleteMeta(meta, context);
              },
              child: Text(CommonText.accept))
        ],
      ),
    );
  }

  void _deleteMeta(MetaModel meta, BuildContext context) async {
    final pr = ProgressDialog(context, isDismissible: false);
    pr.style(message: CommonText.wait);
    pr.show();
    try {
      final res = await _metaBloc.delete(meta.id);
      showMessage(_scaffoldKey, res['message']);
    } catch (e) {
      showMessage(_scaffoldKey, e.message);
    } finally {
      pr.hide();
    }
  }
}
