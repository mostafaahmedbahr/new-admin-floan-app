
 import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:floan_app_for_admin/pages/remove_product/remove_product_cubit/cubit.dart';
import 'package:floan_app_for_admin/pages/remove_product/remove_product_cubit/states.dart';
import 'package:floan_app_for_admin/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';

class RemoveProductScreen extends StatefulWidget {
  const RemoveProductScreen({Key? key}) : super(key: key);

  @override
  State<RemoveProductScreen> createState() => _RemoveProductScreenState();
}

class _RemoveProductScreenState extends State<RemoveProductScreen> {
  @override
  Widget build(BuildContext context) {
         return BlocProvider(
      create: (context)=>RemoveProductCubit()..getAllProducts(),
      child: BlocConsumer<RemoveProductCubit,RemoveProductStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = RemoveProductCubit.get(context);
          return SafeArea(child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.mainColorBlack,
              elevation: 0,
              title: const Text("Remove Product"),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                  cubit.allProducts[index]["name"]==null?
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
                                     cubit.allProducts[index]["new_price"]==null?
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
                                     cubit.allProducts[index]["old_price"]==null?
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
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Delete Product"),
                                        content: const Text("Are You Sure To Delete This product"),
                                        actions: [
                                          TextButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                            child: const Text("No"),
                                          ),
                                          TextButton(
                                            onPressed: ()async{
                                              await cubit.deleteImagesFromStorage(index);
                                               await cubit.deleteProduct(cubit.allProducts[index].id );
                                            await  cubit.getAllProducts();
                                              // ignore: use_build_context_synchronously
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Yes"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },

                                icon: const Icon(Icons.delete_forever_outlined,
                                  size: 40,
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
