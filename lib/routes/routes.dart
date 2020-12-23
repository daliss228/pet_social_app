import 'package:flutter/material.dart';
import 'package:pet_social_app/pages/auth/auth_page.dart';
import 'package:pet_social_app/pages/home/home_page.dart';
import 'package:pet_social_app/pages/image/photo_page.dart';

Map<String, WidgetBuilder> routes() {
  return <String, WidgetBuilder> {
    'home': (BuildContext context) => HomePage(),
    'auth': (BuildContext context) => AuthPage(),
    'photo': (BuildContext context) => PhotoPage()
  };
}