import 'package:flutter/material.dart';
import 'package:roghurapp/constants/ui.dart';
import 'package:roghurapp/pages/about_page.dart';
import 'package:roghurapp/pages/best_page.dart';
import 'package:roghurapp/pages/disponible_page.dart';
import 'package:roghurapp/pages/meta_page.dart';
import 'package:roghurapp/pages/prediccion_page.dart';
import 'package:roghurapp/theme/theme.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        actions: [
          PopupMenuButton(
            onSelected: (value) => _selectedMenu(value, context),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Perfil'), value: 1),
              PopupMenuItem(child: Text('Acerca de'), value: 2),
              PopupMenuItem(child: Text('Salir'), value: 3),
            ],
          )
        ],
      ),
      body: _menuContent(context),
    );
  }

  Widget _menuContent(BuildContext context) {
    return Container(
      child: Table(children: [
        TableRow(
          children: [
            _buttonBox(
                Icons.change_history, 'Meta', MetaPage.routeName, context),
            _buttonBox(Icons.graphic_eq, 'Predicción', PrediccionPage.routeName,
                context),
          ],
        ),
        TableRow(children: [
          _buttonBox(Icons.all_out_rounded, 'Disponible',
              DisponiblePage.routeName, context),
          _buttonBox(
              Icons.beenhere_sharp, 'Mejores', BestPage.routeName, context),
        ])
      ]),
    );
  }

  Widget _buttonBox(
      IconData icon, String title, String route, BuildContext context) {
    final styleTitle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(route),
      child: Container(
        margin: EdgeInsets.all(UI.margin),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryColor.withOpacity(0.3)),
        child: Column(
          children: [
            CircleAvatar(
              // backgroundColor: accentColor.withRed(10),
              radius: 27,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: styleTitle,
            )
          ],
        ),
      ),
    );
  }

  _selectedMenu(int value, BuildContext context) {
    switch (value) {
      case 2:
        return Navigator.of(context).pushNamed(AboutPage.routeName);
      default:
    }
  }
}
