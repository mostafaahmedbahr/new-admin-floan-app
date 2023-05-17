import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floan_app_for_admin/core/constants.dart';
import 'package:floan_app_for_admin/pages/update_product/update_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../Sh/shared_pref.dart';

class UpdateProductCubit extends Cubit<UpdateProductStates> {
  UpdateProductCubit() : super(UpdateInitState());

  static UpdateProductCubit get(context) => BlocProvider.of(context);

  var sortinges = [
    "Hot Offers",
    "Hot Prices",
    "Children",
    "Women",
    "Men",
  ];

   var types = [
    "Skirt",
    "Blouse",
    "Pants",
    "Dress",
    "Jacket",
    "Coat",
    "Suit",
    "pajamas",
    "Shirt"
  ];

  var  productNameCon = TextEditingController();
  var  productTypeCon = TextEditingController();
  var  productNewPriceCon = TextEditingController();
  var  productOldPriceCon = TextEditingController();
  var  productDiscountCon = TextEditingController();
  var  productModelCon = TextEditingController();
  var  productBrandCon = TextEditingController();
  String?  selectType;
  String?  selectSort;
  bool? offerOrNot1;
  changeSelectType(type){
    selectType = type;
    emit(ChangeSelectTypeState());
  }
  changeSelectSort(sort){
    selectSort = sort;
    emit(ChangeSelectSortState());
  }


  List allProducts = [];

  getAllProducts() {
    emit(GetAllProductsLoadingState());
    allProducts = [];
    FirebaseFirestore.instance.collection("AllProducts")
        .where("id", isEqualTo: SharedPreferencesHelper.getData(key: "uId"))
        .get().then((value) {
      for (var element in value.docs) {
        allProducts.add(element);
      }
      debugPrint(allProducts.length.toString());
      debugPrint("6" * 20);
      emit(GetAllProductsSuccessState());
    }).catchError((error) {
      debugPrint("error in get all data ${error.toString()}");
      emit(GetAllProductsErrorState());
    });
  }


  List<String> productImages = [];
  String productImageUrl1 = "";
  void uploadProductImage1()
  {
    emit(UploadImageToFireStorageLoadingState1());
    firebase_storage.FirebaseStorage.instance.ref()
        .child("productsImages/${Uri.file(productImage1!.path).pathSegments.last}")
        .putFile(productImage1!).then((value){
      value.ref.getDownloadURL().then((value)
      {
        debugPrint(value);
        productImageUrl1 = value;
        productImages.add(productImageUrl1);
        debugPrint(productImages.length.toString());
        emit(UploadImageToFireStorageSuccessState1());
      }).catchError((error)
      {
        debugPrint("error in getDownloadURL ${error.toString()}");
        emit(UploadImageToFireStorageErrorState1());
      });

    }).catchError((error)
    {
      debugPrint("error in uploadProductImage1 ${error.toString()}");
      emit(UploadImageToFireStorageErrorState1());
    });

  }

  String productImageUrl2 = "";
  void uploadProductImage2()
  {
    emit(UploadImageToFireStorageLoadingState2());
    firebase_storage.FirebaseStorage.instance.ref()
        .child("productsImages/${Uri.file(productImage2!.path).pathSegments.last}")
        .putFile(productImage2!).then((value){
      value.ref.getDownloadURL().then((value)
      {
        debugPrint(value);
        productImageUrl2 = value;
        productImages.add(productImageUrl2);
        debugPrint(productImages.length.toString());
        emit(UploadImageToFireStorageSuccessState2());
      }).catchError((error)
      {
        debugPrint("error in getDownloadURL ${error.toString()}");
        emit(UploadImageToFireStorageErrorState2());
      });

    }).catchError((error)
    {
      debugPrint("error in uploadProductImage1 ${error.toString()}");
      emit(UploadImageToFireStorageErrorState1());
    });

  }

