

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/localization/local_controller.dart';
import 'package:shop_app/localization/local_view.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/views/About/about_view.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';
import 'package:shop_app/presentation/views/orders/order_view.dart';
import 'package:shop_app/presentation/views/privacy&about/about_view.dart';
import 'package:shop_app/presentation/views/privacy&about/privacy_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../resources/color_manager.dart';
import '../views/form/form_view.dart';
import 'Custom_Text.dart';

class MainDrawer extends StatefulWidget {

  const MainDrawer();
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          Container(
            height: 150,
            color: ColorsManager.primary,
            child:Image.asset(AssetsManager.Logo),
          ),
                  const SizedBox(height: 20,),
            
                  InkWell(child: Row(
                    children: [
                      const SizedBox(width: 15,),
                      const Icon(Icons.home_filled,size: 37,color:ColorsManager.ColorHelper,),
                      const SizedBox(width: 21,),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Custom_Text(text: 'home'.tr,fontSize: 19,color:ColorsManager.ColorHelper,
                        height: 1,alignment:Alignment.center,
                        ),
                      ),
                    ],
                  ),
                    onTap:(){
                    Get.offAll(const MainHome());
                    },
                  ),


                  const SizedBox(height: 20,),
                  InkWell(child: Row(
                    children: [
                      const SizedBox(width: 15,),
                      const Icon(Icons.list_alt_rounded,size: 37,color:ColorsManager.ColorHelper,),
                      const SizedBox(width: 11,),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Custom_Text(text: 'myorders'.tr,fontSize: 19,color:ColorsManager.ColorHelper,
                          height: 1,alignment:Alignment.center,
                        ),
                      ),
                    ],
                  ),
                    onTap:(){
                    Get.to(const OrdersView());
                      //Get.offAll(const MainHome());
                    },
                  ),












                  const SizedBox(height: 20,),
                  InkWell(child: Row(
                    children: [
                      const SizedBox(width: 15,),
                      const Icon(Icons.verified_user_sharp,size: 37,color:ColorsManager.ColorHelper,),
                      const SizedBox(width: 11,),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Custom_Text(text:'about'.tr,fontSize: 19,color:ColorsManager.ColorHelper,
                          height: 1,alignment:Alignment.center,
                        ),
                      ),
                    ],
                  ),
                    onTap:(){

                      Get.to(const AboutView2());
                      //_openInstagramAccountOrCall(6);
                      //Get.offAll(const MainHome());
                    },
                  ),

                  const SizedBox(height: 20,),

                  InkWell(child: Row(
                    children: [
                      const SizedBox(width: 15,),
                      const Icon(Icons.web_asset,size: 37,color:ColorsManager.ColorHelper,),
                      const SizedBox(width: 11,),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Custom_Text(text:'about2'.tr,fontSize: 19,color:ColorsManager.ColorHelper,
                          height: 1,alignment:Alignment.center,
                        ),
                      ),
                    ],
                  ),
                    onTap:(){
                      //Get.to(const AboutView());
                      _openInstagramAccountOrCall(6);
                      //Get.offAll(const MainHome());
                    },
                  ),

                  const SizedBox(height: 20,),


                  InkWell(child:Row(
                    children: [
                      const SizedBox(width: 15,),
                      const Icon(Icons.assignment_late_sharp,size: 37,color:ColorsManager.ColorHelper,),
                      const SizedBox(width: 11,),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Custom_Text(text: 'comp'.tr,fontSize: 19,color:ColorsManager.ColorHelper,
                          height: 1,alignment:Alignment.center,
                        ),
                      ),
                    ],
                  ),
                    onTap:(){
                      Get.to(FormView());
                    },
                  ),
                  const SizedBox(height: 20,),
                  InkWell(child: Row(
                    children: [
                      const SizedBox(width: 15,),
                      const Icon(Icons.call,size: 37,color:ColorsManager.ColorHelper,),
                      const SizedBox(width: 11,),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Custom_Text(text: "call".tr,fontSize: 19,color:ColorsManager.ColorHelper,
                          height: 1,alignment:Alignment.center,
                        ),
                      ),
                    ],
                  ),
                    onTap:(){
                      openWhatsApp("+966537755534",'');
                    },
                  ),
                  const SizedBox(height: 20,),
                  InkWell(child: Row(
                    children: [
                      const SizedBox(width: 15,),
                      const Icon(Icons.translate,size: 37
                        ,color:ColorsManager.ColorHelper,),
                      const SizedBox(width: 11,),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Custom_Text(text: "translate".tr,fontSize: 19,color:ColorsManager.ColorHelper,
                          height: 1,alignment:Alignment.center,
                        ),
                      ),
                    ],
                  ),
                    onTap:(){
                      Get.to(const LocalView());
                    },
                  ),
                  const SizedBox(height: 20,),
                  InkWell(child:  Row(
                    children: [
                      const SizedBox(width: 15,),
                      const Icon(Icons.tiktok,size: 37,color:ColorsManager.ColorHelper,),
                      const SizedBox(width: 11,),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Custom_Text(text: "tiktok".tr,fontSize: 19,color:ColorsManager.ColorHelper,
                          height: 1,alignment:Alignment.center,
                        ),
                      ),
                    ],
                  ),
                    onTap:(){
                      _openInstagramAccountOrCall(5);
                    },
                  ),
                  const SizedBox(height: 20,),
                  InkWell(child: Row(
                    children: [
                      const SizedBox(width: 15,),
                      const Icon(Icons.privacy_tip,size: 37,color:ColorsManager.ColorHelper,),
                      const SizedBox(width: 11,),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Custom_Text(text: "privacy".tr,fontSize: 19,color:ColorsManager.ColorHelper,
                          height: 1,alignment:Alignment.center,
                        ),
                      ),
                    ],
                  ),
                    onTap:(){
                      Get.to(const PrivacyView());
                    },
                  ),
                  // const SizedBox(height: 20,),
                  // InkWell(child:const Row(
                  //   children: [
                  //     SizedBox(width: 15,),
                  //     Icon(Icons.touch_app,size: 37,color:ColorsManager.ColorHelper,),
                  //     SizedBox(width: 11,),
                  //     Padding(
                  //       padding: EdgeInsets.only(top:8.0),
                  //       child: Custom_Text(text: "About Us",fontSize: 19,color:ColorsManager.ColorHelper,
                  //         height: 1,alignment:Alignment.center,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //   onTap:(){
                  //     Get.to(const AboutView());
                  //     },
                  // ),


