import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/checkout/checkout_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:shop_app/presentation/widgets/custom_textformfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/cart_model.dart';
import '../../bloc/location/location_cubit.dart';
import '../../bloc/location/location_states.dart';

class LocationFormView extends StatelessWidget {

  List<CartProductModel> order;
  String total;
  String place;
  double lat,lng;

  LocationFormView({Key? key, required this.order,required this.place,required this.lat,required this.lng, required this.total})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(".....................");
    print(place);
    print(lat);
    print(lng);
    print(".....................");
    return BlocProvider(
        create: (BuildContext context) => LocationCubit(),
        child: BlocConsumer<LocationCubit, LocationStates>(
            listener: (context, state) {},
            builder: (context, state) {
              LocationCubit cubit = LocationCubit.get(context);

              if(place=='Gift For Someone'){
                return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 50,
                    leading: InkWell(
                      child: const Icon(Icons.arrow_back_ios,
                          size: 27, color: Colors.white),
                      onTap: () {
                        place='';
                        Get.back();
                      },
                    ),
                    backgroundColor: ColorsManager.ColorHelper,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 4,
                        ),

                        const SizedBox(height: 20,),
                         Custom_Text(text: 'info'.tr,fontSize: 26,alignment:Alignment.center,color:ColorsManager.black,
                          fontWeight:FontWeight.w800,
                        ),
                        const SizedBox(height: 11,),
                        CustomTextFormField(
                            hint: 'yourName'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.nameController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'mobile'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.phone,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.phoneController),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // CustomTextFormField(
                        //     hint: 'email'.tr,
                        //     obx: false,
                        //     ontap: () {},
                        //     type: TextInputType.emailAddress,
                        //     obs: false,
                        //     color: ColorsManager.TextColor1,
                        //     controller:
                        //     cubit.emailController),
                        const SizedBox(
                          height: 7,
                        ),


                         Custom_Text(text: 'consign'.tr
                          ,alignment:Alignment.center,
                          fontSize: 28,color:ColorsManager.TextColor1,fontWeight:FontWeight.w800,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'hisName'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.hisNameController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'hisPhone'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.number,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.hisPhoneController),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Custom_Text(text: 'deliverTo'.tr,alignment:Alignment.center,
                          fontSize: 28,color:ColorsManager.TextColor1,fontWeight:FontWeight.w800,
                        ),
                        const SizedBox(height: 11,),
                        Custom_Text(text:'deliverNote'.tr,
                        color:Colors.grey,
                        fontSize: 16,alignment:Alignment.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'address'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.addressController),
                        const SizedBox(
                          height: 10,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Custom_Text(text: 'deliverTime'.tr,alignment:Alignment.center,
                          fontSize: 28,color:ColorsManager.TextColor1,fontWeight:FontWeight.w800,
                        ),
                        const SizedBox(
                          height: 20,
                        ),


                        RadioListTile<String>(
                          title:
                          Text('from1To3'.tr,
                          style:const TextStyle(
                            color:Colors.black,
                            fontSize: 21
                          ),
                          ),
                          value: 'from1To3'.tr,
                          groupValue: cubit.selectedOption,
                          onChanged: (val){
                            cubit.handleRadioValueChange(val!);
                          },
                        ),
                        const SizedBox(height: 11,),
                        CustomTextFormField(hint: 'deliveryTimeNote1'.tr,
                            obx: false, ontap: (){},max: 4
                            , type: TextInputType.text, obs: false
                            , color: Colors.black, controller: cubit.deliveyNote1Controller),

                        const SizedBox(height: 15,),
                        RadioListTile<String>(
                          title: Text('thisDay'.tr,
                              style:const TextStyle(
                              color:Colors.black,
                              fontSize: 21
                          ),
                        ),
                          value: 'thisDay'.tr,
                          groupValue: cubit.selectedOption,
                      onChanged: (val){
                  cubit.handleRadioValueChange(val!);
                  },
                        ),

                        const SizedBox(height: 11,),
                        CustomTextFormField(hint: 'deliveryTimeNote2'.tr,
                            obx: false, ontap: (){}
                            , type: TextInputType.text, obs: false
                            , color: Colors.black, controller: cubit.deliveryNote2Controller),

                        //const SizedBox(height: 15,),
                        const SizedBox(height: 21,),

                        Custom_Text(text: 'giftCard'.tr,alignment:Alignment.center,
                          fontSize: 28,color:ColorsManager.TextColor1,fontWeight:FontWeight.w800,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'recName'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.recNameController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'msg'.tr,
                            obx: false,
                            max: 7,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.msgController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'senderName'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.senderController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'songLink'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.songController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'notes'.tr,
                            max: 4,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.notesController),
                        const SizedBox(
                          height: 20,
                        ),


                        CustomButton(
                            text: 'next'.tr,
                            onPressed: () {

                              if(cubit.nameController.text.isNotEmpty&&cubit.phoneController.text.isNotEmpty
                                  &&
                                 cubit.addressController.text.isNotEmpty){
                                Get.to(CheckOutView(
                                  delNote1:cubit.deliveyNote1Controller.text,
                                  delNote2:cubit.deliveryNote2Controller.text,
                                  deliveryTime: cubit.selectedOption,
                                  place: place,
                                  total: total,
                                  order: order,
                                  home: cubit.homeController.text,
                                  floor: cubit.floorController.text,
                                  phone: cubit.phoneController.text,
                                  address: cubit.addressController.text,
                                  msg: cubit.msgController.text,
                                  notes: cubit.notesController.text,
                                  name: cubit.nameController.text,
                                  email: cubit.emailController.text,
                                  recName: cubit.recNameController.text,
                                  sender: cubit.senderController.text,
                                  song: cubit.senderController.text,
                                  lat: lat,
                                  lng: lng,

                                ));
                              }else{
                                appMessage(text: 'yourInfoReq'.tr);
                              }

                            },
                            color1: ColorsManager.ColorHelper,
                            color2: ColorsManager.primary2),
                     const SizedBox(height: 7,),
                         Custom_Text(
                          fontSize: 15,color:ColorsManager.black,
                            text: 'theAddressWillBe'.tr),

                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                );
              }
              if(place=='On Store'){
                return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 50,
                    leading: InkWell(
                      child: const Icon(Icons.arrow_back_ios,
                          size: 27, color: Colors.white),
                      onTap: () {
                        place='';
                        Get.back();
                      },
                    ),
                    backgroundColor: ColorsManager.ColorHelper,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 4,
                        ),

                        const SizedBox(height: 20,),
                        Custom_Text(text: 'info'.tr,fontSize: 26,alignment:Alignment.center,color:ColorsManager.black,
                          fontWeight:FontWeight.w800,
                        ),
                        const SizedBox(height: 11,),
                        CustomTextFormField(
                            hint: 'yourName'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.nameController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'mobile'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.phone,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.phoneController),
                        const SizedBox(
                          height: 20,
                        ),
                        // CustomTextFormField(
                        //     hint: 'email'.tr,
                        //     obx: false,
                        //     ontap: () {},
                        //     type: TextInputType.emailAddress,
                        //     obs: false,
                        //     color: ColorsManager.TextColor1,
                        //     controller: cubit.emailController),
                        // const SizedBox(
                        //   height: 7,
                        // ),
                     // Custom_Text(text:
                     //    'enterSameEmail'.tr,
                     //      color: Colors.grey,fontSize: 15,
                     //    ),
                     //    const SizedBox(
                     //      height: 20,
                     //    ),

                      Custom_Text(text: 'giftCard'.tr,alignment:Alignment.center,
                          fontSize: 28,color:ColorsManager.TextColor1,fontWeight:FontWeight.w800,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'recName'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.recNameController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'msg'.tr,
                            obx: false,
                            max: 7,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.msgController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'senderName'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.senderController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'songLink'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.songController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'notes'.tr,
                            max: 4,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.notesController),
                        const SizedBox(
                          height: 20,
                        ),


                        CustomButton(
                            text: 'next'.tr,
                            onPressed: () {
                              if(cubit.nameController.text.isNotEmpty&&cubit.phoneController.text.isNotEmpty){
                                Get.to(CheckOutView(
                                  delNote2: cubit.deliveryNote2Controller.text,
                                  delNote1: cubit.deliveyNote1Controller.text,
                                  deliveryTime: 'onStore',
                                  total: total,
                                  order: order,
                                  place: place,
                                  home: cubit.homeController.text,
                                  floor: cubit.floorController.text,
                                  phone: cubit.phoneController.text,
                                  address: cubit.addressController.text,
                                  msg: cubit.msgController.text,
                                  notes: cubit.notesController.text,
                                  name: cubit.nameController.text,
                                  email: cubit.emailController.text,
                                  recName: cubit.recNameController.text,
                                  sender: cubit.senderController.text,
                                  song: cubit.senderController.text,
                                  lat: lat,
                                  lng: lng,
                                ));
                              }else{
                                appMessage(text: 'yourInfoReq'.tr);
                              }
                            },
                            color1: ColorsManager.ColorHelper,
                            color2: ColorsManager.primary2),

                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                );
              }else{
                return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 50,
                    leading: InkWell(
                      child: const Icon(Icons.arrow_back_ios,
                          size: 27, color: Colors.white),
                      onTap: () {
                        place='';
                        Get.back();
                      },
                    ),
                    backgroundColor: ColorsManager.ColorHelper,
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 4,
                        ),

