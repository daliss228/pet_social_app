import 'package:flutter/material.dart';
import 'package:pet_social_app/theme/theme.dart';
import 'package:pet_social_app/utils/responsive.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveScreen(context);
    return Container(
      color: MyTheme.blue,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: SpinKitRipple(
          color: MyTheme.pink,
          size: responsive.ip(10.0),
        ),
      )
    );
  }
}