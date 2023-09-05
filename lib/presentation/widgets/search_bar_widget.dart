
import 'package:flutter/material.dart';
import 'package:get/get.dart';




Widget showSearchBarWidget(TextEditingController name){
  return Padding

    (padding: const EdgeInsets.symmetric(
    horizontal: 18,
  ),

    child:TextField(
      controller: name,
      style:const TextStyle(
        fontSize: 16,
        color:Colors.black,
      ),



    ),
  );
}