

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';
import 'package:shop_app/presentation/views/auth/login_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:shop_app/presentation/widgets/custom_textformfield.dart';
import '../../bloc/auth/auth-states.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../const/app_message.dart';
import '../../resources/color_manager.dart';
import 'package:get/get.dart';
class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {


              if(state is SignUpSuccessState){

                appMessage(text: 'Register Done ');

                Get.offAll(const MainHome());

              }

              if(state is SignUpErrorState){

                appMessage(text: 'Something went wrong ');

              }

            },
            builder: (context, state) {
              AuthCubit cubit = AuthCubit.get(context);
              return Scaffold(
                backgroundColor:ColorsManager.primary,
                appBar: AppBar(
                  toolbarHeight: 55,
                  leading: IconButton(icon:const Icon(Icons.arrow_back_ios,color:ColorsManager.primary,size: 28,

                  ),onPressed:(){
                    Get.back();
                  },),
                  backgroundColor:ColorsManager.ColorHelper,
                ),
                body:SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      children:  [
                        const SizedBox(height: 11,),
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.black,
                          child: SizedBox(
                            height: 240,
                            child: Image.asset(AssetsManager.Logo,
                              fit:BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        CustomTextFormField(hint: StringManger.Email,
                            obx: false, ontap: (){}, type: TextInputType.emailAddress, obs:false, color:ColorsManager.primary
                            , controller: cubit.emailController),
                        const SizedBox(height: 20,),
                        CustomTextFormField(hint:StringManger.UserName,
                            obx: false, ontap: (){}, type: TextInputType.text, obs:false, color:ColorsManager.primary
                            , controller: cubit.nameController),
                        const SizedBox(height: 30,),
                        CustomTextFormField(hint: StringManger.Pass,
                            obx: true, ontap: (){}, type: TextInputType.visiblePassword, obs:true, color:ColorsManager.primary
                            , controller: cubit.passController),
                        const SizedBox(height: 20,),
                        CustomButton(text: 'Login', onPressed: (){
                          cubit.userSignUp();
                          }, color1: ColorsManager.ColorHelper, color2:ColorsManager.primary),
                        const SizedBox(height: 34,),
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Custom_Text(text: '  I have an account',fontSize:17,color:ColorsManager.ColorHelper),
                              SizedBox(width: 30,),
                              Custom_Text(text:StringManger.Login,fontSize:15,color:Colors.grey,),
                            ],
                          ),
                          onTap:(){
                            Get.to(const LoginView());
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
