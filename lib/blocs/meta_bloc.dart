import 'dart:async';

import 'package:roghurapp/models/meta_model.dart';
import 'package:roghurapp/providers/meta_provider.dart';

class MetaBloc {
  static final _intance = new MetaBloc._internal();
  final _metaStreamController =
      new StreamController<List<MetaModel>>.broadcast();
  final _metaProvider = new MetaProvider();

  MetaBloc._internal();
  factory MetaBloc() => _intance;

  void disponse() {
    _metaStreamController.close();
  }

  Stream<List<MetaModel>> get metaStream => this._metaStreamController.stream;

  set metaAdd(List<MetaModel> metas) =>
      this._metaStreamController.sink.add(metas);

  void getAll() async {
    try {
      metaAdd = await _metaProvider.getAll();
    } catch (e) {
      _metaStreamController.addError(new Exception(e.message));
    }
  }

  create(MetaModel meta) async {
    final res = await _metaProvider.create(meta);
    getAll();
    return res;
  }

  delete(int id) async {
    final res = await _metaProvider.delete(id);
    getAll();
    return res;
  }
}
