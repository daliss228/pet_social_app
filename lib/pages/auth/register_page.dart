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

class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
                      padding: EdgeInsets.symmetric(vertical: responsive.ip(3.0)),
                      child: Column(
                        children: [
                          SizedBox(height: responsive.hp(4.0)),
                          SvgPicture.asset('assets/svg/relaxing_walk.svg', height: responsive.ip(18.0)),
                          Text('Registro', style: TextStyle(fontSize: responsive.ip(6.0), fontFamily: 'BalooThambi2SemiBold', color: MyTheme.pink))
                        ],
                      ),
                    ),
                    Consumer<AuthProvider>(builder: (context, provider, child) {
                      return TextFieldWidget(
                        hintText: 'Ingrese su nombre',
                        errorText: provider.name.error,
                        icon: Icons.account_circle_outlined,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (String value) => provider.changeName(value)
                      );
                    }),
                    Consumer<AuthProvider>(builder: (context, provider, child) {
                      return TextFieldWidget(
                        hintText: 'Ingrese su apellido',
                        errorText: provider.lastname.error,
                        icon: Icons.account_circle_outlined,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (String value) => provider.changeLastname(value)
                      );
                    }),
                    Consumer<AuthProvider>(builder: (context, provider, child) {
                      return TextFieldWidget(
                        hintText: 'Ingrese su email',
                        errorText: provider.email.error,
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (String value) => provider.changeEmail(value)
                      );
                    }),
                    Consumer<AuthProvider>(builder: (context, provider, child) {
                      return TextFieldWidget(
                        suffixIcon: true,
                        obscureText: true,
                        hintText: 'Ingrese una contraseña',
                        errorText: provider.password.error,
                        icon: Icons.lock_outline,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (String value) => provider.changePassword(value)
                      );
                    }),
                    Consumer<AuthProvider>(builder: (context, provider, child) {
                      return  ButtonWidget(
                        text: 'Registrarse',
                        onPressed: (provider.isValidRegister) 
                        ? () async {
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                          final result = await provider.handleRegister();
                          if (result.status) {
                            Navigator.pushReplacementNamed(context, 'photo');
                          } else {
                            provider.viewState = ViewState.Idle;
                            showAlert(context, 'Ups!', result.message, Icons.sentiment_dissatisfied);
                          }
                        }
                        : () {} 
                      );
                    }),
                    Consumer<AuthProvider>(builder: (consumer, provider, child) {
                      return RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: '¿Ya tienes una cuenta?  ', style: TextStyle(fontSize: responsive.ip(1.9), fontFamily: 'BalooThambi2Regular')),
                            TextSpan(text: 'Inicia Sesión!', style: TextStyle(fontSize: responsive.ip(2.0), fontFamily: 'BalooThambi2SemiBold'),
                              recognizer: TapGestureRecognizer()
                              ..onTap = () => provider.setPageController(0)
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