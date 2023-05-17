

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floan_app_for_admin/models/admin_model.dart';
import 'package:floan_app_for_admin/pages/home/home_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../Sh/shared_pref.dart';
import '../../../core/constants.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);



  AdminModel? adminModel;
  getUserData()
  {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection("AllUsers").doc(SharedPreferencesHelper.getData(key: "uId")).get().then((value)
    {
      print(value.data());
      adminModel = AdminModel.fromJson(value.data());
      SharedPreferencesHelper.saveData(key: "latNew", value: adminModel?.lat);
      SharedPreferencesHelper.saveData(key: "longNew", value: adminModel?.long);
      SharedPreferencesHelper.saveData(key: "shopNameNew", value: adminModel?.shopName);
      print(adminModel!.shopName);
      emit(GetUserSuccessState());
    }).catchError((error)
    {
      print("error in get user data ${error.toString()}");
      emit(GetUserErrorState());
    });
  }


  logout()async
  {
    SharedPreferencesHelper.removeData(key: "uId");
    SharedPreferencesHelper.removeData(key: "lat");
    SharedPreferencesHelper.removeData(key: "long");
    SharedPreferencesHelper.removeData(key: "shopName");
    await FirebaseAuth.instance.signOut();
    print(uId);
    print("----------");
    emit(LogoutSuccessState());
  }

}