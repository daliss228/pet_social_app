import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pet_social_app/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pet_social_app/routes/routes.dart';
import 'package:pet_social_app/utils/shared_prefs.dart';
import 'package:pet_social_app/providers/photo_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPrefs = SharedPrefs();
  await sharedPrefs.initializePrefs();
  return runApp(PetSocialApp());
}
 
class PetSocialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sharedPrefs = SharedPrefs();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PhotoProvider())
      ],
      child: MaterialApp(
        title: 'Petapp',
        routes: routes(),
        theme: MyTheme.themeData,
        debugShowCheckedModeBanner: false,
        initialRoute: sharedPrefs.token.isNotEmpty ? 'home': 'auth',
      ),
    );
  }
}