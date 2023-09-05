

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/localization/local_controller.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';

class LocalView extends GetWidget<LocaleController> {
  const LocalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor:ColorsManager.ColorHelper,
        leading: InkWell(child: const Icon(Icons.arrow_back_ios,size: 27,color:Colors.white),
          onTap:(){
            Get.back();
          },
        ),
      ),
      body:Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
     //   mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60,),
            CustomButton(text: 'English', onPressed: (){
              controller.changeLang('en');
              Get.offAll(const MainHome());
            }
                , color1:ColorsManager.ColorHelper
                , color2: ColorsManager.primary),

            const SizedBox(height: 30,),

            CustomButton(text: 'العربية ', onPressed: (){
              controller.changeLang('ar');
              Get.offAll(const MainHome());
            }
                , color1:ColorsManager.ColorHelper
                , color2: ColorsManager.primary)
          ],
        ),
      ),
    );
  }
}
