import 'package:roghurapp/constants/api.dart';
import 'package:roghurapp/constants/fetch.dart';
import 'package:roghurapp/models/usuario_model.dart';

class AuthProvider {
  Future<Map> login(UsuarioModel usuario) async {
    return await Fetch.post(Api.login, usuario.toJsonLogin());
  }
}
