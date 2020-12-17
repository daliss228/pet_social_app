import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pet_social_app/utils/loader.dart';
import 'package:pet_social_app/utils/response.dart';
import 'package:pet_social_app/utils/validator.dart';
import 'package:pet_social_app/models/user_model.dart';
import 'package:pet_social_app/services/auth_sevice.dart';

class AuthProvider with ChangeNotifier implements LoaderState {

  ValidationModel _email = ValidationModel(null, null);
  ValidationModel _name = ValidationModel(null, null);
  ValidationModel _lastname = ValidationModel(null, null);
  ValidationModel _password = ValidationModel(null, null);
  PageController _pageController = PageController(initialPage: 0);

  ValidationModel get email => this._email;
  ValidationModel get name => this._name;
  ValidationModel get lastname => this._lastname;
  ValidationModel get password => this._password;
  PageController get pageController => this._pageController;

  bool get isValidLogin {
    if (this._email.value != null && this._password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  bool get isValidRegister {
    if (this._email.value != null && this._name.value != null && this._lastname.value != null && this._password.value != null) {
      return true;
    } else {
      return false;
    }
  }

  void setPageController(int index) {
    this._pageController.animateToPage(index, duration: Duration(milliseconds: 600), curve: Curves.linear);
    notifyListeners();
  }

  void changeEmail(String value) {
    if (value.isEmpty) {
      this._email = ValidationModel(null, null);
    } else if (Validators.email.hasMatch(value)) {
      this._email = ValidationModel(value, null);
    } else {
      this._email = ValidationModel(null, "Ingrese un email válido!");
    }
    notifyListeners();
  }

  void changeName(String value) {
    if (value.isEmpty) {
      this._name = ValidationModel(null, null);
    } else if (Validators.username.hasMatch(value) && value.length >= 3) {
      this._name = ValidationModel(value, null);
    } else {
      this._name = ValidationModel(null, "Ingrese un nombre válido!");
    }
    notifyListeners();
  }

  void changeLastname(String value) {
    if (value.isEmpty) {
      this._lastname = ValidationModel(null, null);
    } else if (Validators.username.hasMatch(value) && value.length >= 3) {
      this._lastname = ValidationModel(value, null);
    } else {
      this._lastname = ValidationModel(null, "Ingrese un apellido válido!");
    }
    notifyListeners();
  }

  void changePassword(String value) {
    if (value.isEmpty) {
      this._password = ValidationModel(null, null);
    } else if (Validators.password.hasMatch(value)) {
      this._password = ValidationModel(value, null);
    } else {
      this._password = ValidationModel(null, "Ingrese una contraseña válida!");
    }
    notifyListeners();
  }

  ViewState _viewState;

  @override
  ViewState get viewState => this._viewState;

  @override
  set viewState(ViewState viewState) {
    this._viewState = viewState;
    notifyListeners();
  }

  Future<MyResponse> handleLogin() async {
    viewState = ViewState.Busy;
    final authService = AuthService();
    final result = await authService.signIn(this._email.value, this._password.value);
    return result;
  }

  Future<MyResponse> handleRegister() async {
    viewState = ViewState.Busy;
    final authService = AuthService();
    final result = await authService.singUp(
      UserModel(
        name: this.name.value,
        email: this._email.value,
        lastname: this.lastname.value
      ), 
      this._password.value
    );
    return result;
  }

  @override
  void dispose() {
    this._pageController.dispose();
    super.dispose();
  }

}