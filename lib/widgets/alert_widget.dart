import 'package:flutter/material.dart';
import 'package:pet_social_app/theme/theme.dart';
import 'package:pet_social_app/utils/responsive.dart';

void showAlert(BuildContext context, String title, String message, IconData icon){
  final responsive = ResponsiveScreen(context);
  showDialog(
    context: context, 
    builder: (context){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0), 
        ),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 20.0, fontFamily: 'BalooThambi2SemiBold'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: responsive.ip(10.0)),
              SizedBox(height: 20.0),
              Text(
                message,
                style: TextStyle(fontSize: 16.0, fontFamily: 'BalooThambi2Regular'),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: ()=> Navigator.of(context).pop(), 
              child: Text('OK', style: TextStyle(fontSize: 18.0, fontFamily: 'BalooThambi2SemiBold', color: MyTheme.pink))
            )
          ],
        ),
      ); 
    }
  );
}