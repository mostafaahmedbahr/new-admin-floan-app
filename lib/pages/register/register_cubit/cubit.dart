import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floan_app_for_admin/models/admin_model.dart';
import 'package:floan_app_for_admin/pages/register/register_cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
 import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../Sh/shared_pref.dart';
class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  var emailCon = TextEditingController();
  var passCon = TextEditingController();
  var nameCon = TextEditingController();
  var shopNameCon = TextEditingController();
  var phone = TextEditingController();
  var configPassCon = TextEditingController();

  bool isVisible = true;
  void changeSuffixIcon()
  {
    isVisible =! isVisible;
    emit(ChangeSuffixIconState());
  }

  void showLocationToast() {
    Fluttertoast.showToast(
      msg: "Please enable location services to continue",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
  Future<void> checkLocationEnabled() async {
    bool locationEnabled = await Geolocator.isLocationServiceEnabled();
    if(!locationEnabled) {
      showLocationToast();
    }
    emit(CheckLocationEnabledState());
    getLatLong();
  }


  register({
    required String email,
    required String password,
    required String phone,
    required String name,
    required double lat,
    required double long,
    required String shopName,
  })async
  {
    emit(RegisterLoadingState());
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value){
        print(value.user!.uid);
        print("0"*20);
        print(value.user!.email);
        createUser(
          phone:phone ,
          email:email ,
          name: name,
          adminId:value.user!.uid ,
          lat: lat,
          long: long,
          shopName: shopName,
          isAdmin: true,
        );
        print("11111111111111111");
        SharedPreferencesHelper.saveData(
          key: "lat",
          value: lat,
        );
        SharedPreferencesHelper.saveData(
          key: "uId",
          value: value.user!.uid,
        );
        SharedPreferencesHelper.saveData(
          key: "long",
          value: long,
        );
        SharedPreferencesHelper.saveData(
          key: "shopName",
          value: shopName,
        );
        // emit(RegisterSuccessState());
      }).catchError((error){
        print("error in register cubit");
        print(error.toString());
        emit(RegisterErrorState(errorMsg: error.toString()));
      });
  }


  createUser({
    required String email,
    required String phone,
    required String name,
    required bool isAdmin,
    required String adminId,
    required double lat,
    required double long,
    required String shopName,
})
  {
    AdminModel adminModel = AdminModel(
        adminName: name,
        adminEmail: email,
        adminId: adminId,
        adminPhone: phone,
      shopName: shopName,
      long: long,
      lat: lat,
        isAdmin : true,
    );
    FirebaseFirestore.instance.collection("AllUsers").doc(adminId).set(adminModel.toMap()).then((value)
    {
      print(adminId);
      print("222222222222222222222");
      print(long);
      emit(CreateUserSuccessState());
    }).catchError((error)
    {
      print("error in create user cubit ${error.toString()}");
      emit(CreateUserErrorState(errorMsg: error.toString()));
    });
  }



  double lat = 0.0;
  double long = 0.0;
  String address ="";
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getLatLong()async
  {
    emit(GetLatLonLoadingState());
    Position pos = await determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude,pos.longitude);
    lat = pos.latitude;
    SharedPreferencesHelper.saveData(key: "lat", value: lat);
    long = pos.longitude;
    SharedPreferencesHelper.saveData(key: "long", value: long);
    print("---------- lat = $lat --------------");
    print("---------- lat = $long --------------");
    emit(GetLatLongSuccessState());
  }







}