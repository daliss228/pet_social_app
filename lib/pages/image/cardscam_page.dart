import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_social_app/theme/theme.dart';
import 'package:pet_social_app/utils/responsive.dart';
import 'package:pet_social_app/providers/photo_provider.dart';

class CardsCamPage extends StatefulWidget {
  final List<String> images;
  const CardsCamPage({@required this.images});
  
  @override
  _CardsCamPageState createState() => _CardsCamPageState();
}

class _CardsCamPageState extends State<CardsCamPage> {
  String _imageSelected;
  final _pageCtrl = PageController(viewportFraction: 0.75);

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveScreen(context);
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.hp(6.0)),
        child: AppBar(
          titleSpacing: 0,
          title: Text('Cámara', style: TextStyle(fontSize: responsive.ip(2.4), fontFamily: 'BalooThambi2Regular', color: Colors.white)),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, size: responsive.ip(2.4))
          ),
          actions: [
            Consumer<PhotoProvider>(builder: (context, provider, child) {
              return _imageSelected != null
              ? InkWell(
                onTap: () {
                  provider.image = _imageSelected;
                  Navigator.pushReplacementNamed(context, 'photo');
                },
                child: Row(
                  children: [
                    SizedBox(width: 15.0),
                    Text('Siguiente', style: TextStyle(fontSize: responsive.ip(2.2), fontFamily: 'BalooThambi2Regular', color: Colors.white)),
                    SizedBox(width: 15.0)
                  ],
                ),
              )
              : Container();
            }),
          ],
        ),
      ),
      body: PageView(
        controller: _pageCtrl,
        physics: BouncingScrollPhysics(),
        children: widget.images.asMap().entries.map((slide) => 
          InkWell(
            onTap: () => _handleImageSelected(slide),
            child: Card(
              color: MyTheme.gray,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: _imageSelected == slide.value ? BorderSide(width: 4, color: MyTheme.pink) : BorderSide.none,
              ),
              margin: EdgeInsets.symmetric(horizontal: responsive.ip(1.5), vertical: responsive.hp(10.0)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0), 
                    child: Image.file(
                      File(slide.value),
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high
                    )
                  ),
                  _imageSelected == slide.value 
                  ? Icon(Icons.check_circle, size: responsive.ip(7.0), color: MyTheme.pink)
                  : Container()
                ],
              )
            ),
          )
        ).toList()
      )
    );
  }

  void _handleImageSelected(MapEntry slide) {
    setState(() {
      _imageSelected = _imageSelected == slide.value ? null : slide.value;
    });
    if (_pageCtrl.page != slide.key) {
      _pageCtrl.animateToPage(slide.key, duration: Duration(milliseconds: 500), curve: Curves.linear);
    }
  }

}