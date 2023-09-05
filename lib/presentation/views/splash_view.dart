import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';
import '../resources/assets_manager.dart';
import 'Country/country_view.dart';
import 'Home/app_start.dart';


class SplashView extends StatefulWidget
 {
  const SplashView({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();

 }
class _MySplashScreenState extends State<SplashView>
{
  startTimer()
  {
    Timer(const Duration(seconds: 2), () async
    {
      Get.off(const MainHome());
    });
  }


  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context)
  {
    return
      Scaffold(
        backgroundColor: ColorsManager.primary2,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: ColorsManager.ColorHelper,
            toolbarHeight: 4,
          ),
          body:

          Stack(
            children: [
              Container(
                color:    ColorsManager.primary2,
                child:   Center(
                  child: Container(
                      color:ColorsManager.primary2,
                      height: 200, child:
                  SizedBox(
                      height: 320,
                      child:
                      Image.asset
                        (AssetsManager.Logo,fit:BoxFit.fill,))),
                ),
              ),
              Positioned(
                bottom: 151,
                left: 200,
                child:Center(
    child: LoadingAnimationWidget.fourRotatingDots(
    color: ColorsManager.ColorHelper2,
    size: 55,
    ),

                ) ),
            ],
    ))
    ;
  }
}


