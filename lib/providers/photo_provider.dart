import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pet_social_app/utils/loader.dart';
import 'package:pet_social_app/utils/response.dart';
import 'package:pet_social_app/services/user_service.dart';

class PhotoProvider with ChangeNotifier implements LoaderState {
  
  String _image;
  CameraController _cameraCtrl;
  
  String get image => this._image;
  CameraController get cameraCtrl => this._cameraCtrl;

  set image(String image) {
    this._image = image;
    notifyListeners();
  }

  set cameraCtrl(CameraController cameraCtrl) {
    this._cameraCtrl = cameraCtrl;
    notifyListeners();
  }

  ViewState _viewState;

  @override
  ViewState get viewState => this._viewState;

  @override
  set viewState(ViewState viewState) {
    this._viewState = viewState;
    notifyListeners();
  }

  Future<MyResponse> handleAddPhoto(String oldPhoto) async {
    viewState = ViewState.Busy;
    final userService = UserService();
    return await userService.uploadPhotoUser(oldPhoto, image);
  }
  
}