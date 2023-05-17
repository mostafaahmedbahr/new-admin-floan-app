import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:floan_app_for_admin/pages/remove_product/remove_product_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Sh/shared_pref.dart';
import '../../../core/constants.dart';

class RemoveProductCubit extends Cubit<RemoveProductStates> {
  RemoveProductCubit() : super(RemoveInitState());

  static RemoveProductCubit get(context) => BlocProvider.of(context);


  List allProducts = [];
  getAllProducts()
  {
    emit(GetAllProductsLoadingState());
    allProducts = [];
     FirebaseFirestore.instance.collection("AllProducts")
         .where("id" , isEqualTo: SharedPreferencesHelper.getData(key: "uId"))
         .get().then((value)
     {
       for (var element in value.docs) {
         allProducts.add(element);
       }
       debugPrint(allProducts.length.toString());
       debugPrint("6"*20);
       emit(GetAllProductsSuccessState());
     }).catchError((error)
     {
       print("error in get all data ${error.toString()}");
       emit(GetAllProductsErrorState());
     });
  }

  deleteProduct(productId)
  {
    emit(DeleteProductLoadingState());
      debugPrint("delete image done");
      FirebaseFirestore.instance.collection("AllProducts")
          .doc(productId).delete().then((value)
      {
        debugPrint("---------- delete done -----------");
        emit(DeleteProductSuccessState());
      }).catchError((error)
      {
        debugPrint("error in delete product ${error.toString()}");
        emit(DeleteProductErrorState());
      });

  }

  deleteImagesFromStorage(index)
  {
    emit(DeleteImagesLoadingFromStorage());
    final storage0 = FirebaseStorage.instance;
    storage0.refFromURL(allProducts[index]["images"][0]).delete();
    storage0.refFromURL(allProducts[index]["images"][1]).delete();
    storage0.refFromURL(allProducts[index]["images"][2]).delete();
    storage0.refFromURL(allProducts[index]["images"][3]).delete();
    storage0.refFromURL(allProducts[index]["images"][4]).delete().then((value){
      print("--------- delete images done ---------");
      emit(DeleteImagesSuccessFromStorage());
    }).catchError((error){
      emit(DeleteImagesErrorFromStorage());
      print("error in delete images ${error.toString()}");
    });
  }

}