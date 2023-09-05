import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../resources/color_manager.dart';
import '../../widgets/Custom_button.dart';
import 'package:shop_app/presentation/bloc/cart/cart_cubit.dart';
import 'package:shop_app/presentation/bloc/cart/cart_states.dart';
import '../../../domain/models/cart_model.dart';
import '../../widgets/Custom_Text.dart';
import '../location/choose_location.dart';


class CartView extends StatefulWidget {

  bool appBar;
  CartView({Key? key,required this.appBar}) : super(key: key);
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  var locationMessage = "";
  String? country = '';
  String? city = '';
  String? address = '';
  var position;
  // var l1 = 37.43296265331129;
  // var l2 = -122.08832357078792;

  GoogleMapController ? newGooGleMapController;
  LatLng ?latLng;
  CameraPosition ?cameraPosition;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => CartCubit()..getAllProduct(),
        child: BlocConsumer<CartCubit, CartStates>(
            listener: (context, state) {},
            builder: (context, state) {
              CartCubit cubit = CartCubit.get(context);

              return Scaffold(
                appBar:
                (widget.appBar==false)?
                AppBar(
                  elevation: 0,
                  backgroundColor: ColorsManager.ColorHelper,
                  toolbarHeight: 1,
                ): AppBar(
                  elevation: 0,
                  backgroundColor: ColorsManager.ColorHelper,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                      color:ColorsManager.white,
                    size: 26,
                    ),
                    onPressed:(){
                      Get.back();
                    },
                  ),
                  toolbarHeight: 55,
                ),
                backgroundColor: Colors.grey[100],
                body: cubit.cartProductModel.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 333,
                              child: Image.asset("assets/images/ffx.png")),
                          const SizedBox(
                            height: 5,
                          ),
                          Custom_Text(
                            text: 'cartIsEmpty'.tr,
                            fontSize: 35,
                            color: ColorsManager.black,
                            alignment: Alignment.center,
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 22, right: 22, top: 25),
                                  child: Container(
                                    decoration:BoxDecoration(
                                      borderRadius:BorderRadius.circular(16),
                                      color:ColorsManager.primary,
                                        boxShadow: [
                                    BoxShadow(
                                    color: Colors.grey.withOpacity(0.5), // Shadow color
                                    spreadRadius: 5, // Spread radius
                                    blurRadius: 7, // Blur radius
                                    offset: const Offset(0, 3), // Offset position of the shadow
                                  )
                                    ]
                                    ),
                                      height: 150,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 140,
                                            child: Image.network(
                                                cubit.cartProductModel[index]
                                                    .image
                                                    .toString(),
                                                fit: BoxFit.fill),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,top: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 10,),
                                                     Padding(
                                                      padding: const EdgeInsets.only(top:10.0),
                                                      child: Custom_Text(text: 'name'.tr,fontSize: 16,
                                                      color:ColorsManager.black,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width:10,
                                                    ),

                                                    SizedBox(
                                                      width: 70,
                                                      child: Text(
                                                        cubit
                                                            .cartProductModel[index]
                                                            .name
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),

                                                    InkWell(
                                                        onTap: () {
                                                          cubit.DeleteProducts(
                                                              CartProductModel(
                                                                  productQuant: cubit
                                                                      .cartProductModel[
                                                                  index]
                                                                      .productQuant,
                                                                  name: cubit
                                                                      .cartProductModel[
                                                                  index]
                                                                      .name,
                                                                  image: cubit
                                                                      .cartProductModel[
                                                                  index]
                                                                      .image,
                                                                  price: cubit
                                                                      .cartProductModel[
                                                                  index]
                                                                      .price,
                                                                  quantity: cubit
                                                                      .cartProductModel[
                                                                  index]
                                                                      .quantity,
                                                                  productId: cubit
                                                                      .cartProductModel[
                                                                  index]
                                                                      .productId),
                                                              cubit
                                                                  .cartProductModel[
                                                              index]
                                                                  .productId!);
                                                        },
                                                        child: const Icon(Icons
                                                            .cancel,size: 27,color:Colors.red,)),
                                                  ],
                                                ),

                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 10,),
                                                     Text(
                                                      "price".tr,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          //fontWeight:
                                                         // FontWeight.w300,
                                                          color: ColorsManager
                                                              .black),
                                                    ),
                                                    const SizedBox(width: 10,),
                                                    Text(
                                                      cubit.cartProductModel[index].price.toString() +"  " +"currency".tr,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorsManager
                                                              .black),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  width: 140,
                                                  color: ColorsManager.white,
                                                  height: 40,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            cubit.increaseQuantity(
                                                                index,
                                                                cubit
                                                                    .cartProductModel[
                                                                        index]
                                                                    .productQuant!);
                                                          },
                                                          child: const CircleAvatar(
                                                            backgroundColor:Colors.green,
                                                            child: Icon(
                                                              Icons.add,
                                                              color: ColorsManager
                                                                  .primary,
                                                            ),
                                                          )),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      Custom_Text(
                                                        alignment:
                                                            Alignment.center,
                                                        text: cubit
                                                            .cartProductModel[
                                                                index]
                                                            .quantity
                                                            .toString(),
                                                        fontSize: 20,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            cubit
                                                                .decreaseQuantity(
                                                                    index);
                                                          },
                                                          child: const CircleAvatar(
                                                            backgroundColor:Colors.red,
                                                            child: Center(
                                                              child: Padding(
                                                                padding: EdgeInsets.only(bottom: 17.0),
                                                                child: Icon(
                                                                  Icons.minimize,
                                                                  color:
                                                                      ColorsManager
                                                                          .primary,
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              },
                              itemCount: cubit.cartProductModel.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 5,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              decoration:BoxDecoration(
                                borderRadius:BorderRadius.circular(14),
                                color:ColorsManager.grey1
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    Row(
                                      children: [
                                         Text(
                                          "totalPrice".tr,
                                          style: const TextStyle(
                                              fontSize: 21, color: ColorsManager.ColorHelper),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Custom_Text(
                                            text:  cubit.totalPrice.toString()+" "+ "currency".tr,
                                            color: ColorsManager.black,
                                            fontSize: 21,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: SizedBox(
                                          height: 50,
                                          width: 190,
                                          child: CustomButton(
                                            text: "next".tr,
                                            onPressed: () {

                                              Get.to(ChooseLocationView (
                                                total:  cubit.totalPrice.toString(),
                                                order: cubit.cartProductModel,
                                              ));
                                            //  Get.to();
                                            //   Get.to(SearchPlacesScreen(
                                            //      total:  cubit.totalPrice.toString(),
                                            //     order: cubit.cartProductModel,
                                            //   ));
                                              // Get.to(LocationFormView(
                                              //   total:
                                              //   cubit.totalPrice.toString(),
                                              //   order: cubit.cartProductModel,
                                              // ));


                                            },
                                            color1: ColorsManager.ColorHelper,
                                            color2: ColorsManager.primary2,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
              );
            }));
  }

}
