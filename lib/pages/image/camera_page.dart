import 'dart:io';
import 'package:path/path.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_social_app/theme/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_social_app/utils/add_images.dart';
import 'package:pet_social_app/utils/responsive.dart';
import 'package:pet_social_app/providers/photo_provider.dart';
import 'package:pet_social_app/pages/image/cardscam_page.dart';

class CameraPage extends StatefulWidget {

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with SingleTickerProviderStateMixin {

  AddImage _imagePaths;
  CameraController _cameraCtrl;
  CameraDescription _cameraSelected;
  AnimationController _animationCtrl;

  @override
  void initState() { 
    _imagePaths = AddImage();
    _cameraSelected = _imagePaths.listCamera.first;
    _animationCtrl = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _cameraCtrl = CameraController(_cameraSelected, ResolutionPreset.medium, enableAudio: false);
    _cameraCtrl.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _cameraCtrl.dispose();
    _animationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveScreen(context);
    final cameraPhotos = _imagePaths.listPath.where((path) => path.folderName == "Camera").toList();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(responsive.hp(6.0)),
        child: AppBar(
          backgroundColor: Colors.black,
          titleSpacing: 0,
          title: Text('Cámara', style: TextStyle(fontSize: responsive.ip(2.4), fontFamily: 'BalooThambi2Regular', color: Colors.white)),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, size: responsive.ip(2.4))
          ),
        ),
      ),
      body: Column(
        children: [
          (!_cameraCtrl.value.isInitialized) 
          ? Container()
          : AspectRatio(
            aspectRatio: _cameraCtrl.value.aspectRatio,
            child: CameraPreview(_cameraCtrl),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  customBorder: CircleBorder(),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CardsCamPage(images: cameraPhotos[0].files))),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(width: 2.0, color: Colors.white)
                    ),
                    child: ClipOval(
                      child: Image.file(
                        File(cameraPhotos[0].files[0]),
                        fit: BoxFit.cover,
                        width: responsive.ip(7.0),
                        height: responsive.ip(7.0),
                      ),
                    ),
                  ),
                ),
                Consumer<PhotoProvider>(builder: (context, provider, child) {
                  return InkWell(
                    customBorder: CircleBorder(),
                    onTap: _cameraCtrl != null && _cameraCtrl.value.isInitialized
                      ? () => takePhotoButton(provider, context)
                      : null,
                    child: Container(
                      width: responsive.ip(9.0),
                      height: responsive.ip(9.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(width: 4.0, color: Colors.white, style: BorderStyle.solid)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(width: 4.0, color: MyTheme.pink, style: BorderStyle.solid)
                        ),
                      )
                    ),
                  );
                }),
                InkWell(
                  customBorder: CircleBorder(),
                  onTap: () => onNewCameraSelected(context),
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 0.5).animate(_animationCtrl),
                    child: Container(
                      width: responsive.ip(7.0),
                      height: responsive.ip(7.0),
                      child: Icon(Icons.sync, size: responsive.ip(2.8), color: Colors.white),
                      decoration: BoxDecoration(
                        color: MyTheme.black,
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(width: 2.0, color: Colors.white, style: BorderStyle.solid)
                      )
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> takePhotoButton(PhotoProvider provider, BuildContext context) async {
    try {
      final filePath = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
      await _cameraCtrl.takePicture(filePath);
      if (mounted) {
        provider.image = filePath;
        Navigator.pushReplacementNamed(context, 'photo');
      }
    } on CameraException {
      return null;
    }
  }

  Future<void> onNewCameraSelected(BuildContext context) async {
    if (_cameraSelected.lensDirection == CameraLensDirection.front) {
      _animationCtrl.forward();
      _cameraSelected = _imagePaths.listCamera.last; 
    } else {
      _animationCtrl.reverse();
      _cameraSelected = _imagePaths.listCamera.first;  
    }
    if (_cameraCtrl != null) {
      await _cameraCtrl.dispose();
    }
    _cameraCtrl = CameraController(_cameraSelected, ResolutionPreset.medium, enableAudio: false);
    _cameraCtrl.addListener(() {
      if (mounted) setState(() {});
      if (_cameraCtrl.value.hasError) {
        Navigator.pop(context);
      }
    });
    try {
      await _cameraCtrl.initialize();
    } on CameraException {
      Navigator.pop(context);
    }
    if (mounted) {
      setState(() {});
    }
  }
  
}