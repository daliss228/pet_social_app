import 'package:flutter/material.dart';
import 'package:pet_social_app/theme/theme.dart';
import 'package:pet_social_app/utils/responsive.dart';

class ButtonWidget extends StatelessWidget {
  
  final String text;
  final Function onPressed;
  ButtonWidget({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveScreen(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: MaterialButton(
        elevation: 4.0,
        color: MyTheme.pink,
        minWidth: double.infinity,
        height: responsive.hp(6),
        highlightColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onPressed: () => this.onPressed(),
        child: Text(
          this.text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}