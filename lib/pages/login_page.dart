import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:roghurapp/constants/common_text.dart';
import 'package:roghurapp/constants/path.dart';
import 'package:roghurapp/constants/ui.dart';
import 'package:roghurapp/models/usuario_model.dart';
import 'package:roghurapp/pages/home_page.dart';
import 'package:roghurapp/pages/meta_create_page.dart';
import 'package:roghurapp/providers/auth_provider.dart';
import 'package:roghurapp/utils/utils.dart';
import 'package:roghurapp/widgets/ButtonCustom.dart';

class LoginPage extends StatelessWidget {
  static final routeName = 'login';
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();
  final _user =
      new UsuarioModel(email: 'admin@gmail.com', password: 'admin123');
  final _authProvider = new AuthProvider();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
            children: [
              _logoContent(size),
              _formContent(context),
              Expanded(child: _textContent(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoContent(Size size) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.all(UI.padding),
      height: size.height * 0.4,
      child: SafeArea(
        child: Image.asset(
          Path.logo,
          height: 40.0,
          width: size.width * 0.8,
        ),
      ),
    );
  }

  Widget _formContent(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        // color: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: UI.paddingError),
        child: Column(
          children: [
            TextFormField(
              initialValue: _user.email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
              validator: (value) {
                if (isEmail(value)) return null;
                return 'Debe ser un email';
              },
              onSaved: (newValue) => _user.email = newValue,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: _user.password,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Contraseña',
                  prefixIcon: Icon(Icons.lock_outlined)),
              validator: (value) {
                if (value.length >= 6) return null;
                return 'Minimo 6 caracteres';
              },
              onSaved: (newValue) => _user.password = newValue,
            ),
            SizedBox(
              height: 40,
            ),
            ButtonCustom(
                title: CommonText.login, onPressed: () => _handleLogin(context))
          ],
        ),
      ),
    );
  }

  Widget _textContent(BuildContext context) {
    return Container(
      // color: Colors.green,
      alignment: Alignment.center,
      child: Text(
        '¿Haz olvidado tu contraseña?',
        style: TextStyle(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),
      ),
    );
  }

  void _handleLogin(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    final pr = ProgressDialog(context, isDismissible: false);
    pr.style(message: CommonText.wait);
    pr.show();
    try {
      final res = await _authProvider.login(_user);
      pr.hide();
      showMessage(_scaffoldKey, res['message']);
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } catch (e) {
      Future.delayed(Duration(milliseconds: 200), () => pr.hide());
      showMessage(_scaffoldKey, e.message);
    }
  }
}
