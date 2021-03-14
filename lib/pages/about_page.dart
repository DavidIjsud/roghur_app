import 'package:flutter/material.dart';
import 'package:roghurapp/constants/path.dart';
import 'package:roghurapp/constants/ui.dart';

class AboutPage extends StatelessWidget {
  static final routeName = 'about';
  final bodyStyle = TextStyle(fontSize: 16, height: 1.4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
      ),
      body: Container(
        padding: EdgeInsets.all(UI.padding),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                Path.logo,
                height: 70,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Version: 1.0.0'),
            SizedBox(
              height: 20,
            ),
            Text(
              'RoghurApp es una aplicacion que te permite registrar las metas que tienes por mes para las ventas, tambien te permite ver los productos mas vendidos y predecir las compras.',
              style: bodyStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Desarollado por: CODEMON',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
