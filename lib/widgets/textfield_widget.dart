import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_social_app/theme/theme.dart';
import 'package:pet_social_app/utils/responsive.dart';

class TextFieldWidget extends StatefulWidget {

  final IconData icon;
  final String hintText;
  final bool suffixIcon;
  final bool obscureText;
  final String errorText;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  
  TextFieldWidget({
    @required this.icon,
    @required this.hintText,
    @required this.errorText,
    @required this.onChanged,
    this.suffixIcon = false,
    this.obscureText = false,
    @required this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {

  bool _obscurePass;

  @override
  void initState() {
    this._obscurePass = widget.obscureText;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final responsive = new ResponsiveScreen(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        obscureText: this._obscurePass,
        onChanged: this.widget.onChanged,
        keyboardType: this.widget.keyboardType,
        textCapitalization: this.widget.textCapitalization,
        decoration: InputDecoration(
          filled: true,
          hintText: this.widget.hintText,
          errorText: this.widget.errorText,
          fillColor: MyTheme.yellowlight,
          contentPadding: EdgeInsets.symmetric(vertical: responsive.hp(2.0)),
          suffixIcon: this.widget.suffixIcon 
          ? InkWell(
            onTap: _showTextPass,
            customBorder: CircleBorder(),
            child: Icon(this._obscurePass ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash, size: responsive.ip(2.0), color: MyTheme.pink)
          )
          : null,
          prefixIcon: Icon(this.widget.icon, size: responsive.ip(3.0), color: MyTheme.pink),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: MyTheme.yellowlight),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: MyTheme.pink, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: MyTheme.red, width: 2.0),
          )
        ),
      ),
    );
  }

  void _showTextPass() => setState(() { _obscurePass = !_obscurePass; });

}