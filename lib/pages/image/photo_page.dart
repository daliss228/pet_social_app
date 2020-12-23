import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pet_social_app/widgets/alert_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_social_app/theme/theme.dart';
import 'package:pet_social_app/utils/loader.dart';
import 'package:pet_social_app/utils/add_images.dart';
import 'package:pet_social_app/utils/responsive.dart';
import 'package:pet_social_app/widgets/button_widget.dart';
import 'package:pet_social_app/widgets/loading_widget.dart';
import 'package:pet_social_app/providers/photo_provider.dart';
import 'package:pet_social_app/pages/image/gallery_page.dart';

class PhotoPage extends StatefulWidget {

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {

  final _addImage = AddImage();

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveScreen(context);
    return Consumer<PhotoProvider>(builder: (context, provider, child) {
      return provider.viewState == ViewState.Busy 
        ? LoadingWidget()
        : Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(responsive.hp(6.0)),
          child: AppBar(
            titleSpacing: 0,
            title: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text('Foto de perfil', style: TextStyle(fontSize: responsive.ip(2.4), fontFamily: 'BalooThambi2Regular', color: Colors.white)),
            ),
            actions: [
              provider.image != null
              ? InkWell(
                onTap: () async {
                  final result = await provider.handleAddPhoto(null);
                  if (result.status) {
                    Navigator.pushReplacementNamed(context, 'home');
                  } else {
                    provider.viewState = ViewState.Idle;
                    showAlert(context, 'Ups!', result.message, Icons.sentiment_dissatisfied);
                  }
                },
                child: Row(
                  children: [
                    SizedBox(width: 15.0),
                    Text('Siguiente', style: TextStyle(fontSize: responsive.ip(2.2), fontFamily: 'BalooThambi2Regular', color: Colors.white)),
                    SizedBox(width: 15.0)
                  ],
                ),
              )
              : Container(),
            ]
          )
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(provider.image == null ? responsive.hp(10) : 0.0),
                height: responsive.hp(70.0),
                decoration: BoxDecoration(
                  color: MyTheme.gray,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: provider.image == null 
                ? SvgPicture.asset('assets/svg/user-solid.svg')
                : ClipRRect(
                  child: Image.file(
                    File(provider.image),
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                )
              ),
              SizedBox(height: 10.0),
              ButtonWidget( 
                text: 'Gallery', 
                onPressed: () async {
                  await _addImage.initImagesPath();
                  Navigator.push(context, MaterialPageRoute(builder: (_) => GalleryPage()));
                },
              ) 
            ],
          ),
        ),
      );
    });
  }

}