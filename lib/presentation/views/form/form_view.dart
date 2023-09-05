


 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:shop_app/presentation/widgets/custom_textformfield.dart';

import '../../const/app_message.dart';

class FormView extends StatelessWidget {

 FormView({Key? key}) : super(key: key);

  TextEditingController comController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ColorsManager.ColorHelper,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios,color:ColorsManager.white,)),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 22,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(hint: 'complaints'.tr, obx: false,max: 10,
                  ontap: (){}, type: TextInputType.text, obs: false, color:ColorsManager.TextColor1,
                  controller:comController),
            ),
            const SizedBox(height: 22,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField
                (hint: 'phone'.tr, obx: false,max: 3,
                  ontap: (){}, type: TextInputType.text,
                  obs: false, color:ColorsManager.TextColor1,
                  controller:phoneController),
            ),
            const SizedBox(height: 21,),
            CustomButton(text: 'send'.tr, onPressed:(){
              addOrderToFireBase(phoneController.text);
            }, color1:ColorsManager.ColorHelper, color2:ColorsManager.white)
          ],
        ),
      ),
    );
  }
  addOrderToFireBase(String phone) async {

    final box=GetStorage();
    String email=box.read('email')??"";



    await FirebaseFirestore.instance
        .collection('complaints').add({
      'msg':comController.text,
      'email':email,
      'phone':phone,
    }).then((value) {
      appMessage(text: 'orderSent'.tr);
      Get.offAll(const MainHome());
    });
  }
}
//complaints

