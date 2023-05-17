// ignore_for_file: use_build_context_synchronously

 import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
 import 'package:floan_app_for_admin/pages/update_product/update_cubit/cubit.dart';
import 'package:floan_app_for_admin/pages/update_product/update_cubit/states.dart';
import 'package:floan_app_for_admin/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors.dart';
import 'edit_product_screen.dart';
class UpdateProductScreen extends StatelessWidget {
  const UpdateProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>UpdateProductCubit()..getAllProducts(),
      child: BlocConsumer<UpdateProductCubit,UpdateProductStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = UpdateProductCubit.get(context);
          return SafeArea(child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.mainColorBlack,
              elevation: 0,
              title: const Text("Update Product"),
            ),

            body: RefreshIndicator(
              onRefresh: ()async {
                cubit.getAllProducts();
              },
              child: ConditionalBuilder(
                condition: state is !GetAllProductsLoadingState,
                builder: (context){
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:cubit.allProducts.isEmpty ?
                    const
                    Center(
                      child: Text("No Product Yet",
                        style: TextStyle(
                          color: AppColors.mainColorWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),),
                    ) :
                    ListView.separated(
                      key: UniqueKey(),
                      itemBuilder: (context,index)
                      {
                        return Container(
                          padding:const EdgeInsets.all(10),
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Row(
                            children: [
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(10),
                              //   child:cubit.allProducts[index]["images"].isEmpty?
                              //   Image.asset("assets/images/photo.png") :
                              //   Image.network("${cubit.allProducts[index]["images"][0]}",
                              //     width: 20,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:cubit.allProducts[index]["images"]==null?
                                  Image.asset("assets/images/photo.png") :
                                  Image.network("${cubit.allProducts[0]["images"][0]}",
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const CustomSizedBox(width: 20,),
                              const CustomSizedBox(width: 20,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  cubit.allProducts[index]["name"]==""?
                                  const Text("no name",
                                    style:   TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.mainColorWhite,
                                    ),):
                                  Text("${cubit.allProducts[index]["name"]}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.mainColorWhite,
                                    ),),
                                  Row(
                                    children: [
                                      cubit.allProducts[index]["new_price"]==""?
                                      const Text("no price",
                                        style:   TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.mainColorWhite,
                                        ),):
                                      Text("${cubit.allProducts[index]["new_price"]}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.mainColorWhite,
                                        ),),
                                      const CustomSizedBox(width: 10,),
                                      cubit.allProducts[index]["old_price"]==""?
                                      const Text("no old price",
                                        style:   TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.mainColorWhite,
                                        ),):
                                      Text("${cubit.allProducts[index]["old_price"]}",
                                        style: const TextStyle(
                                          decoration: TextDecoration. lineThrough,
                                          decorationColor: AppColors.mainColor,
                                          decorationStyle: TextDecorationStyle.solid,
                                          decorationThickness: 2.0,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.mainColorWhite,
                                        ),),
                                    ],
                                  ),

                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: (){
                                  debugPrint("${cubit.allProducts[index]["images"][2]}");
                                  debugPrint( cubit.allProducts[index]["name"]);
                                  print(cubit.allProducts[index].id);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)
                                  {
                                    return    EditProductScreen(
                                        image1: "${cubit.allProducts[index]["images"][0]}",
                                        image2:"${cubit.allProducts[index]["images"][1]}",
                                        image3:"${cubit.allProducts[index]["images"][2]}",
                                      image4:"${cubit.allProducts[index]["images"][3]}",
                                      image5:"${cubit.allProducts[index]["images"][4]}",
                                      productId: cubit.allProducts[index].id,
                                        name: "${cubit.allProducts[index]["name"]}",
                                      nameAr: "${cubit.allProducts[index]["nameAr"]}",
                                        des:"${cubit.allProducts[index]["description"] }",
                                      colors:"${cubit.allProducts[index]["colors_available"] }",
                                        oldPrice: cubit.allProducts[index]["old_price"] ,
                                        newPrice:"${cubit.allProducts[index]["new_price"] }",
                                        model:  "${cubit.allProducts[index]["model"] }",
                                        brand: "${cubit.allProducts[index]["brand"] }",
                                        type:"${cubit.allProducts[index]["type_category"] }",
                                      title:"${cubit.allProducts[index]["title"] }",
                                        // size:"${cubit.allProducts[index]["brand"] }",
                                    );
                                  }));
                                },

                                icon: const Icon(Icons.edit,
                                  size: 30,
                                  color: AppColors.mainColor,
                                ),
                              ),
                              const CustomSizedBox(width: 20,),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context,index){
                        return const CustomSizedBox(height: 20,);
                      },
                      itemCount: cubit.allProducts.length,
                    ),
                  );
                },
                fallback: (context){
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  );
                },
              ),
            ),


          ));
        },

      ),
    );
  }
}
