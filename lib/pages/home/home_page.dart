import 'package:flutter/material.dart';
import 'package:pet_social_app/services/auth_sevice.dart';
import 'package:pet_social_app/theme/theme.dart';

class HomePage extends StatelessWidget {

  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () {
            _authService.signOut();
            Navigator.pushReplacementNamed(context, 'auth');
          },
          icon: Icon(Icons.close),
          color: MyTheme.pink,
        ),
      )
    );
  }
}