                        const SizedBox(height: 20,),
                       Custom_Text(text: 'info'.tr,fontSize: 26,alignment:Alignment.center,color:ColorsManager.black,
                          fontWeight:FontWeight.w800,
                        ),
                        const SizedBox(height: 11,),
                        CustomTextFormField(
                            hint: 'yourName'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.nameController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'mobile'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.phone,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.phoneController),
                        const SizedBox(
                          height: 20,
                        ),
                        // CustomTextFormField(
                        //     hint: 'email'.tr,
                        //     obx: false,
                        //     ontap: () {},
                        //     type: TextInputType.emailAddress,
                        //     obs: false,
                        //     color: ColorsManager.TextColor1,
                        //     controller: cubit.emailController),
                        // const SizedBox(
                        //   height: 7,
                        // ),
                        //  Custom_Text(text:
                        // 'enterSameEmail'.tr,
                        //   color: Colors.grey,fontSize: 15,
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),

                         Custom_Text(text: 'deliverTo'.tr,alignment:Alignment.center,
                          fontSize: 28,color:ColorsManager.TextColor1,fontWeight:FontWeight.w800,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'address'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.addressController),
                        const SizedBox(
                          height: 20,
                        ),


                        RadioListTile<String>(
                          title:
                          Text('from1To3'.tr,
                            style:const TextStyle(
                                color:Colors.black,
                                fontSize: 21
                            ),
                          ),
                          value: 'from1To3'.tr,
                          groupValue: cubit.selectedOption,
                          onChanged: (val){
                            cubit.handleRadioValueChange(val!);
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('thisDay'.tr,
                            style:const TextStyle(
                                color:Colors.black,
                                fontSize: 21
                            ),
                          ),
                          value: 'thisDay'.tr,
                          groupValue: cubit.selectedOption,
                          onChanged: (val){
                            cubit.handleRadioValueChange(val!);
                          },
                        ),


                        const SizedBox(height: 21,),
                       Custom_Text(text: 'giftCard'.tr,alignment:Alignment.center,
                          fontSize: 28,color:ColorsManager.TextColor1,fontWeight:FontWeight.w800,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'recName'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.recNameController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'msg'.tr,
                            obx: false,
                            max: 7,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.msgController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'senderName'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.senderController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'songLink'.tr,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.songController),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            hint: 'notes'.tr,
                            max: 4,
                            obx: false,
                            ontap: () {},
                            type: TextInputType.text,
                            obs: false,
                            color: ColorsManager.TextColor1,
                            controller: cubit.notesController),
                        const SizedBox(
                          height: 20,
                        ),


                        CustomButton(
                            text: 'next'.tr,
                            onPressed: () {
                              if(cubit.nameController.text.isNotEmpty

                                  &&cubit.phoneController.text.isNotEmpty&&

                                  cubit.addressController.text.isNotEmpty){
                                Get.to(CheckOutView(
                                  deliveryTime: cubit.selectedOption,
                                  place:place,
                                  delNote2: cubit.deliveryNote2Controller.text,
                                  delNote1: cubit.deliveyNote1Controller.text,
                                  total: total,
                                  order: order,
                                  home: cubit.homeController.text,
                                  floor: cubit.floorController.text,
                                  phone: cubit.phoneController.text,
                                  address: cubit.addressController.text,
                                  msg: cubit.msgController.text,
                                  notes: cubit.notesController.text,
                                  name: cubit.nameController.text,
                                  email: cubit.emailController.text,
                                  recName: cubit.recNameController.text,
                                  sender: cubit.senderController.text,
                                  song: cubit.senderController.text,
                                  lat: lat,
                                  lng: lng,
                                ));
                              }else{
                                appMessage(text: 'yourInfoReq'.tr);
                              }

                            },
                            color1: ColorsManager.ColorHelper,
                            color2: ColorsManager.primary2),

                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                );
              }

            }));
  }
}
