import 'dart:io';

import 'package:pet_social_app/utils/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_social_app/utils/shared_prefs.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class UserService {

  final _sharedPrefs = SharedPrefs();
  final _dbRef = FirebaseFirestore.instance.collection("users");
  final _storeRef = FirebaseStorage.instanceFor(bucket: 'gs://dev-pet-social.appspot.com/').ref();

  Future<Map<String, dynamic>> readUser([String userUid]) async {
    try {
      // final result = (await _dbRef.child("users").child((userUid == null) ? _prefs.uid : userUid).once()).value;
      // final user = UserModel.fromJson(result);
      return {"ok": true, "value": ''}; 
    } on FirebaseException catch (e) {
      return {"ok": false, "message": e.toString()}; 
    }
  }

  Future<Map<String, dynamic>> updateUser(String property, String value) async {
    try {
      // _dbRef.child("users").child(_prefs.uid).update({property: value});
      return {"ok": true}; 
    } on FirebaseException catch (e) {
      return {"ok": false, "message": e.message.toString()}; 
    }
  } 

  Future<MyResponse> uploadPhotoUser(String oldPhoto, String imageFile) async {
    try {
      if (oldPhoto != null) {
        await _storeRef.child(_sharedPrefs.uid).delete();
      }
      final compressed = await FlutterNativeImage.compressImage(imageFile, quality: 50);
      final uploadTask = await _storeRef.child(_sharedPrefs.uid).putFile(compressed);
      // TaskSnapshot storageTaskSnapshot = await uploadTask;
      // String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      String downloadUrl = await uploadTask.ref.getDownloadURL();
      await _dbRef.doc(_sharedPrefs.uid).update({"photo" : downloadUrl});
      return MyResponse(status: true, message: "Imagen agregada correctamente.");
    } on FirebaseException catch (e) {
      return MyResponse(status: false, message: e.message);
    } catch (e) {
      return MyResponse(status: false, message: e.toString());
    }
  }

}