//PrivacyView
//https://www.tiktok.com/@ophelia.flower1?_t=8We2elm58SX&_r=1


        ]))));
  }
}

void _openInstagramAccountOrCall(int index) async {


  if(index==6){
    //https://opheliashop.com/%D8%B9%D9%86%D8%A7
    const String tiktok = "https://opheliashop.com/%D8%B9%D9%86%D8%A7"; // Replace with the phone number you want to call

    if (await canLaunch(tiktok)) {
      await launch(tiktok);
    } else {
      await launch(tiktok);
      //   throw 'Could not launch $phoneNumber';
    }
  }
  if(index==5){
    const String tiktok = "https://www.tiktok.com/@ophelia.flower1?_t=8We2elm58SX&_r=1"; // Replace with the phone number you want to call

    if (await canLaunch(tiktok)) {
      await launch(tiktok);
    } else {
      await launch(tiktok);
   //   throw 'Could not launch $phoneNumber';
    }
  }
  else if(index==3){
    const String instagramAccount = "ophelia.flower1/"; // Replace with the Instagram account username you want to open

    const String instagramUrl = "https://www.instagram.com/$instagramAccount/";

    if (await canLaunch(instagramUrl)) {
      await launch(instagramUrl);
    } else {
      await launch(instagramUrl);
      throw 'Could not launch $instagramUrl';
    }

  }else{
    const String phoneNumber = "+966537755534"; // Replace with the phone number you want to call
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      await launch(phoneNumber);
      throw 'Could not launch $phoneNumber';
    }
  }

}

void openWhatsApp(String phoneNumber, String message) async {
  // The 'whatsapp://' scheme is used to open WhatsApp
  // Replace the country code prefix '+' with '00' for international numbers
  String url =
     // "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}";

  'tel:+$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    await launch(url);
    throw "Could not launch WhatsApp.";
  }
}