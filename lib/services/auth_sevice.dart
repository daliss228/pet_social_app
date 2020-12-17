import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_social_app/utils/helpers.dart';
import 'package:pet_social_app/utils/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_social_app/models/user_model.dart';
import 'package:pet_social_app/utils/shared_prefs.dart';

class AuthService {

  final _sharedPrefs = SharedPrefs();
  final _auth = FirebaseAuth.instance; 
  final _dbref = FirebaseFirestore.instance.collection("users");

  Future<MyResponse> singUp(UserModel userModel, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: userModel.email, password: password); 
      if(result.user != null){
        _sharedPrefs.uid = result.user.uid;
        _sharedPrefs.token = await result.user.getIdToken();
      }
      await _dbref.add(userModel.toJson());
      return MyResponse(status: true, message: "Usuario registrado correctamente.");
    } on FirebaseAuthException catch(e) {
      return MyResponse(status: false, message: Helpers.firebaseErrMessages(e.code));
    } on FirebaseException catch (e) {
      return MyResponse(status: false, message: e.message);
    } catch (e) {
      return MyResponse(status: false, message: e.toString());
    }
  }

  Future<MyResponse> signIn(String email, String password) async {
    UserCredential authResult;
    try {
      authResult = await _auth.signInWithEmailAndPassword(email: email, password: password); 
      _sharedPrefs.uid = authResult.user.uid;
      _sharedPrefs.token = await authResult.user.getIdToken();
      return MyResponse(status: true, message: "Inicio de sesión exitoso.");
    } on FirebaseAuthException catch (e){
      return MyResponse(status: false, message: Helpers.firebaseErrMessages(e.code));
    } catch (e) {
      return MyResponse(status: false, message: e.toString());
    }
  } 

  Future<MyResponse> reAuth(String email, String pass, String newPass) async {
    try {
      User user = _auth.currentUser;
      UserCredential authResult = await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: email,
          password: pass,
        ),
      );
      if (authResult.user.uid.length != 0) {
        user.updatePassword(newPass);
        authResult.user.getIdToken().then((token){
          _sharedPrefs.token = token;
        });
        return MyResponse(status: true, message: "Contraseña cambiada con éxito!");
      } else {
        throw Exception("Se he producido un error."); 
      }
    } on FirebaseAuthException catch(e){ 
      return MyResponse(status: false, message: Helpers.firebaseErrMessages(e.code));
    } catch (e) {
      return MyResponse(status: false, message: e.toString());
    }
  }

  Future<void> signOut() async {
    _auth.signOut();
    _sharedPrefs.uid = '';
    _sharedPrefs.token = '';
  }

}