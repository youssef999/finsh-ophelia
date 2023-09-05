



import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:shop_app/domain/models/cart_model.dart';
import 'package:shop_app/presentation/bloc/cart/cart_cubit.dart';
import 'package:shop_app/presentation/bloc/cart/cart_states.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'order_done_view.dart';

class PayIpanQrView extends StatelessWidget {

  List <CartProductModel> order;
  String total;
  double deliverfee;
  String address,
      delNote1,delNote2,
      phone,deliveryTime, home, floor,name,email,recName,msg,sender,song,notes;
  double lat,lng;


  PayIpanQrView (

      {super.key,
        required this.delNote1,required this.delNote2,
        required this.deliveryTime ,required this.order, required this.total, required this.home,
        required this.email,required this.deliverfee,required this.name,required this.song,required this.notes,required this.msg
        ,required this.recName,required this.sender,required this.lat,required this.lng,
        required this.phone, required this.address, required this.floor});

  @override
  Widget build(BuildContext context) {
return  BlocProvider(
    create: (BuildContext context) =>
    CartCubit()..getAllProduct()..checkLocationPermission()
      ..getLocationDistance(lat,lng),
    child: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {

        },
        builder: (context, state) {

          CartCubit cubit = CartCubit.get(context);
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 55,
        leading:IconButton(

          onPressed:(){
            Get.back();
          }, icon: const Icon(Icons.arrow_back_ios, size: 32,
          color:Colors.white,),
        ),
        backgroundColor:ColorsManager.ColorHelper2,
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
                   Custom_Text(text: 'totalOrder'.tr,
                    color: ColorsManager.primary,
                  ),
                  const SizedBox(width: 10,),
                  Custom_Text(text: total.toString(),
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
                   Custom_Text(text: 'deliveryFee'.tr,
                    color: ColorsManager.primary,
                  ),
                  const SizedBox(width: 11,),
                  Custom_Text(text: deliverfee.toString(),
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
                  Custom_Text(text: 'total'.tr,
                    color: ColorsManager.primary,
                  ),
                  const SizedBox(width: 10,),
                  Custom_Text(text: ((double.parse(total))
                      +deliverfee).toString()+"   "+"currency".tr ,
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

                addOrderToFireBase('payOnline'.tr,
                    (double.parse(total)
                        +deliverfee).toString(),
                    deliverfee.toString());

                cubit.DeleteAll(order[0]);

                },
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      body:ListView(
        children:  [
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child:Image.asset('assets/images/qr.jpeg',
            fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 20,),
       Column(
            children: [
           Custom_Text(text: 'accNum'.tr,
              fontSize:24,alignment:Alignment.center,
              ),
              const SizedBox(height: 11,),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  const Custom_Text(text: '459000010006086162840',
                  fontSize: 18,alignment:Alignment.center,
                  color:ColorsManager.ColorHelper,
                  ),
                  const SizedBox(width: 10,),
                  IconButton(onPressed: (){
                    FlutterClipboard.copy
                      ('459000010006086162840')
                        .then(( value ) => print('copied'));

                  }, icon: const Icon(Icons.copy,size:25,))
                ],
              )
            ],
          ),
          const SizedBox(height: 20,),
          const Divider(thickness: 1.2,),
          const SizedBox(height: 20,),
          Column(
            children: [
              Custom_Text(text: 'iban'.tr,
                fontSize:24,alignment:Alignment.center,
              ),
              const SizedBox(height: 11,),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  const Custom_Text(text: 'SA1980000459608016162840',
                    fontSize: 18,alignment:Alignment.center,
                    color:ColorsManager.ColorHelper,
                  ),
                  const SizedBox(width: 10,),
                  IconButton(onPressed: (){
                    FlutterClipboard.copy
                      ('SA1980000459608016162840')
                        .then(( value ) => print('copied'));

                  }, icon: const Icon(Icons.copy,size:25,))
                ],
              )
            ],
          )
          
        ],
      ),
    );
        }

    ));

  }


  addOrderToFireBase
      (String payment,String subTotal,String deliveryFee) async {

    print(email);
    final box=GetStorage();
    box.write('phone', phone);

    DateTime now = DateTime.now();
    String currentDate = '${now.year}-${now.month}-${now.day}';
    String currentTime = '${now.hour}:${now.minute}:${now.second}';
    List<String>orderNames=[];
    List<String>orderQuant=[];
    List<String>orderPrice=[];
    List<String>orderImage=[];
    String orderId = generateRandomString(18);
    for(int i=0;i<order.length;i++){
      orderNames.add(order[i].name!);
    }
    for(int i=0;i<order.length;i++){
      orderImage.add(order[i].image!);
    }
    for(int i=0;i<order.length;i++){
      orderQuant.add(order[i].quantity.toString());
    }

    for(int i=0;i<order.length;i++){
      orderPrice.add(order[i].price.toString());
    }


    await FirebaseFirestore.instance.collection
      ('orders').add({
      'order_id':orderId,
      delNote2: delNote2,
      delNote1: delNote1,
      'deliveryTime':deliveryTime,
      'order': [
        for(int i=0;i<order.length;i++)
          {
            "name":orderNames[i],
            "quant":orderQuant[i],
            "price":orderPrice[i],
            "image":orderImage[i]
          }
      ],
      'payment_type':payment,
      'user_name': name,
      'user_email': email,
      'address': address,
      'phone':phone,
      'home':home,
      'floor':floor,
      'total':total,
      'subTotal':subTotal,
      'DeliveryFee':deliveryFee,
      'date':currentDate,
      'time':currentTime,
      'status':'waiting',
      'msg':msg,
      'sender':sender,
      'song':song,
      'notes':notes,
      'recName':recName,
      'currency':"currency".tr
    }).then((value) {
      appMessage(text: 'orderSent'.tr);
      Get.offAll(OrderDoneView(
        orderTime:deliveryTime,
      ));
    });
  }

  String generateRandomString(int length) {
    return randomAlphaNumeric(length);
  }
}
