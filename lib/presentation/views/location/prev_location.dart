//
//
// import 'package:get_storage/get_storage.dart';
//  import 'package:flutter/material.dart';
// import 'package:shop_app/domain/models/cart_model.dart';
// import 'package:shop_app/presentation/resources/color_manager.dart';
// import 'package:shop_app/presentation/views/checkout/checkout_view.dart';
// import 'package:shop_app/presentation/widgets/Custom_Text.dart';
// import 'package:shop_app/presentation/widgets/Custom_button.dart';
// import 'package:get/get.dart';
// import 'location_form_view.dart';
//
// class PrevLocationView extends StatelessWidget {
//   List <CartProductModel> order;
//   String total;
//
//
//   PrevLocationView({required this.order, required this.total});
//
//   @override
//    Widget build(BuildContext context) {
//     final box=GetStorage();
//
// String adress=box.read('address')??'x';
// String home=box.read('home')??'x';
// String phone=box.read('phone')??'x';
// String floor=box.read('floor')??'x';
//      return  Scaffold(
//        appBar:AppBar(
//          toolbarHeight: 46,
//          leading: InkWell(child: const Icon(Icons.arrow_back_ios,size: 27,color:Colors.white),
//            onTap:(){
//              Get.back();
//            },
//
//          ),
//          backgroundColor:ColorsManager.ColorHelper,
//        ),
//        body:ListView(
//          children: [
//            const SizedBox(height: 20,),
//            Card(
//              child:Column(
//                children: [
//                  const SizedBox(height: 12,),
//                  Custom_Text(text: adress,fontSize: 20,alignment: Alignment.center,),
//                  const SizedBox(height: 12,),
//                  Custom_Text(text: phone,fontSize: 20,alignment: Alignment.center,),
//                  const SizedBox(height: 12,),
//
//                  Custom_Text(text: home,fontSize: 20,alignment: Alignment.center,),
//                  const SizedBox(height: 12,),
//                  Custom_Text(text: floor,fontSize: 20,alignment: Alignment.center,),
//                  const SizedBox(height: 12,),
//                ],
//              ),
//            ),
//            const SizedBox(height: 22,),
//            CustomButton(text: 'Next ', onPressed:(){
//              Get.to(CheckOutView(order: order, total: total,
//              address: adress,
//                phone: phone,
//                floor: floor,
//                home: home,
//              ));
//            }, color1:ColorsManager.ColorHelper, color2:ColorsManager.primary2),
//            const SizedBox(height: 22,),
//            CustomButton(text: 'New Address', onPressed:(){
//
//              Get.to(LocationFormView(
//                total: total,
//                order: order,
//              ));
//
//            }, color1:ColorsManager.ColorHelper, color2:ColorsManager.primary2)
//          ],
//        ),
//      );
//    }
//  }
