import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../resources/color_manager.dart';

appMessage({required String text}){

  Fluttertoast.showToast(
      msg:text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 4,
      backgroundColor: ColorsManager.ColorHelper,
      textColor: Colors.white,
      fontSize: 16.0);
  // Get.snackbar ("   $text ", '',colorText:ColorsManager.primary2,
  //     backgroundColor:Colors.black45,
  //     icon:const Icon(Icons.app_shortcut,color:ColorsManager.primary2,size:33,)
  // );
}


// String currency = 'currency'.tr;