import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_social_app/theme/theme.dart';
import 'package:pet_social_app/utils/responsive.dart';
import 'package:pet_social_app/utils/add_images.dart';
import 'package:pet_social_app/providers/photo_provider.dart';
import 'package:pet_social_app/pages/image/camera_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GalleryPage extends StatefulWidget {

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> with SingleTickerProviderStateMixin {

  int _imageSelected;
  int _currentPage = 0;
  int _currentCategory = 0;

  AddImage _addImage;
  PageController _pageCtrl;
  AnimationController _animationCtrl;

  @override
  void initState() {
    _addImage = AddImage();
    _pageCtrl = PageController(initialPage: 0);
    _animationCtrl = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveScreen(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.hp(6.0)),
        child: AppBar(
          titleSpacing: 0,
          title: InkWell(
            onTap: () => _handleChangePage(),
            child: Row(
              children: [
                Text(_addImage.listPath[_currentCategory].folderName.isEmpty ? 'Galería' : _addImage.listPath[_currentCategory].folderName, style: TextStyle(fontSize: responsive.ip(2.4), fontFamily: 'BalooThambi2Regular', color: Colors.white)),
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(_animationCtrl),
                  child: Icon(Icons.arrow_drop_down, size: responsive.ip(2.6), color: Colors.white),
                ),
              ],
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, size: responsive.ip(2.4))
          ),
          actions: [
            _imageSelected == null
            ? Consumer<PhotoProvider>(builder: (context, provider, child) {
              return IconButton(
                icon: Icon(FontAwesomeIcons.cameraRetro, size: responsive.ip(2.4)),
                tooltip: 'Cámara',
                onPressed: () async {
                  await _addImage.initCamerasDescrip();
                  provider.cameraCtrl = CameraController(_addImage.listCamera.first, ResolutionPreset.medium, enableAudio: false);
                  try {
                    await provider.cameraCtrl.initialize();
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CameraPage()));
                  } catch (e) {
                    return;
                  }
                },
              );
            })
            : Consumer<PhotoProvider>(builder: (context, provider, child) {
                return InkWell(
                  onTap: () {
                    provider.image = _addImage.listPath[_currentCategory].files[_imageSelected];
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 15.0),
                      Text('Siguiente', style: TextStyle(fontSize: responsive.ip(2.2), fontFamily: 'BalooThambi2Regular', color: Colors.white)),
                      SizedBox(width: 15.0)
                    ],
                  ),
                );
              }
            )
          ],
        ),
      ),
      body: PageView(
        controller: _pageCtrl,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        children: [
          GridView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _addImage.listPath[_currentCategory].files.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2
            ),
            padding: EdgeInsets.all(0.0),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => _handleImageSelected(index),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: MyTheme.gray,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.file(
                        File(_addImage.listPath[_currentCategory].files[index]),
                        cacheWidth: 150,
                        cacheHeight: 150,
                        fit: BoxFit.contain,
                      ),
                      _imageSelected == index 
                      ? Icon(Icons.check_circle, size: responsive.ip(6.0), color: MyTheme.pink)
                      : Container()
                    ],
                  )
                ),
              );
            }
          ),
          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _addImage.listPath.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  _handleCategory(index);
                  _handleChangePage();
                },
                title: Text(_addImage.listPath[index].folderName, style: TextStyle(fontSize: responsive.ip(2.0), fontFamily: '${_currentCategory != index ? "BalooThambi2Regular" : "BalooThambi2Medium"}')),
                leading: Text('${_addImage.listPath[index].files.length}', style: TextStyle(fontSize: responsive.ip(2.0), fontFamily: '${_currentCategory != index ? "BalooThambi2Regular" : "BalooThambi2Medium"}')),
                trailing: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.file(
                    File(_addImage.listPath[index].files[0]),
                    fit: BoxFit.cover,
                    width: 50.0,
                    height: 50.0,
                  ),
                )
              );
            },
          )
        ],
      )
    );
  }

  void _handleChangePage() {
    if (_currentPage == 0) {
      setState(() {
        _currentPage = 1;
      });
      _animationCtrl.forward();
    } else {
      setState(() {
        _currentPage = 0;
      });
      _animationCtrl.reverse();
    }
    _pageCtrl.animateToPage(_currentPage, duration: Duration(milliseconds: 600), curve: Curves.ease);
  }

  void _handleCategory(int index) {
    if (_currentCategory != index) {
      setState(() {
        _imageSelected = null;
        _currentCategory = index;
      });  
    }
  }

  void _handleImageSelected(int index) {
    setState(() {
      _imageSelected = _imageSelected == index ? null : index;
    });
  }

}