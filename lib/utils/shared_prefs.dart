import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  static final SharedPrefs _instance = new SharedPrefs._internal();

  factory SharedPrefs() {
    return _instance;
  }

  SharedPrefs._internal();

  SharedPreferences _prefs;

  initializePrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  String get token => _prefs.getString('token') ?? '';

  set token(String value) {
    _prefs.setString('token', value);
  }

  String get uid => _prefs.getString('uid') ?? ''; 

  set uid(String value){
    _prefs.setString('uid', value);
  }

}

