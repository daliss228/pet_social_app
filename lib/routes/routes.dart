import 'package:flutter/material.dart';
import 'package:pet_social_app/pages/auth/auth_page.dart';
import 'package:pet_social_app/pages/home/home_page.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder> {
    'auth': (BuildContext context) => AuthPage(),
    'home': (BuildContext context) => HomePage()
  };
}