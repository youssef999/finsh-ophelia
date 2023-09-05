

 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';

class AboutView2 extends StatelessWidget {
  const AboutView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading:IconButton(
          icon:const Icon(Icons.arrow_back_ios,
          size: 32,color:ColorsManager.primary,
          ),
          onPressed:(){
            Get.back();
          },
        ),
        backgroundColor:ColorsManager.ColorHelper,
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Custom_Text(
                text: 'who'.tr.toString().replaceAll('About Us', ''),

              fontSize: 21,color:ColorsManager.black,
            )
          ],
        ),
      ),
    );
  }
}
