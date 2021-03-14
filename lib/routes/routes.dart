import 'package:flutter/material.dart';
import 'package:roghurapp/pages/about_page.dart';
import 'package:roghurapp/pages/best_page.dart';
import 'package:roghurapp/pages/disponible_page.dart';
import 'package:roghurapp/pages/home_page.dart';
import 'package:roghurapp/pages/login_page.dart';
import 'package:roghurapp/pages/meta_create_page.dart';
import 'package:roghurapp/pages/meta_grafica_page.dart';
import 'package:roghurapp/pages/meta_page.dart';
import 'package:roghurapp/pages/prediccion_page.dart';

Map<String, WidgetBuilder> routes = {
  HomePage.routeName: (_) => HomePage(),
  MetaPage.routeName: (_) => MetaPage(),
  MetaGraficaPage.routeName: (_) => MetaGraficaPage(),
  MetaCreate.routeName: (_) => MetaCreate(),
  PrediccionPage.routeName: (_) => PrediccionPage(),
  DisponiblePage.routeName: (_) => DisponiblePage(),
  BestPage.routeName: (_) => BestPage(),
  AboutPage.routeName: (_) => AboutPage(),
  LoginPage.routeName: (_) => LoginPage(),
};
