import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:floan_app_for_admin/pages/home/home_screen.dart';
import 'package:floan_app_for_admin/pages/register/register_cubit/states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../core/colors.dart';
import '../../core/toast/toast.dart';
import '../../core/toast/toast_states.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_sized_box.dart';
import '../../widgets/custom_text.dart';
import 'register_cubit/cubit.dart';

class SignUpScreen extends StatelessWidget {
    const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context)=>RegisterCubit()  ,
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is CreateUserSuccessState){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const HomeScreen();
            }));
          }
          if(state is RegisterErrorState) {
            ToastConfig.showToast(
              msg: state.errorMsg,
              toastStates: ToastStates.Error,
            );
          }
          if(state is CreateUserErrorState) {
            ToastConfig.showToast(
              msg: state.errorMsg,
              toastStates: ToastStates.Error,
            );
          }
        },
        builder: (context,state){
          var cubit = RegisterCubit.get(context);
          return  SafeArea(
            child: StreamBuilder<ConnectivityResult>(
                stream: Connectivity().onConnectivityChanged,
                builder: (context,snapshot){
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: AppColors.mainColorBlack,
                      elevation: 0,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back,
                          color: AppColors.mainColor,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    body: snapshot.data == ConnectivityResult.none ?
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/wifi.png",
                            height: 100,),
                          const CustomSizedBox(
                            height: 20,
                          ),
                          const CustomText(text: "No Internet",
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.black87,),
                        ],
                      ),
                    ):
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/newlogo.png",
                                    width: 200,
                                    height: 200,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      CustomText(
                                        text: "Sign",
                                        fontSize: 50,
                                        textColor: AppColors.mainColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        text: "UP",
                                        fontSize: 50,
                                        textColor:
                                        AppColors.mainColorWhite,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  const CustomText(text: "Sign with us to know more ...",
                                    fontSize: 20,
                                    textColor: Colors.grey,
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                      color: AppColors.mainColorWhite,
                                    ),
                                    keyboardType: TextInputType.name,
                                    controller: cubit.nameCon,
                                    validator: (value)
                                    {
                                      if(value!.isEmpty)
                                      {
                                        return "Please Enter Your Name";
                                      }
                                      return null;
                                    },
                                    decoration:const InputDecoration(
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
                                      hintText: "Name",
                                      hintStyle: TextStyle(
                                        color:AppColors.mainColorWhite,
                                      ),
                                      prefixIcon: Icon(Icons.person,
                                        color: AppColors.mainColor,),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                      color: AppColors.mainColorWhite,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    controller: cubit.emailCon,
                                    validator: (value)
                                    {
                                      if(value!.isEmpty || value.length < 6)
                                      {
                                        return "Please Enter Your Email";
                                      }
                                      return null;
                                    },
                                    decoration:const InputDecoration(
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
                                          color: AppColors.mainColor),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                      color: AppColors.mainColorWhite,
                                    ),
                                    keyboardType: TextInputType.phone,
                                    controller: cubit.phone,
                                    validator: (value)
                                    {
                                      if(value!.isEmpty || value.length < 11)
                                      {
                                        return "Please Enter Your phone";
                                      }
                                      return null;
                                    },
                                    decoration:const InputDecoration(
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
                                      hintText: "Phone",
                                      hintStyle: TextStyle(
                                        color: AppColors.mainColorWhite,
                                      ),
                                      prefixIcon: Icon(Icons.phone,
                                          color: AppColors.mainColor),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                      color: AppColors.mainColorWhite,
                                    ),
                                    keyboardType: TextInputType.text,
                                    controller: cubit.shopNameCon,
                                    validator: (value)
                                    {
                                      if(value!.isEmpty )
                                      {
                                        return "Please Enter Your Shop Name";
                                      }
                                      return null;
                                    },
                                    decoration:const InputDecoration(
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
                                      hintText: "Shop Name",
                                      hintStyle: TextStyle(
                                        color: AppColors.mainColorWhite,
                                      ),
                                      prefixIcon: Icon(Icons.home_work_rounded,
                                          color: AppColors.mainColor),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
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
                                        return "Config Your password";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border:const OutlineInputBorder(),
                                      enabledBorder:const  OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.mainColorWhite,
                                          )
                                      ),
                                      focusedBorder:  const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.mainColorWhite,
                                          )
                                      ),
                                      hintText: "password",
                                      hintStyle: const TextStyle(
                                        color: AppColors.mainColorWhite,
                                      ),
                                      prefixIcon:const Icon(Icons.lock,
                                          color: AppColors.mainColor),
                                      suffixIcon: IconButton(
                                        color: Colors.white,
                                        icon: cubit.isVisible ?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                                        onPressed: (){
                                          cubit.changeSuffixIcon();
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                      color: AppColors.mainColorWhite,
                                    ),
                                    obscureText: cubit.isVisible,
                                    controller: cubit.configPassCon,
                                    validator: (value){
                                      if(value!.isEmpty)
                                      {
                                        return "Config Your password";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border:const OutlineInputBorder(),
                                      enabledBorder:const  OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.mainColorWhite,
                                          )
                                      ),
                                      focusedBorder:  const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.mainColorWhite,
                                          )
                                      ),
                                      hintText: "confirm password",
                                      hintStyle: const TextStyle(
                                        color: AppColors.mainColorWhite,
                                      ),
                                      prefixIcon:const Icon(Icons.lock,
                                          color: AppColors.mainColor),
                                      suffixIcon: IconButton(
                                        color: Colors.white,
                                        icon: cubit.isVisible ?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                                        onPressed: (){
                                          cubit.changeSuffixIcon();
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(
                                            color: AppColors.mainColorWhite,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text("Lat : ${cubit.lat}",style: const TextStyle(
                                            color: AppColors.mainColorWhite,
                                          ),),
                                        ),
                                      )),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          border: Border.all(
                                            color: AppColors.mainColorWhite,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text('Long : ${cubit.long}',style: const TextStyle(
                                            color: AppColors.mainColorWhite,
                                          ),),
                                        ),
                                      )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  ConditionalBuilder(
                                    condition:  state is ! GetLatLonLoadingState  ,
                                    fallback: (context)=>const Center(
                                      child: CircularProgressIndicator(color: AppColors.mainColor,),
                                    ),
                                 builder: (context){
                                      return Row(
                                        children: [
                                          Expanded(child: CustomButton(
                                            height: 50,
                                            onPressed: (){
                                              cubit.checkLocationEnabled();
                                              // if(state is CheckLocationEnabledState ){
                                              //   cubit.getLatLong();
                                              // }
                                            },
                                            btnText: const Text("Pick Your Location"),
                                            btnColor: AppColors.mainColor,
                                          )),
                                        ],
                                      );
                                 },
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  ConditionalBuilder(
                                    condition: state is! RegisterLoadingState ,
                                    builder: (context)=> SizedBox(
                                      width: double.infinity,
                                      height: 60,
                                      child: CustomButton(
                                        height: 60,
                                        onPressed: () async{
                                          if (formKey.currentState!.validate()){
                                            cubit.register(
                                              name: cubit.nameCon.text,
                                              email: cubit.emailCon.text,
                                              password: cubit.passCon.text,
                                              phone: cubit.phone.text,
                                              lat: cubit.lat,
                                              long: cubit.long,
                                              shopName: cubit.shopNameCon.text,
                                            );
                                          }
                                          print("000000");
                                        },
                                        btnColor: AppColors.mainColor,
                                        btnText: const CustomText(
                                          text: "Sign Up",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                        width: double.infinity,
                                      ),
                                    ),
                                    fallback: (context)=>const Center(
                                      child: CircularProgressIndicator(color: AppColors.mainColor,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }

            ),
          );
        },

      ),
    );
  }
}