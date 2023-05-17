import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:floan_app_for_admin/core/colors.dart';
import 'package:floan_app_for_admin/core/constants.dart';
import 'package:floan_app_for_admin/core/toast/toast.dart';
import 'package:floan_app_for_admin/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Sh/shared_pref.dart';
import '../../core/toast/toast_states.dart';
import '../../widgets/custom_sized_box.dart';
import 'add_new_product_cubit/cubit.dart';
import 'add_new_product_cubit/states.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({Key? key}) : super(key: key);

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  List<String> sizes = ['S', 'L', 'XL',"2XL","3XL","4XL","5XL"];
  List<String> selectedSizes = [];
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AddNewProductCubit(),
      child: BlocConsumer<AddNewProductCubit, AddNewProductsStates>(
        listener: (context, state) {
          if (state is AddNewProductSuccessState) {
            var snackBar = const SnackBar(
              content: Text('Done'),
              backgroundColor: AppColors.secondColorGrey,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          var cubit = AddNewProductCubit.get(context);
          var formKey = GlobalKey<FormState>();
          // print(SharedPreferencesHelper.getData(key: "uId"));
          // print(SharedPreferencesHelper.getData(key: "lat"));
          print(cubit.productImage4);
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.mainColorBlack,
              elevation: 0,
              title: const Text("Add New Product"),
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
                              child: cubit.productImage1 == null
                                  ? const Icon(
                                      Icons.upload_rounded,
                                      color: AppColors.mainColorWhite,
                                      size: 40,
                                    )
                                  : Image.file(cubit.productImage1!),
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
                                  ? const Icon(
                                      Icons.upload_rounded,
                                      color: AppColors.mainColorWhite,
                                      size: 40,
                                    )
                                  : Image.file(cubit.productImage2!),
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
                                  ? const Icon(
                                      Icons.upload_rounded,
                                      color: AppColors.mainColorWhite,
                                      size: 40,
                                    )
                                  : Image.file(cubit.productImage3!),
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
                              child: cubit.productImage4 == null
                                  ? const Icon(
                                Icons.upload_rounded,
                                color: AppColors.mainColorWhite,
                                size: 40,
                              )
                                  : Image.file(cubit.productImage4!),
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
                                  ? const Icon(
                                Icons.upload_rounded,
                                color: AppColors.mainColorWhite,
                                size: 40,
                              )
                                  : Image.file(cubit.productImage5!),
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
                              decoration: const BoxDecoration(
                                color: AppColors.mainColorBlack,
                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                    const CustomSizedBox(
                      height: 10,
                    ),
                    state is UploadImageToFireStorageSuccessState1 || state is UploadImageToFireStorageSuccessState2 || state is UploadImageToFireStorageSuccessState3
                    || state is UploadImageToFireStorageSuccessState4 || state is UploadImageToFireStorageSuccessState5
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
                          if(cubit.productImage1==null || cubit.productImage2==null
                          || cubit.productImage3==null
                          || cubit.productImage4==null
                          || cubit.productImage5==null ){
                            ToastConfig.showToast(msg: "Please Enter All Images", toastStates: ToastStates.Error);
                          }
                            else{
                            cubit.uploadProductImage1();
                            cubit.uploadProductImage2();
                            cubit.uploadProductImage3();
                            cubit.uploadProductImage4();
                            cubit.uploadProductImage5();
                          }

                          },
                        );
                      },
                    ),
                    // Row(
                    //   children: [
                    //     // Expanded(
                    //     //   child: state is UploadImageToFireStorageSuccessState1
                    //     //       ? const Icon(
                    //     //           Icons.check_circle,
                    //     //           color: Colors.green,
                    //     //           size: 30,
                    //     //         )
                    //     //       : ConditionalBuilder(
                    //     //           condition: state
                    //     //               is! UploadImageToFireStorageLoadingState1,
                    //     //           fallback: (context) {
                    //     //             return const Center(
                    //     //               child: CircularProgressIndicator(
                    //     //                 color: AppColors.mainColor,
                    //     //               ),
                    //     //             );
                    //     //           },
                    //     //           builder: (context) {
                    //     //             return TextButton(
                    //     //                 onPressed: () {
                    //     //                   cubit.uploadProductImage1();
                    //     //                 },
                    //     //                 child: const Text(
                    //     //                   "ok",
                    //     //                   style: TextStyle(
                    //     //                     color: Colors.white,
                    //     //                   ),
                    //     //                 ));
                    //     //           },
                    //     //         ),
                    //     // ),
                    //     Expanded(
                    //       child: state is UploadImageToFireStorageSuccessState2
                    //           ? const Icon(
                    //               Icons.check_circle,
                    //               color: Colors.green,
                    //               size: 30,
                    //             )
                    //           : ConditionalBuilder(
                    //               condition: state
                    //                   is! UploadImageToFireStorageLoadingState2,
                    //               fallback: (context) {
                    //                 return const Center(
                    //                   child: CircularProgressIndicator(
                    //                     color: AppColors.mainColor,
                    //                   ),
                    //                 );
                    //               },
                    //               builder: (context) {
                    //                 return TextButton(
                    //                     onPressed: () {
                    //                       cubit.uploadProductImage2();
                    //                     },
                    //                     child: const Text(
                    //                       "ok",
                    //                       style: TextStyle(
                    //                         color: Colors.white,
                    //                       ),
                    //                     ));
                    //               },
                    //             ),
                    //     ),
                    //     Expanded(
                    //       child: state is UploadImageToFireStorageSuccessState3
                    //           ? const Icon(
                    //               Icons.check_circle,
                    //               color: Colors.green,
                    //               size: 30,
                    //             )
                    //           : ConditionalBuilder(
                    //               condition: state
                    //                   is! UploadImageToFireStorageLoadingState3,
                    //               fallback: (context) {
                    //                 return const Center(
                    //                   child: CircularProgressIndicator(
                    //                     color: AppColors.mainColor,
                    //                   ),
                    //                 );
                    //               },
                    //               builder: (context) {
                    //                 return TextButton(
                    //                     onPressed: () {
                    //                       cubit.uploadProductImage3();
                    //                     },
                    //                     child: const Text(
                    //                       "ok",
                    //                       style: TextStyle(
                    //                         color: Colors.white,
                    //                       ),
                    //                     ));
                    //               },
                    //             ),
                    //     ),
                    //   ],
                    // ),
                    const CustomSizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            color: AppColors.mainColorWhite,
                          ),
                          controller: cubit.productNameCon,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter the product english name ..";
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
                            hintText: "Product English Name",
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
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                              color: AppColors.mainColorWhite,
                            ),
                            controller: cubit.productNameArCon,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "please enter the product arabic name ..";
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
                              hintText: "Product Arabic Name",
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
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: AppColors.mainColorWhite,
                      ),
                      controller: cubit.productColorsCon,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter the product colors ..";
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
                    TextFormField(
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: AppColors.mainColorWhite,
                      ),
                      controller: cubit.productDesCon,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter the product description ..";
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
                        hintText: "Product Description",
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
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              color: AppColors.mainColorWhite,
                            ),
                            controller: cubit.productOldPriceCon,
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
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              color: AppColors.mainColorWhite,
                            ),
                            controller: cubit.productNewPriceCon,
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
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                              color: AppColors.mainColorWhite,
                            ),
                            controller: cubit.productModelCon,
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
                            keyboardType: TextInputType.text,
                            style: const TextStyle(
                              color: AppColors.mainColorWhite,
                            ),
                            controller: cubit.productBrandCon,
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
                                hint: const Text(
                                  "Select Type",
                                  style: TextStyle(
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
                                hint: const Text(
                                  "اختر صنف",
                                  style: TextStyle(
                                    color: AppColors.mainColorWhite,
                                  ),
                                ),
                                isExpanded: true,
                                items: cubit.typesAr.map((type) {
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
                                  cubit.changeSelectTypeAr(type);
                                },
                                value: cubit.selectArType,
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
                                hint: const Text(
                                  "Select Sort",
                                  style: TextStyle(
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
                                hint: const Text(
                                  "اختر التصنيف",
                                  style: TextStyle(
                                    color: AppColors.mainColorWhite,
                                  ),
                                ),
                                isExpanded: true,
                                items: cubit.sortingesAr.map((sort) {
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
                                  cubit.changeSelectSortAr(sort);
                                },
                                value: cubit.selectSortAr,
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
                      condition: state is! AddNewProductLoadingState,
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
                          btnText: const Text("Add"),
                          onPressed: () {
                            if(cubit.productImage1==null || cubit.productImage2==null
                                || cubit.productImage3==null
                                || cubit.productImage4==null
                                || cubit.productImage5==null ){
                              ToastConfig.showToast(msg: "Please Enter All Images", toastStates: ToastStates.Error);
                            }
                            else {

                            cubit.addNewProduct(
                              adminId: SharedPreferencesHelper.getData(key: "uId"),
                              // productId : SharedPreferencesHelper.getData(key: "productId"),
                              name: cubit.productNameCon.text,
                              nameAr: cubit.productNameArCon.text,
                              des: cubit.productDesCon.text,
                              oldPrice: int.parse(cubit.productOldPriceCon.text),
                              newPrice: int.parse(cubit.productNewPriceCon.text),
                              discount: cubit.productDiscountCon.text,
                              model: cubit.productModelCon.text,
                              brand: cubit.productBrandCon.text,
                              lat: SharedPreferencesHelper.getData(key: "latNew"),
                              lang: SharedPreferencesHelper.getData(key: "longNew"),
                              shopName: SharedPreferencesHelper.getData(key: "shopNameNew"),
                              type: cubit.selectType.toString(),
                              typeAr: cubit.selectArType.toString(),
                              sorting: cubit.selectSort.toString(),
                              sortingAr: cubit.selectSortAr.toString(),
                              colors: cubit.productColorsCon.text,
                              sizes:selectedSizes,
                              images: cubit.productImages,
                            );
                            }
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
