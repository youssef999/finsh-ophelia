
import 'package:get/get.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/views/auth/sign_up_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:shop_app/presentation/widgets/custom_textformfield.dart';
import '../../bloc/auth/auth-states.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/strings_manager.dart';
import '../Home/main_home.dart';
import 'forgot_pass_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if(state is LoginSuccessState){
                appMessage(text: 'تم تسجيل الدخول بنجاح');
                Get.offAll(const MainHome());
              }
            },
            builder: (context, state) {

              AuthCubit cubit = AuthCubit.get(context);
              return Scaffold(
                backgroundColor:ColorsManager.primary,
                appBar: AppBar(
                  toolbarHeight: 50,
                  backgroundColor:ColorsManager.ColorHelper,
                  leading: InkWell(child: const Icon(Icons.arrow_back_ios,size: 27,color:Colors.white),
                    onTap:(){
                      Get.back();
                    },
                  ),
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
                        CustomTextFormField(hint:StringManger.Email,
                            obx: false, ontap: (){}, type: TextInputType.emailAddress, obs:false, color:ColorsManager.primary
                            , controller: cubit.emailController),
                        const SizedBox(height: 30,),
                        CustomTextFormField(hint: StringManger.Pass,
                            obx: true, ontap: (){}, type: TextInputType.visiblePassword, obs:true, color:ColorsManager.primary
                            , controller: cubit.passController),
                        const SizedBox(height: 20,),
                        CustomButton(text: StringManger.Login, onPressed: (){
                          cubit.userLogin();
                        }, color1: ColorsManager.ColorHelper, color2:ColorsManager.primary),
                        
                        const SizedBox(height: 34,),
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Custom_Text(text:StringManger.DonthaveAccount,fontSize:17,color:ColorsManager.ColorHelper,),
                              SizedBox(width: 30,),
                              Custom_Text(text: StringManger.CreateNewAccount,fontSize:15,color:Colors.grey,),
                            ],
                          ),
                          onTap:(){
                            Get.to(const SignUpView());
                          },
                        ),
                        const SizedBox(height: 34,),
                        //ForgotPassView
                        InkWell(
                          child: Row(
                            children: const [
                              SizedBox(width: 38,),
                              Custom_Text(text: StringManger.ForgotPass,
                              fontSize: 16,
                                alignment:Alignment.center,
                                color:Colors.grey,
                              ),
                              SizedBox(width: 22,),
                              Custom_Text(text: StringManger.ResetPass,
                                fontSize: 16,
                                alignment:Alignment.center,
                                color:ColorsManager.ColorHelper,
                              ),

                            ],
                          ),
                          onTap:(){

                            Get.to(const ForgotPassView());

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
