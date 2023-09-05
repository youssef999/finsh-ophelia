 import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';

import '../../const/app_message.dart';
import 'auth-states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AppIntialState());

  static AuthCubit get(context) => BlocProvider.of(context);

  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController checkPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;


  final ScrollController scrollController = ScrollController();

  bool isEndOfList = false;

  void scrollListener() {

    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {

        isEndOfList = true;

    } else {

        isEndOfList = false;

    }
  }




  changePassword() async {

    if(passController.text==checkPassController.text 
    && passController.text.length>5){
      try{
        emit(ChangePassLoadingState());
        await user!.updatePassword(passController.text.toString());
        emit(ChangePassSuccessState());
      }  catch(e){
        print(e);
        emit(ChangePassErrorState());
      }
    }else{
      appMessage
      (text:'كلمة المرور غير متطابقة او عددها اقل من 6 ');
    }
    }

   Future<void> resetPassword() async {
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) {
            emit(ForgotPassSuccessState());
          });
          // Password reset email sent successfully
        } catch (e) {
          // Handle any errors that occur during the password reset process
          print('Error sending password reset email: $e');
          emit(ForgotPassErrorState());
        }

    }

  userLogin() async {
    final box = GetStorage();
    if(emailController.text.length>2 && passController.text.length>5){
      try {
        emit(LoginLoadingState());
        await _auth
            .signInWithEmailAndPassword(
            email: emailController.text, password: passController.text)
            .then((value) async {

              print("val$value");

          emit(LoginSuccessState());
          box.write('email', emailController.text);
          box.write('pass', passController.text);
          box.write('name', nameController.text);
        });
      } catch (e) {

        String error='';
        print(e);
        if(e.toString().contains('The password is invalid')){
          error='كلمة مرور خاطئة';
        }
      else  if(e.toString().contains('There is no user record')){
          error='البريد الالكتروني خاطئ';
        }
      else{
        error='حدث خطا تاكد من ادخال البيانات بشكل سليم';
        }
        //
        appMessage(text: error);
        emit(LoginErrorState());

      }

    }else{

      if(emailController.text.contains('@')==false){
        appMessage(text: 'ادخل البريد الالكتروني بشكل سليم');
      }

      if(passController.text.length<5){
        appMessage(text: 'ادخل كلمة المرور بشكل سليم ');
      }

    }

  }

  userSignUp() async {
    final box = GetStorage();
    try {
      emit(SignUpLoadingState());
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      ).then((user) async {
        emit(SignUpSuccessState());
       box.write('email', emailController.text);
       box.write('name', nameController.text);
      });
    }
    catch (e) {
      print(e);
      emit(SignUpErrorState());
    }
  }


}
