import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';
import 'package:shop_app/domain/models/cart_model.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/views/checkout/pay_ipanQr.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/cart/cart_states.dart';
import '../../resources/color_manager.dart';
import 'order_done_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 class CheckOutView extends StatefulWidget {
   List <CartProductModel> order;
   String total;
   String place;
   String address,
   delNote1,delNote2
   , deliveryTime, phone, home, floor, name, email, recName, msg,
       sender, song, notes;
   double lat, lng;

   CheckOutView({super.key,
     required this.delNote1,required this.delNote2,
     required this.deliveryTime, required this.place, required this.order, required this.total, required this.home,
     required this.email, required this.name, required this.song, required this.notes, required this.msg
     , required this.recName, required this.sender, required this.lat, required this.lng,
     required this.phone, required this.address, required this.floor});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {

 @override
  void initState() {
   fetchTokens();
    super.initState();
  }

   @override
   Widget build(BuildContext context) {

     addOrderToFireBase(String payment, String subTotal,
         String deliveryFee) async {
       print(widget.email);
       final box = GetStorage();
       // box.write('email', email);
       box.write('phone', widget.phone);
       DateTime now = DateTime.now();
       String currentDate = '${now.year}-${now.month}-${now.day}';
       String currentTime = '${now.hour}:${now.minute}:${now.second}';
       List<String>orderNames = [];
       List<String>orderQuant = [];
       List<String>orderPrice = [];
       List<String>orderImage = [];
       String orderId = generateRandomString(18);
       for (int i = 0; i < widget.order.length; i++) {
         orderNames.add(widget.order[i].name!);
       }
       for (int i = 0; i < widget.order.length; i++) {
         orderImage.add(widget.order[i].image!);
       }
       for (int i = 0; i < widget.order.length; i++) {
         orderQuant.add(widget.order[i].quantity.toString());
       }

       for (int i = 0; i < widget.order.length; i++) {
         orderPrice.add(widget.order[i].price.toString());
       }


       await FirebaseFirestore.instance.collection('orders').add({
         'order_id': orderId,
         'deliveryTime': widget.deliveryTime,
         'order': [
           for(int i = 0; i < widget.order.length; i++)
             {
               "name": orderNames[i],
               "quant": orderQuant[i],
               "price": orderPrice[i],
               "image": orderImage[i]
             }
         ],
         'payment_type': payment,
          "delNote1":widget.delNote1,
         "delNote2":widget.delNote2,
         'user_name': widget.name,
         'user_email': widget.email,
         'address': widget.address,
         'phone': widget.phone,
         'home': widget.home,
         'floor': widget.floor,
         'total': widget.total,
         'subTotal': subTotal,
         'DeliveryFee': deliveryFee,
         'date': currentDate,
         'time': currentTime,
         'status': 'waiting',
         'msg': widget.msg,
         'sender': widget.sender,
         'song': widget.song,
         'notes': widget.notes,
         'recName': widget.recName,
         'currency': "currency".tr
       }).then((value) {
         appMessage(text: 'orderSent'.tr);
         Get.offAll(OrderDoneView(
           orderTime: widget.deliveryTime,
         ));
       });
     }


     return BlocProvider(
         create: (BuildContext context) =>
         CartCubit()
           ..getAllProduct()
           ..checkLocationPermission()
           ..getLocationDistance(widget.lat, widget.lng),
         child: BlocConsumer<CartCubit, CartStates>(
             listener: (context, state) {

             },
             builder: (context, state) {
               CartCubit cubit = CartCubit.get(context);
               if (widget.place == 'Gift For Someone') {
                 cubit.distancePrice = 30.0;
               }
               return Scaffold(
                 appBar: AppBar(
                   toolbarHeight: 50,
                   backgroundColor: ColorsManager.ColorHelper,
                   title: Custom_Text(text: 'confirmOrder'.tr
                       , fontSize: 29, color: ColorsManager.primary
                       , alignment: Alignment.center),
                   leading: InkWell(child: const Icon(
                       Icons.arrow_back_ios, size: 27, color: Colors.white),
                     onTap: () {
                       Get.back();
                     },

                   ),
                 ),
                 bottomNavigationBar: Container(
                   color: ColorsManager.ColorHelper,
                   height: 140,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       const SizedBox(
                         height: 5,
                       ),
                       Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [

                             Custom_Text(text:
                             "${'totalOrder'.tr} = ",
                               color: ColorsManager.primary,
                             ),

                             Custom_Text(text: widget.total.toString(),
                               color: ColorsManager.primary,
                             ),
                           ],
                         ),
                       ),
                       const SizedBox(
                         height: 5,
                       ),
                       Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Custom_Text(text: "${'deliveryFee'.tr}",
                               color: ColorsManager.primary,
                             ),
                             const SizedBox(width: 10,),
                             Custom_Text(text: cubit.distancePrice.toString(),
                               color: ColorsManager.primary,
                             ),
                           ],
                         ),
                       ),
                       const SizedBox(
                         height: 5,
                       ),
                       Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Custom_Text(text: 'total'.tr + " = ",
                               color: ColorsManager.primary,
                             ),
                             const SizedBox(width: 10,),
                             Custom_Text(text: (double.parse(widget.total)
                                 + cubit.distancePrice).toString() + " " +
                                 "currency".tr,
                               color: ColorsManager.primary,
                             ),
                           ],
                         ),
                       ),
                       const SizedBox(
                         height: 5,
                       ),
                       CustomButton(
                         text: 'confirmOrder'.tr,
                         color1: ColorsManager.primary,
                         color2: ColorsManager.ColorHelper,
                         onPressed: () {
                           if (cubit.selectedOption != '' &&
                               cubit.selectedOption != 'payOnlineFromStore' &&
                               cubit.selectedOption != 'payOnlineDeliverToHome'
                           ) {

                             sendNotificationToSellerNow

                               (token: tokenDataList);


                             addOrderToFireBase(cubit.selectedOption,
                                 (double.parse(widget.total)
                                     + cubit.distancePrice).toString(),
                                 cubit.distancePrice.toString()
                             );
                             cubit.DeleteAll(widget.order[0]);
                           } else {
                             appMessage(text: 'selectPay'.tr,);
                           }
                         },
                       ),
                       const SizedBox(
                         height: 5,
                       ),
                     ],
                   ),
                 ),
                 body: ListView(
                   children: [
                     const SizedBox(height: 22,),

                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Custom_Text(text: 'paymentType'.tr,
                         fontSize: 26,
                         color: ColorsManager.black,
                         alignment: Alignment.center,
                         fontWeight: FontWeight.w800,
                       ),
                     ),

                     (cubit.checkLocation == true && widget.place != 'On Store'
                         || widget.place == 'Gift For Someone'
                             && widget.place != 'On Store') ?
                     RadioListTile(
                       activeColor: ColorsManager.ColorHelper,
                       title: Text('cash'.tr),
                       value: 'Cash On Delivery',
                       groupValue: cubit.selectedOption,
                       onChanged: (value) {
                         print(value);
                         cubit.changeSelectedOption(value!);
                         // setState(() {
                         //   selectedOption = value;
                         // });
                       },
                     ) : Column(
                       children: [
                         // Custom_Text(text: 'cash'.tr,fontSize: 21,
                         // alignment:Alignment.center,color:ColorsManager.black,
                         // ),

                         (widget.place != 'On Store') ?
                         Custom_Text(text: 'ava'.tr,
                           fontSize: 15,
                           alignment: Alignment.center,
                           color: ColorsManager.ColorHelper,
                         ) : const SizedBox()
                       ],
                     ),

                     (widget.place != 'Gift For Someone') ?
                     RadioListTile(
                       activeColor: ColorsManager.ColorHelper,
                       title: Text('onStore'.tr),
                       value: 'On Store',
                       groupValue: cubit.selectedOption,
                       onChanged: (value) {
                         cubit.changeSelectedOption(value!);
                         // setState(() {
                         //   selectedOption = value;
                         // });
                       },
                     ) : const SizedBox(),

                     (cubit.checkLocation == true
                         || widget.place == 'Gift For Someone') ?
                     RadioListTile(
                       activeColor: ColorsManager.ColorHelper,
                       title: Text('payOnline2'.tr),
                       value: 'payOnlineDeliverToHome',
                       groupValue: cubit.selectedOption,
                       onChanged: (value) {
                         cubit.changeSelectedOption(value!);
                         Get.off(PayIpanQrView(
                           delNote2: widget.delNote2,
                           delNote1: widget.delNote1,
                           deliveryTime: cubit.selectedOption,
                           deliverfee: cubit.distancePrice,
                           order: widget.order,
                           lat: widget.lat,
                           lng: widget.lng,
                           phone: widget.phone,
                           floor: widget.floor,
                           name: widget.name,
                           total: widget.total,
                           home: widget.home,
                           song: widget.song,
                           email: widget.email,
                           msg: widget.msg,
                           recName: widget.recName,
                           sender: widget.sender,
                           notes: widget.notes,
                           address: widget.address,
                         ));
                         // setState(() {
                         //   selectedOption = value;
                         // });
                       },
                     ) : const SizedBox(),

                     (widget.place != 'Gift For Someone') ?
                     RadioListTile(
                       activeColor: ColorsManager.ColorHelper,
                       title: Text('payOnline'.tr),
                       value: 'payOnlineFromStore',
                       groupValue: cubit.selectedOption,
                       onChanged: (value) {
                         cubit.changeSelectedOption(value!);
                         Get.off(PayIpanQrView(
                           deliveryTime: 'onStore',
                           delNote2: widget.delNote2,
                           delNote1: widget.delNote1,
                           deliverfee: cubit.distancePrice,
                           order: widget.order,
                           lat: widget.lat,
                           lng: widget.lng,
                           phone: widget.phone,
                           floor: widget.floor,
                           name: widget.name,
                           total: widget.total,
                           home: widget.home,
                           song: widget.song,
                           email: widget.email,
                           msg: widget.msg,
                           recName: widget.recName,
                           sender: widget.sender,
                           notes: widget.notes,
                           address: widget.address,
                         ));
                       },
                     ) : const SizedBox(),


                     const SizedBox(height: 14,),

                     OrderWidget(order: widget.order, total: widget.total)
                   ],
                 ),
               );
             }

         ));
   }

   Widget OrderWidget(
       {required List <CartProductModel> order, required String total}) {
     return SizedBox(
       height: 21300,
       child: ListView.builder(
           physics: const NeverScrollableScrollPhysics(),
           itemCount: order.length,
           itemBuilder: (context, index) {
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 decoration: BoxDecoration(
                     border: Border.all(color: ColorsManager.ColorHelper),
                     borderRadius: BorderRadius.circular(11)
                 ),
                 child: Row(
                   children: [
                     const SizedBox(height: 11,),
                     Column(
                       children: [
                         const SizedBox(height: 10,),
                         SizedBox(
                             height: 120,
                             width: 170,
                             child: Image.network(order[index].image
                                 .toString(),
                               fit: BoxFit.fill,
                             )),
                         const SizedBox(height: 10),
                         SizedBox(
                           width: 170,
                           child: Wrap(
                               children: [
                                 Center(
                                   child: Text(
                                       order[index].name.toString(),
                                       maxLines: 2,
                                       style: GoogleFonts.tajawal(
                                         color: ColorsManager.TextColor1,
                                         fontSize: 20,
                                         fontWeight: FontWeight.bold,
                                         textBaseline: TextBaseline.alphabetic,
                                       )
                                   ),
                                 ),
                               ]
                           ),
                         ),
                         const SizedBox(height: 10,),
                       ],
                     ),
                     const SizedBox(height: 12,),
                     const SizedBox(width: 11,),
                     Column(
                       children: [
                         Custom_Text(text: 'price'.tr, fontSize: 18),
                         Custom_Text(text: order[index].price.toString(),
                             alignment: Alignment.center,
                             fontWeight: FontWeight.w400,
                             fontSize: 22),
                       ],
                     ),
                     const SizedBox(width: 30,),
                     Custom_Text(text: " X ${order[index].quantity}",
                         alignment: Alignment.center,
                         fontSize: 16),
                   ],
                 ),
               ),
             );
           }),
     );
   }

   String generateRandomString(int length) {
     return randomAlphaNumeric(length);
   }

   List<Map<String, dynamic>>tokenList = [];
   List<String>tokenDataList = [];

   Future<void> fetchTokens() async {

     try {
       QuerySnapshot querySnapshot =
       await FirebaseFirestore.instance.
       collection('tokens').get();
       try{
         List<Map<String, dynamic>> data
         = querySnapshot.docs.map
           ((DocumentSnapshot doc) =>
         doc.data() as Map<String, dynamic>)
             .toList();
            tokenList= data;
            for(int i=0;i<tokenList.length;i++){
              tokenDataList.add(tokenList[i]['token']);
            }


       }catch(e){
         print("E.......");
         print(e);
         print("E.......");
       }
     }
     catch (error) {
       print("Error fetching data: $error");
     }
   }



   sendNotificationToSellerNow
       ({required List token}) async

   {
     print("//////////////");
     print(token.length);
     print("TOKENS====" + token.toString());
     var responseNotification;


     Map<String, String> headerNotification =
     {
       'Content-Type': 'application/json',
       'Authorization': 'key=AAAA9FC6uTg:APA91bFHuy099izllJTsoGAN0na0lqhX8tZAawWLnViTGy9VFYVp-W-k_EsnUUD8sm_wz1ntB2fWHlt76ovuFmnpIYN90AYMGuItVh0AhS_pdP_5tDNeSjtAX1uiDMpR9SKMdNiR1fw0'
     };

     Map bodyNotification =
     {
       "body": " طلب جديد علي متجرك  ",
       "title": " عرض الطلب الان   "
     };

     Map dataMap =
     {
       "click_action": "FLUTTER_NOTIFICATION_CLICK",
       "id": "1",
       "status": "done",
       //   "rideRequestId": docId
     };

     for (int i = 0; i < token.length; i++) {
       print('sss');

       Map officialNotificationFormat =
       {
         "notification": bodyNotification,
         "data": dataMap,
         "priority": "high",
         "to": token[i],
       };

       try {
         print('try send notification');
         responseNotification = http.post(
           Uri.parse("https://fcm.googleapis.com/fcm/send"),
           headers: headerNotification,
           body: jsonEncode(officialNotificationFormat),
         ).then((value) {
           print('NOTIFICATION SENT ==' + value.toString());
         });
       }
       catch (e) {
         print("NOTIFICATION ERROR===" + e.toString());
       }
       //return   responseNotification;
     }
   }
}
