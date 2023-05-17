import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:floan_app_for_admin/Sh/shared_pref.dart';
import 'package:floan_app_for_admin/pages/login/login_cubit/cubit.dart';
import 'package:floan_app_for_admin/pages/login/login_cubit/states.dart';
import 'package:floan_app_for_admin/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/colors.dart';
import '../../core/toast/toast.dart';
import '../../core/toast/toast_states.dart';
import '../../widgets/custom_sized_box.dart';
import '../../widgets/custom_text.dart';
import '../home/home_screen.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
    const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState){

            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const HomeScreen();
            }));

          }
          if(state is LoginErrorState) {
            ToastConfig.showToast(
                msg: state.errorMsg,
                toastStates: ToastStates.Error,
            );
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return StreamBuilder<ConnectivityResult>(
            stream: Connectivity().onConnectivityChanged,
            builder: (context,snapshot){
              return Scaffold(
                body:snapshot.data == ConnectivityResult.none ?
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/wifi.png",
                        height: 100,),
                      const  CustomSizedBox(
                        height: 20,
                      ),
                      const  CustomText(text: "No Internet",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        textColor: Colors.black87,),
                    ],
                  ),
                ):
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/newlogo.png",
                              width: 300,
                              height: 300,
                            ),
                            const CustomSizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:const [
                                CustomText(text:"FLON",
                                  fontSize: 50,
                                  textColor: AppColors.mainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(text:"SHOP",
                                  fontSize: 50,
                                  textColor: AppColors.mainColorWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            const CustomText(text:"Welcome To Our Application",
                              fontSize: 20,
                              textColor: AppColors.grey,
                            ),
                            const CustomSizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color: AppColors.mainColorWhite,
                              ),
                              controller: cubit.emailCon,
                              validator: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return "the email is not correct ..";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border:OutlineInputBorder(),
                                enabledBorder:  OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.mainColorWhite,
                                    )
                                ),
                                focusedBorder:   OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.mainColorWhite,
                                    )
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: AppColors.mainColorWhite,
                                ),
                                prefixIcon: Icon(Icons.email,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            ),
                            const CustomSizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              style: const TextStyle(
                                color: AppColors.mainColorWhite,
                              ),
                              obscureText: cubit.isVisible,
                              controller: cubit.passCon,
                              validator: (value){
                                if(value!.isEmpty)
                                {
                                  return "the password not valid ...";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border:const OutlineInputBorder(),
                                enabledBorder:const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.mainColorWhite,
                                    )
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.mainColorWhite,
                                    )
                                ),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                  color:  AppColors.mainColorWhite,
                                ),
                                prefixIcon:const Icon(Icons.lock,
                                  color:  AppColors.mainColor,
                                ),
                                suffixIcon: IconButton(
                                  color: Colors.white,
                                  icon: cubit.isVisible ?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                                  onPressed: (){
                                    cubit.changeSuffixIcon();
                                  },
                                ),
                              ),
                            ),
                            const CustomSizedBox(
                              height: 30,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context){
                                return CustomButton(
                                  height: 60,
                                  width: double.infinity,
                                  btnColor: AppColors.mainColor,
                                  btnText: const CustomText(
                                    text: "LoGin",
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    textColor: AppColors.mainColorWhite,
                                  ),
                                  onPressed: () {
                                    // cubit.emailCon.text = "admin@gmail.com";
                                    // cubit.passCon.text = "123456";
                                    if (formKey.currentState!.validate()){
                                      cubit.login(
                                        email: cubit.emailCon.text,
                                        password: cubit.passCon.text,
                                      ) ;
                                    }
                                  },
                                );
                              },
                              fallback: (context)=>const Center(
                                child: CircularProgressIndicator(color: AppColors.mainColor,),
                              ),
                            ),
                            const CustomSizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CustomText(text: "Do't have an account ?",
                                  textColor:  AppColors.mainColorWhite,
                                ),
                                TextButton(
                                  onPressed: (){
                                    Navigator.push(
                                        context, PageTransition(
                                        duration: const Duration(milliseconds: 400),
                                        reverseDuration: const Duration(milliseconds: 400),
                                        type: PageTransitionType.leftToRight,
                                        child:   const SignUpScreen(),
                                        inheritTheme: true,
                                        ctx: context));
                                  },
                                  child:const CustomText(text: "Sign Up",
                                    textColor: AppColors.mainColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                            const CustomSizedBox(
                              height: 15,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Image.asset("assets/images/facebook1.png",height: 50,),
                            //     const CustomSizedBox(
                            //       width: 20,
                            //     ),
                            //     Image.asset("assets/images/google.png",height: 50,),
                            //
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}