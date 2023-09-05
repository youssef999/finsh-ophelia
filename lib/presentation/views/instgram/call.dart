


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Home/main_home.dart';

class CallView extends StatefulWidget {
  const CallView({Key? key}) : super(key: key);

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {

  @override
  void initState() {
    _openInstagramAccountOrCall(4);
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Get.offAll(const MainHome());
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:     Center(
        child: Positioned(
          left: 200,
          top:333,
          child: Container(
            height: 130,
            width: 100,
            decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color:ColorsManager.kAccent
            ),
            child: Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: ColorsManager.ColorHelper2,
                size: 60,
              ),
            ),
          ),
        ),
      )

      // Center(
      //   child: Column(
      //
      //     children: [
      //       const SizedBox(height: 22,),
      //       SizedBox(
      //         height: 444,
      //         child: Image.asset('assets/images/call.png'),
      //       ),
      //       const SizedBox(height: 22,),
      //
      //       SizedBox(
      //         width: 222,
      //         child: CustomButton(text: ' Call ', onPressed:(){
      //
      //           _openInstagramAccountOrCall(4);
      //
      //         }, color1:ColorsManager.ColorHelper, color2:ColorsManager.primary),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
void _openInstagramAccountOrCall(int index) async {


  if(index==3){
    const String instagramAccount = "https://instagram.com/thewebops?igshid=NTc4MTIwNjQ2YQ=="; // Replace with the Instagram account username you want to open

    const String instagramUrl = "https://www.instagram.com/$instagramAccount/";

    if (await canLaunch(instagramUrl)) {
      await launch(instagramUrl);
    } else {
      await launch(instagramUrl);
      throw 'Could not launch $instagramUrl';
    }
  }else
  {

    const String phoneNumber = "+966537755534";
    String url = "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent('')}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await launch(url);
      throw "Could not launch WhatsApp.";
    }
  }

}