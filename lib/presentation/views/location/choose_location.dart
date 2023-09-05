
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/controller/map_controller.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/Home/main_home.dart';
import 'package:shop_app/presentation/views/location/get_current_location.dart';
import 'package:shop_app/presentation/views/location/location_form_view.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import '../../../domain/models/cart_model.dart';
import 'map_view.dart';

class ChooseLocationView extends StatelessWidget {

  List <CartProductModel> order;
  String total;

  ChooseLocationView({Key? key,required this.total,required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller=Get.put(MapController());

    return  Scaffold(
      backgroundColor: ColorsManager.primary,
      appBar:AppBar(
        backgroundColor: ColorsManager.ColorHelper2,
        toolbarHeight: 55,
        leading:IconButton(icon: const Icon(Icons.arrow_back_ios,color:ColorsManager.white,),
        onPressed:(){
          Get.offAll(const MainHome());
        },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            const SizedBox(height: 31,),
            SizedBox(
              height: 137,
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(height: 31,),
            CustomButton(
              text: 'current'.tr,
              onPressed:(){
               controller.checkLocationPermission();
                controller.getCurrentLocation();
                Future.delayed(const Duration(seconds: 2)).then((value) {
                  Get.to(SearchPlacesScreen2(
                    total: total,
                    order: order,
                  ));
                });

              },
              color1:ColorsManager.ColorHelper2,
              color2:ColorsManager.white,
            ),
            const SizedBox(height: 31,),
            CustomButton(
              text: 'onStore'.tr,
              onPressed:(){
                Get.to(LocationFormView(
                  total: total,
                  order: order,
                  place: 'On Store',
                  lat: 0.0,
                  lng: 0.0,
                ));
              },
              color1:ColorsManager.ColorHelper2,
              color2:ColorsManager.white,
            ),
            const SizedBox(height: 31,),
            CustomButton(
              text: 'gift'.tr,
              onPressed:(){
                Get.to(LocationFormView(
                  total: total,
                  order: order,
                  place: 'Gift For Someone',
                  lat: 0.0,
                  lng: 0.0,
                ));
              },
              color1:ColorsManager.ColorHelper2,
              color2:ColorsManager.white,
            )
          ],
        ),
      ),
    );
  }
}
