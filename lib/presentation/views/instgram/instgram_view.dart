


 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class InstgramView extends StatefulWidget {
  const InstgramView({Key? key}) : super(key: key);

  @override
  State<InstgramView> createState() => _InstgramViewState();
}

class _InstgramViewState extends State<InstgramView> {

  void _openInstagramAccountOrCall() async {


      const String instagramAccount = "ophelia.flower1/"; // Replace with the Instagram account username you want to open

      const String instagramUrl = "https://www.instagram.com/$instagramAccount";

      if (await canLaunch(instagramUrl)) {
        await launch(instagramUrl);
        Future.delayed(const Duration(seconds: 3)).then((value) {
          Get.offAll(const MainHome());
        });
      } else {
        await launch(instagramUrl);
        Future.delayed(const Duration(seconds: 1)).then((value) {
          Get.offAll(const MainHome());
        });
        throw 'Could not launch $instagramUrl';
      }


      // Replace with the phone number you want to call
    }



  @override
  void initState() {
    _openInstagramAccountOrCall();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorsManager.ColorHelper,
      body:
      Center(
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

      // Stack(
      //   children: [
      //     Center(
      //       child: Column(
      //
      //         children: [
      //           const SizedBox(height: 22,),
      //           SizedBox(
      //             height: 444,
      //             child: Image.asset('assets/images/insta2.webp'),
      //           ),
      //           const SizedBox(height: 22,),
      //
      //           SizedBox(
      //             width: 222,
      //             child: CustomButton(text: 'Visit Instagram', onPressed:(){
      //
      //               _openInstagramAccountOrCall();
      //
      //               }, color1:ColorsManager.ColorHelper, color2:ColorsManager.primary),
      //           )
      //         ],
      //       ),
      //     ),
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //   ],
      // ),
    );
  }
}
