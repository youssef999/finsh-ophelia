
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/views/auth/login_view.dart';
import 'package:shop_app/presentation/views/auth/sign_up_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:shop_app/presentation/widgets/custom_textformfield.dart';
import '../../bloc/auth/auth-states.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../Home/main_home.dart';

class ForgotPassView extends StatelessWidget {
  const ForgotPassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              if(state is ForgotPassSuccessState){
                appMessage(text: 'checkEmail'.tr);
                Get.offAll(const LoginView());
              }
              if(state is ForgotPassErrorState){
                appMessage(text: 'Try Again Later !! ');
              }
            },
            builder: (context, state) {

              AuthCubit cubit = AuthCubit.get(context);

              return Scaffold(
                backgroundColor:ColorsManager.primary2,
                appBar: AppBar(
                  toolbarHeight: 2,
                  backgroundColor:ColorsManager.primary,
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
                        CustomTextFormField(hint: 'البريد الاكتروني',
                            obx: false, ontap: (){}, type: TextInputType.emailAddress, obs:false, color:ColorsManager.primary
                            , controller: cubit.emailController),

                        const SizedBox(height: 50,),

                        CustomButton(text: 'ارسال رسالة لبريدك الان ', onPressed: (){
                          cubit.resetPassword();
                        }, color1: ColorsManager.primary, color2:Colors.white),

                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