  String productImageUrl3 = "";
  void uploadProductImage3()
  {
    emit(UploadImageToFireStorageLoadingState3());
    firebase_storage.FirebaseStorage.instance.ref()
        .child("productsImages/${Uri.file(productImage3!.path).pathSegments.last}")
        .putFile(productImage3!).then((value){
      value.ref.getDownloadURL().then((value)
      {
        debugPrint(value);
        productImageUrl3 = value;
        productImages.add(productImageUrl3);
        debugPrint(productImages.length.toString());
        emit(UploadImageToFireStorageSuccessState3());
      }).catchError((error)
      {
        debugPrint("error in getDownloadURL ${error.toString()}");
        emit(UploadImageToFireStorageErrorState3());
      });

    }).catchError((error)
    {
      debugPrint("error in uploadProductImage3 ${error.toString()}");
      emit(UploadImageToFireStorageErrorState3());
    });

  }

  String productImageUrl4 = "";
  void uploadProductImage4()
  {
    emit(UploadImageToFireStorageLoadingState4());
    firebase_storage.FirebaseStorage.instance.ref()
        .child("productsImages/${Uri.file(productImage4!.path).pathSegments.last}")
        .putFile(productImage4!).then((value){
      value.ref.getDownloadURL().then((value)
      {
        debugPrint(value);
        productImageUrl4 = value;
        productImages.add(productImageUrl4);
        debugPrint(productImages.length.toString());
        emit(UploadImageToFireStorageSuccessState4());
      }).catchError((error)
      {
        debugPrint("error in getDownloadURL ${error.toString()}");
        emit(UploadImageToFireStorageErrorState4());
      });

    }).catchError((error)
    {
      debugPrint("error in uploadProductImage3 ${error.toString()}");
      emit(UploadImageToFireStorageErrorState3());
    });

  }

  String productImageUrl5 = "";
  void uploadProductImage5()
  {
    emit(UploadImageToFireStorageLoadingState5());
    firebase_storage.FirebaseStorage.instance.ref()
        .child("productsImages/${Uri.file(productImage5!.path).pathSegments.last}")
        .putFile(productImage5!).then((value){
      value.ref.getDownloadURL().then((value)
      {
        debugPrint(value);
        productImageUrl5 = value;
        productImages.add(productImageUrl5);
        debugPrint(productImages.length.toString());
        emit(UploadImageToFireStorageSuccessState5());
      }).catchError((error)
      {
        debugPrint("error in getDownloadURL ${error.toString()}");
        emit(UploadImageToFireStorageErrorState5());
      });

    }).catchError((error)
    {
      debugPrint("error in uploadProductImage3 ${error.toString()}");
      emit(UploadImageToFireStorageErrorState3());
    });

  }

  File? productImage1;
  var  picker1 = ImagePicker();

  Future<void> getImage()async
  {
    final pickedFile = await picker1.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      productImage1 = File(pickedFile.path);
      emit(UploadImageSuccessState1());
    }
    else{
      debugPrint("no image selected");
      emit(UploadImageErrorState1());
    }

  }

  File? productImage2;
  var  picker2 = ImagePicker();

  Future<void> getImage2()async
  {
    final pickedFile = await picker2.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      productImage2 = File(pickedFile.path);
      emit(UploadImageSuccessState2());
    }
    else{
      debugPrint("no image selected");
      emit(UploadImageErrorState2());
    }

  }

  File? productImage3;
  var  picker3 = ImagePicker();

  Future<void> getImage3()async
  {
    final pickedFile = await picker3.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      productImage3 = File(pickedFile.path);
      emit(UploadImageSuccessState3());
    }
    else{
      debugPrint("no image selected");
      emit(UploadImageErrorState3());
    }

  }

  File? productImage4;
  var  picker4 = ImagePicker();

  Future<void> getImage4()async
  {
    final pickedFile = await picker4.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      productImage4 = File(pickedFile.path);
      emit(UploadImageSuccessState4());
    }
    else{
      debugPrint("no image selected");
      emit(UploadImageErrorState4());
    }

  }


  File? productImage5;
  var  picker5 = ImagePicker();

  Future<void> getImage5()async
  {
    final pickedFile = await picker5.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      productImage5 = File(pickedFile.path);
      emit(UploadImageSuccessState5());
    }
    else{
      debugPrint("no image selected");
      emit(UploadImageErrorState5());
    }

  }




  bool isLoad = false ;
  String? newName;
  String? newNameAr;
  String? newDes;
  String? newColors;
  dynamic newOldPrice;
  dynamic newNewPrice;
  String? newModel;
  String? newBrand;
  String? newType;
  String? newTitle;


}