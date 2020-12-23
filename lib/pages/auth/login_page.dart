import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_social_app/theme/theme.dart';
import 'package:pet_social_app/utils/loader.dart';
import 'package:pet_social_app/utils/responsive.dart';
import 'package:pet_social_app/widgets/alert_widget.dart';
import 'package:pet_social_app/widgets/button_widget.dart';
import 'package:pet_social_app/widgets/loading_widget.dart';
import 'package:pet_social_app/providers/auth_provider.dart';
import 'package:pet_social_app/widgets/textfield_widget.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveScreen(context);
    return Scaffold(
      backgroundColor: MyTheme.blue,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: responsive.ip(5.0)),
                      child: Column(
                        children: [
                          SizedBox(height: responsive.hp(7.0)),
                          SvgPicture.asset('assets/svg/loving_it.svg', height: responsive.ip(25.0)),
                          Text('Login', style: TextStyle(fontSize: responsive.ip(6.0), fontFamily: 'BalooThambi2SemiBold', color: MyTheme.pink))
                        ],
                      ),
                    ),
                    Consumer<AuthProvider>(builder: (context, provider, child) {
                      return TextFieldWidget(
                        hintText: 'Ingrese su email',
                        errorText: provider.email.error,
                        icon: Icons.account_circle_outlined,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (String value) => provider.changeEmail(value)
                      );
                    }),
                    Consumer<AuthProvider>(builder: (context, provider, child) {
                      return TextFieldWidget(
                        suffixIcon: true,
                        obscureText: true,
                        hintText: 'Ingrese su contraseña',
                        errorText: provider.password.error,
                        icon: Icons.lock_outline,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (String value) => provider.changePassword(value)
                      );
                    }),
                    Consumer<AuthProvider>(builder: (context, provider, child) {
                      return ButtonWidget(
                        text: 'Iniciar Sesión',
                        onPressed: (provider.isValidLogin) 
                        ? () async {
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                          final result = await provider.handleLogin();
                          if (result.status) {
                            Navigator.pushReplacementNamed(context, 'home');
                          } else {
                            provider.viewState = ViewState.Idle;
                            showAlert(context, 'Ups!', result.message, Icons.sentiment_dissatisfied);
                          }
                        }
                        : () {}
                      );
                    }),
                    Consumer<AuthProvider>(builder: (context, provider, child) {
                      return RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: '¿No tienes una cuenta?  ', style: TextStyle(fontSize: responsive.ip(1.9), fontFamily: 'BalooThambi2Regular', color: Colors.white)),
                            TextSpan(text: 'Regístrate!', style: TextStyle(fontSize: responsive.ip(2.0), fontFamily: 'BalooThambi2SemiBold', color: Colors.white),
                              recognizer: TapGestureRecognizer()
                              ..onTap = () => provider.setPageController(1)
                            ),
                          ]
                        )
                      );
                    })
                  ],
                ),
              ),
            ),
            Consumer<AuthProvider>(builder: (context, provider, child) {
              return provider.viewState == ViewState.Busy 
              ? LoadingWidget()
              : Container();
            })
          ],
        ),
      ),
    );
  }
}