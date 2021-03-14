import 'package:flutter/material.dart';
import 'package:roghurapp/pages/login_page.dart';
import 'package:roghurapp/routes/routes.dart';
import 'package:roghurapp/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roghur App',
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: LoginPage.routeName,
      routes: routes,
    );
  }
}
