


import 'package:get/get.dart';
 import 'package:flutter/material.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';

class OrderDoneView extends StatelessWidget {
  String orderTime;

  OrderDoneView({Key? key,required this.orderTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor:ColorsManager.ColorHelper,
        leading: InkWell(child: const Icon(Icons.arrow_back_ios,size: 27,color:Colors.white),
          onTap:(){
           Get.offAll(const MainHome());
          },

        ),
      ),
      body:Column(
        children:  [
          const SizedBox(height: 50,),
          const Icon(Icons.check_circle,size:121,color:Colors.lightGreen,),
          const SizedBox(height: 40,),
         Custom_Text(text: 'orderSent'.tr,fontSize: 30,alignment:Alignment.center),
          const SizedBox(height: 11,),

          (orderTime!='onStore')?
          Column(
            children: [
              Custom_Text(text: 'orderTimeNote'.tr,
                  fontSize: 15,
                  color:Colors.blueGrey,
                  alignment:Alignment.center),
              const SizedBox(height: 11,),
              Custom_Text(text: 'thanks'.tr,
                  fontSize: 21,color:Colors.purple,
                  alignment:Alignment.center),
            ],
          ):const SizedBox(),




          const SizedBox(height: 12,),
          CustomButton(text: 'goHome'.tr, onPressed: (){
            Get.off(const MainHome());
          }, color1:ColorsManager.ColorHelper , color2: ColorsManager.primary2)
        ],
      ),
    );
  }
}
