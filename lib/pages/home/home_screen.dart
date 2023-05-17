 import 'package:floan_app_for_admin/pages/home/home_cubit/cubit.dart';
import 'package:floan_app_for_admin/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Sh/shared_pref.dart';
import '../../core/colors.dart';
import '../../widgets/custom_sized_box.dart';
import '../add_new_product/add_new_product_screen.dart';
import '../remove_product/remove_product.dart';
import '../update_product/update_product_screen.dart';
import 'home_cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => HomeCubit()..getUserData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            }));
          }
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.mainColorWhite,
              actions: [
                IconButton(
                  onPressed: () {
                    cubit.logout();
                  },
                  icon: const Icon(Icons.logout,color: AppColors.mainColor,),
                ),
              ],
              leading:   Image.asset("assets/images/logoo2.png",
                width: 32.0,
                height: 32.0,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: ()async{

              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const AddNewProductScreen();
                        }));
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.mainColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Add New Product",
                              style: TextStyle(
                                color: AppColors.mainColorWhite,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const CustomSizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const RemoveProductScreen();
                        }));
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.mainColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Remove Product",
                              style: TextStyle(
                                color: AppColors.mainColorWhite,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const CustomSizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const UpdateProductScreen();
                        }));
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.mainColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Update Product",
                              style: TextStyle(
                                color: AppColors.mainColorWhite,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
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
