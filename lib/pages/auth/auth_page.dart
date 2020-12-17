import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_social_app/theme/theme.dart';
import 'package:pet_social_app/pages/auth/login_page.dart';
import 'package:pet_social_app/providers/auth_provider.dart';
import 'package:pet_social_app/pages/auth/register_page.dart';

class AuthPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.blue,
      body: ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(builder: (context, provider, child) {
          return PageView(
            physics: BouncingScrollPhysics(),
            controller: provider.pageController,
            children: [
              LoginPage(),
              RegisterPage()
            ],
          );
        }),
      ),
    );
  }
  
}