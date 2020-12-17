import 'package:flutter/cupertino.dart';

class MyResponse {

  bool status;
  dynamic data;
  String message;

  MyResponse({@required this.status, this.data, this.message});

}