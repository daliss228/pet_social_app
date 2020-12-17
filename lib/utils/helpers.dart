class Helpers {
  static String firebaseErrMessages(String err) {
    switch (err) {
      case "wrong-password":
        return "Contraseña no válida."; 
      case "user-not-found":
      case "invalid_email":
      case "email-already-in-use":
      case "account-exists-with-different-credential":
        return "Correo electrónico no válido."; 
        break;
      case "too-many-requests":
        return "Demasiados intentos fallidos. \nPor favor, inténtelo de nuevo más tarde."; 
        break;
      case "user-disabled":
        return "Usuario deshabilitado. \nCuenta deshabilitada por el administrador."; 
        break;
      case "network-request-failed":
        return "Error de red. \nConexión interrumpida o host inaccesible."; 
        break;
      default:
        return "Acción fallida. \nPor favor, intente otra vez."; 
        break;
    }
  }
}