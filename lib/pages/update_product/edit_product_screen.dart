
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:floan_app_for_admin/core/colors.dart';
 import 'package:floan_app_for_admin/pages/update_product/update_cubit/cubit.dart';
import 'package:floan_app_for_admin/pages/update_product/update_cubit/states.dart';
import 'package:floan_app_for_admin/pages/update_product/update_product_screen.dart';
import 'package:floan_app_for_admin/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/nav.dart';
import '../../widgets/custom_sized_box.dart';


class EditProductScreen extends StatefulWidget {
      EditProductScreen({Key? key,
      required this.name,
        required this.nameAr,
        required this.des,
        required this.colors,
      required this.oldPrice,
      required this.newPrice,
      required this.model,
      required this.brand,
      required this.type,
      required this.title,
      required this.productId,
      required this.image1,
      required this.image2,
      required this.image3,
        required this.image4,
        required this.image5,
    }) : super(key: key);
    String? image1;
    String? image2;
    String? image3;
      String? image4;
      String? image5;
   String? productId;
   String? name;
      String? nameAr;
      String? des;
      String? colors;
   dynamic oldPrice;
   dynamic newPrice;
   // String? discount;
   String? model;
   String? brand;
   String? type;
   String? title;
  // final String size;
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  List<String> sizes = ['S', 'L', 'XL',"2XL","3XL","4XL","5XL"];
  List<String> selectedSizes = [];
  @override
  Widget build(BuildContext context) {
    print(widget.oldPrice);
    return BlocProvider(
      create: (context) => UpdateProductCubit(),
      child: BlocConsumer<UpdateProductCubit, UpdateProductStates>(
        listener: (context, state) {
          if (state is UpdateProductSuccessState) {
            var snackBar = const SnackBar(
              content: Text('Done'),
              backgroundColor: AppColors.secondMainColor,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            UpdateProductCubit.get(context).getAllProducts();

          }
        },
        builder: (context, state) {
          var cubit = UpdateProductCubit.get(context);
          print("asasasasas");
          return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.mainColorBlack,
                  elevation: 0,
                  title: const Text("Edit Product"),

                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  cubit.getImage();
                                },
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColorBlack,
                                    border: Border.all(
                                      color: AppColors.mainColorWhite,
                                    ),
                                  ),
                                  child:
                                  cubit.productImage1 == null
                                      ? Image.network("${widget.image1}",fit: BoxFit.cover)
                                      :Image.file(cubit.productImage1!,fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            const CustomSizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  cubit.getImage2();
                                },
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColorBlack,
                                    border: Border.all(
                                      color: AppColors.mainColorWhite,
                                    ),
                                  ),
                                  child: cubit.productImage2 == null
                                      ? Image.network("${widget.image2}",fit: BoxFit.cover)
                                      : Image.file(cubit.productImage2!,fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            const CustomSizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  cubit.getImage3();
                                },
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColorBlack,
                                    border: Border.all(
                                      color: AppColors.mainColorWhite,
                                    ),
                                  ),
                                  child: cubit.productImage3 == null
                                      ? Image.network("${widget.image3}",fit: BoxFit.cover)
                                      : Image.file(cubit.productImage3!,fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const CustomSizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  cubit.getImage4();
                                },
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColorBlack,
                                    border: Border.all(
                                      color: AppColors.mainColorWhite,
                                    ),
                                  ),
                                  child:
                                  cubit.productImage4 == null
                                      ? Image.network("${widget.image4}",fit: BoxFit.cover)
                                      :Image.file(cubit.productImage4!,fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            const CustomSizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  cubit.getImage5();
                                },
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColorBlack,
                                    border: Border.all(
                                      color: AppColors.mainColorWhite,
                                    ),
                                  ),
                                  child: cubit.productImage5 == null
                                      ? Image.network("${widget.image5}",fit: BoxFit.cover,)
                                      : Image.file(cubit.productImage5!,fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            const CustomSizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {

                                },
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColorBlack,

                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                            state is UploadImageToFireStorageSuccessState1 ||
                            state is UploadImageToFireStorageSuccessState2 ||
                            state is UploadImageToFireStorageSuccessState3 ||
                            state is UploadImageToFireStorageSuccessState4 ||
                            state is UploadImageToFireStorageSuccessState5
                            ? const Center(
                          child:  Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 30,
                          ),
                        ) :
                        ConditionalBuilder(
                          condition: state
                          is! UploadImageToFireStorageLoadingState1 && state
                          is! UploadImageToFireStorageLoadingState2 && state
                          is! UploadImageToFireStorageLoadingState3 && state
                          is! UploadImageToFireStorageLoadingState4 && state
                          is! UploadImageToFireStorageLoadingState5,
                          fallback: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.mainColor,
                              ),
                            );
                          },
                          builder: (context){
                            return CustomButton(
                              height: 50,
                              width: double.infinity,
                              btnColor: AppColors.mainColor,
                              btnText: const Text("OK"),
                              onPressed: () {
                                if(cubit.productImage1!=null){
                                  cubit.uploadProductImage1();
                                  // cubit.productImages.add(cubit.productImageUrl1);
                                }
                                else{
                                  cubit.productImages.add("${widget.image1}");
                                }

                                if(cubit.productImage2!=null){
                                  cubit.uploadProductImage2();
                                  // cubit.productImages.add(cubit.productImageUrl2);
                                }
                                else{
                                  cubit.productImages.add("${widget.image2}");
                                }

                                if(cubit.productImage3!=null){
                                  cubit.uploadProductImage3();
                                  // cubit.productImages.add(cubit.productImageUrl3);
                                }
                                else{
                                  cubit.productImages.add("${widget.image3}");
                                }

                                if(cubit.productImage4!=null){
                                  cubit.uploadProductImage4();
                                  // cubit.productImages.add(cubit.productImageUrl4);
                                }
                                else{
                                  cubit.productImages.add("${widget.image4}");
                                }

                                if(cubit.productImage5!=null){
                                  cubit.uploadProductImage5();
                                  // cubit.productImages.add(cubit.productImageUrl5);
                                }
                                else{
                                  cubit.productImages.add("${widget.image5}");
                                }

                              },
                            );
                          },
                        ),
                        const CustomSizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: widget.name,
                                onChanged: (newVal){
                                  cubit.newName = newVal;
                                  print(cubit.newName);
                                },
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                  color: AppColors.mainColorWhite,
                                ),
                                // controller: cubit.productNameCon,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter the product name ..";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorWhite,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorWhite,
                                      )),
                                  hintText: "Product Name",
                                  hintStyle: TextStyle(
                                    color: AppColors.mainColorWhite,
                                  ),
                                ),
                              ),
                            ),
                            const CustomSizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: widget.nameAr,
                                onChanged: (newVal){
                                  cubit.newNameAr = newVal;
                                  print(cubit.newNameAr);
                                },
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                  color: AppColors.mainColorWhite,
                                ),
                                // controller: cubit.productNameCon,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter the product name ..";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorWhite,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorWhite,
                                      )),
                                  hintText: "اسم المنتج",
                                  hintStyle: TextStyle(
                                    color: AppColors.mainColorWhite,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const CustomSizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: widget.des,
                          onChanged: (newVal){
                            cubit.newDes = newVal;
                            print(cubit.newDes);
                          },
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: AppColors.mainColorWhite,
                          ),
                          // controller: cubit.productNameCon,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter the product des ..";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.mainColorWhite,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.mainColorWhite,
                                )),
                            hintText: "Product des",
                            hintStyle: TextStyle(
                              color: AppColors.mainColorWhite,
                            ),
                          ),
                        ),
                        const CustomSizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          initialValue: widget.colors,
                          onChanged: (newVal){
                            cubit.newColors = newVal;
                            print(cubit.newColors);
                          },
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: AppColors.mainColorWhite,
                          ),
                          // controller: cubit.productNameCon,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter the product new Colors ..";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.mainColorWhite,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.mainColorWhite,
                                )),
                            hintText: "Product Colors",
                            hintStyle: TextStyle(
                              color: AppColors.mainColorWhite,
                            ),
                          ),
                        ),
                        const CustomSizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: widget.oldPrice.toString(),
                                onChanged: (newVal){
                                  cubit.newOldPrice = int.tryParse(newVal);
                                  print(cubit.newOldPrice);
                                },
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: AppColors.mainColorWhite,
                                ),
                                // controller: cubit.productOldPriceCon,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter the product old price ..";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorWhite,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorWhite,
                                      )),
                                  hintText: "Old Price",
                                  hintStyle: TextStyle(
                                    color: AppColors.mainColorWhite,
                                  ),
                                ),
                              ),
                            ),
                            const CustomSizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: widget.newPrice,
                                onChanged: (newVal){
                                  cubit.newNewPrice = int.tryParse(newVal);
                                  print(cubit.newNewPrice);
                                },
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                  color: AppColors.mainColorWhite,
                                ),
                                // controller: cubit.productNewPriceCon,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter the product new price ..";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorWhite,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorWhite,
                                      )),
                                  hintText: "New Price",
                                  hintStyle: TextStyle(
                                    color: AppColors.mainColorWhite,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const CustomSizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: widget.model,
                                onChanged: (newVal){
                                  cubit.newModel =  newVal;
                                  print(cubit.newModel);
                                },
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                  color: AppColors.mainColorWhite,
                                ),
                                // controller: cubit.productModelCon,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter the product model ..";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorWhite,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorWhite,
                                      )),
                                  hintText: "Model",
                                  hintStyle: TextStyle(
                                    color: AppColors.mainColorWhite,
                                  ),
                                ),
                              ),
                            ),
                            const CustomSizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: widget.brand,
                                onChanged: (newVal){
                                  cubit.newBrand =  newVal;
                                  print(cubit.newBrand);
                                },
                                keyboardType: TextInputType.text,
                                style: const TextStyle(
                                  color: AppColors.mainColorWhite,
                                ),
                                // controller: cubit.productBrandCon,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "please enter the product brand..";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorWhite,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.mainColorWhite,
                                      )),
                                  hintText: "Brand",
                                  hintStyle: TextStyle(
                                    color: AppColors.mainColorWhite,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const CustomSizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: AppColors.mainColorWhite),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton(
                                    dropdownColor: AppColors.mainColor,
                                    underline: const SizedBox(),
                                    hint:  Text(
                                      "${widget.type}",
                                      style:const TextStyle(
                                        color: AppColors.mainColorWhite,
                                      ),
                                    ),
                                    isExpanded: true,
                                    items: cubit.types.map((type) {
                                      return DropdownMenuItem(
                                        value: type,
                                        child: Text(
                                          type,
                                          style: const TextStyle(
                                            color: AppColors.mainColorWhite,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (type) {
                                      cubit.changeSelectType(type);
                                    },
                                    value: cubit.selectType,
                                  ),
                                ),
                              ),
                            ),
                            const CustomSizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: AppColors.mainColorWhite),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton(
                                    dropdownColor: AppColors.mainColor,
                                    underline: const SizedBox(),
                                    hint:  Text(
                                      "${widget.title}",
                                      style: const TextStyle(
                                        color: AppColors.mainColorWhite,
                                      ),
                                    ),
                                    isExpanded: true,
                                    items: cubit.sortinges.map((sort) {
                                      return DropdownMenuItem(
                                        value: sort,
                                        child: Text(
                                          sort,
                                          style: const TextStyle(
                                            color: AppColors.mainColorWhite,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (sort) {

                                      cubit.changeSelectSort(sort);
                                    },
                                    value: cubit.selectSort,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const CustomSizedBox(
                          height: 10,
                        ),
                        // SizedBox(
                        //   height: 40,
                        //   child: ListView.separated(
                        //     scrollDirection: Axis.horizontal,
                        //     shrinkWrap: true,
                        //     itemBuilder: (context, index) {
                        //       return InkWell(
                        //         onTap: () {
                        //           cubit.selectSize(index);
                        //           print(cubit.listOfSelectedSizes[index].size);
                        //         },
                        //         child: Container(
                        //           height: 40,
                        //           width: 40,
                        //           decoration: BoxDecoration(
                        //             color:
                        //                 cubit.listOfSizes[index].isSelected == false
                        //                     ? AppColors.mainColorBlack
                        //                     : Colors.green,
                        //             border: Border.all(
                        //               color: AppColors.mainColorWhite,
                        //             ),
                        //           ),
                        //           child: Center(
                        //             child: Text(
                        //               "${cubit.listOfSizes[index].size}",
                        //               style: const TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 20,
                        //                   color: AppColors.mainColorWhite),
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     separatorBuilder: (context, index) {
                        //       return const SizedBox(
                        //         width: 10,
                        //       );
                        //     },
                        //     itemCount: cubit.listOfSizes.length,
                        //   ),
                        // ),
                        Column(
                          children: sizes.map((item) {
                            bool isChecked = selectedSizes.contains(item);
                            return CheckboxListTile(
                              activeColor: Colors.green,
                              title: Text(item,style: const TextStyle(
                                color: Colors.white,
                              ),),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value!) {
                                    selectedSizes.add(item);
                                  } else {
                                    selectedSizes.remove(item);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                        const CustomSizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          condition: cubit.isLoad!=true,
                          fallback: (context) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.mainColor,
                              ),
                            );
                          },
                          builder: (context) {
                            return CustomButton(
                              height: 50,
                              width: double.infinity,
                              btnColor: AppColors.mainColor,
                              btnText: const Text("Edit"),
                              onPressed: () {
                                //q4DxJ1XdaP4IEQgCdUPU
                                // AppNav.customNavigator(
                                //   context: context,
                                //   screen: UpdateProductScreen(),
                                //   finish: true,
                                // );

                                FirebaseFirestore.instance.collection("AllProducts").doc(widget.productId).update(
                                    {
                                      "name" : cubit.newName?? widget.name,
                                      "description" :  cubit.newDes?? widget.des,
                                      "old_price" : cubit.newOldPrice?? widget.oldPrice,
                                      "brand" : cubit.newBrand?? widget.brand,
                                      "model" :cubit.newModel?? widget.model,
                                      "new_price" :cubit.newNewPrice?? widget.newPrice,
                                      "title" : cubit.selectType?? widget.type  ,
                                      "type_category" : cubit.selectSort ?? widget.title,
                                      if( selectedSizes.isNotEmpty)
                                      "size" : selectedSizes,
                                       if(cubit.productImages.isNotEmpty)
                                      "images" :  cubit.productImages ,
                                      "colors_available" :  cubit.newColors?? widget.colors,
                                    }
                                ).then((value)async{
                                  // await Future.delayed(Duration(seconds: 2));
                                  // cubit.isLoad = true;
                                  cubit.getAllProducts();
                                  // Navigator.pop(context);
                                  AppNav.customNavigator(
                                    context: context,
                                    screen: UpdateProductScreen(),
                                    finish: true,
                                  );
                                });

                              },
                            );
                          },
                        ),

                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
