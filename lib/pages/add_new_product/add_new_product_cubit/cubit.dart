import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floan_app_for_admin/Sh/shared_pref.dart';
import 'package:floan_app_for_admin/models/admin_model.dart';
import 'package:floan_app_for_admin/pages/add_new_product/add_new_product_cubit/states.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../models/size_model.dart';

 class AddNewProductCubit extends Cubit<AddNewProductsStates> {
  AddNewProductCubit() : super(AddNewProductInitState());

  static AddNewProductCubit get(context) => BlocProvider.of(context);

  var  productNameCon = TextEditingController();
  var productNameArCon = TextEditingController();
  var  productColorsCon = TextEditingController();
  var  productTypeCon = TextEditingController();
  var  productNewPriceCon = TextEditingController();
  var  productOldPriceCon = TextEditingController();
  var  productDiscountCon = TextEditingController();
  var  productDesCon = TextEditingController();
  var  productModelCon = TextEditingController();
  var  productBrandCon = TextEditingController();



  AdminModel ? adminModel;
  String?  selectType;
  String?  selectArType;
  String?  selectSort;
  String?  selectSortAr;
  bool? offerOrNot1;
  changeSelectType(type){
    selectType = type;
    emit(ChangeSelectTypeState());
  }
  changeSelectTypeAr(type){
    selectArType = type;
    emit(ChangeSelectTypeArState());
  }

  changeOfferOrNot(bool offerOrNot){
    offerOrNot1 = offerOrNot;
    emit(ChangeOfferOrNotState());
  }
  changeSelectSort(sort){
    selectSort = sort;
    emit(ChangeSelectSortState());
  }

  changeSelectSortAr(sort){
    selectSortAr = sort;
    emit(ChangeSelectSortArState());
  }

  selectSize(index)
  {
    listOfSizes[index].isSelected = !listOfSizes[index].isSelected!;
    if(listOfSizes[index].isSelected == true){
      listOfSelectedSizes.add(SizeModel("S", true),);
    }
    if(listOfSizes[index].isSelected == false){
      listOfSelectedSizes.removeWhere((element)=>element.size == listOfSizes[index].size);
    }
    emit(SelectSizeState());
  }

  selectColor(index)
  {
    listOfColors[index].isSelected = !listOfColors[index].isSelected!;
    if(listOfColors[index].isSelected == true){
      listOfSelectedColors.add(ColorModel(Colors.teal, true),);
    }
    if(listOfColors[index].isSelected == false){
      listOfSelectedColors.removeWhere((element)=>element.color == listOfColors[index].color);
    }

    emit(SelectColorState());
  }

  var sortinges = [
    "Hot Offers",
    "Hot Prices",
    "Children",
    "Women",
    "Men",
  ];

  var sortingesAr = [
    "عروض حصريه",
    "أسعار حصريه",
    "أطفالي",
    "حريمي",
    "رجالي",
  ];

  List<SizeModel> listOfSizes = [
    SizeModel("S", false),
    SizeModel("L", false),
    SizeModel("XL", false),
    SizeModel("2XL", false),
    SizeModel("3XL", false),
    SizeModel("4XL", false),
    SizeModel("5XL", false),
  ];



  List<ColorModel> listOfColors = [
    ColorModel(Colors.red, false),
    ColorModel(Colors.green, false),
    ColorModel(Colors.blue, false),
    ColorModel(Colors.yellow, false),
    ColorModel(Colors.purple, false),
    ColorModel(Colors.pink, false),
    ColorModel(Colors.black, false),
    ColorModel(Colors.white, false),
    ColorModel(Colors.teal, false),
    ColorModel(Colors.brown, false),
  ];

  List<SizeModel> listOfSelectedSizes = [];

  List<ColorModel> listOfSelectedColors = [];
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

  var typesAr = [
    "جيبة",
    "بلوزة",
    "بنطال",
    "فستان",
    "جاكت",
    "بالطو",
    "بدلة",
    "بجامة",
    "قميص"
  ];

  var offersOrNot = [
    "True",
    "False",
  ];

  addNewProduct({
    required String adminId,
      String? productId,
    required String name,
    required String nameAr,
    required String des,
    required int oldPrice,
    required int newPrice,
    required String discount,
    required double lat,
    required double lang,
    required String model,
    required String brand,
    required String shopName,
    required String type,
    required String typeAr,
    required String sorting,
    required String sortingAr,
    required String colors,
    required var  sizes,
    required List<String> images,

})
  {
    emit(AddNewProductLoadingState());
    FirebaseFirestore.instance.collection("AllProducts").add(
      {
        "brand" : brand,
        "id" : adminId,
        "productId" : productId,
        "images" : images,
        "model" : model,
        "new_price" : newPrice,
        "old_price" : oldPrice,
        "name" : name,
        "nameAr" : nameAr,
        "description" : des,
        "lat" : lat,
        "long" : lang,
        "shop_name" : shopName,
        "title" : type,
        "titleAr" : typeAr,
        "type_category" : sorting,
        "type_categoryAr" : sortingAr,
        "colors_available" : colors,
        "size" : sizes,
      }
    ).then((value)
    {
      SharedPreferencesHelper.saveData(key: "productId", value: value.id);
      FirebaseFirestore.instance.collection("AllProducts").doc(value.id).update({
        "productId" : SharedPreferencesHelper.getData(key: "productId"),
      });
      debugPrint("Add product is done");
      debugPrint("50"*10);
      debugPrint(value.id);

      emit(AddNewProductSuccessState());
    }).catchError((error)
    {
      debugPrint("error in add new product ${error.toString()}");
      emit(AddNewProductErrorState());
    });
  }



  final picker = ImagePicker();
  File? selectImage;
  String? base64 ;
  String? imageName;

  Future<void> openCamera(context) async {
    final pickedFile = await picker.pickImage(
        imageQuality: 50,
        maxHeight: 300,
        maxWidth: 400,
        source: ImageSource.camera);
    if (pickedFile != null) {
      selectImage = File(pickedFile.path);
      // await  upload(selectImage);
    } else {
      debugPrint('No image selected.');
    }
    emit(SetImageProfileFromCamera());
  }

  Future<void> openGallery( context) async {
    final pickedFile = await picker.pickImage(
        imageQuality: 50,
        maxHeight: 300,
        maxWidth: 400,
        source: ImageSource.gallery);
    if (pickedFile != null) {
      selectImage = File(pickedFile.path);
      base64 = base64Encode(selectImage!.readAsBytesSync());
      imageName = selectImage?.path.split("_").last;
      debugPrint(imageName);
    } else {
      debugPrint('No image selected.');
    }
    emit(SetImageProfileFromGallery());
  }


  // File? file;
  // var response;
  //
  // Future uploadOnlyImage() async {
  //   emit(UploadLoadingState());
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     allowedExtensions: ["jpg", "png", "jpeg"],
  //     type: FileType.custom,
  //   );
  //   file = File(result?.files.single.path ?? "");
  //   debugPrint(result!.files.single.path);
  //   debugPrint(file);
  //   debugPrint("---------- uplod is done ------------");
  //   emit(UploadSuccessState());
  // }


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
        productImages.add(productImageUrl1 );
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
      debugPrint("error in uploadProductImage4 ${error.toString()}");
      emit(UploadImageToFireStorageErrorState4());
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
        emit(UploadImageToFireStorageSuccessState3());
      }).catchError((error)
      {
        debugPrint("error in getDownloadURL ${error.toString()}");
        emit(UploadImageToFireStorageErrorState5());
      });

    }).catchError((error)
    {
      debugPrint("error in uploadProductImage5 ${error.toString()}");
      emit(UploadImageToFireStorageErrorState5());
    });

  }

}