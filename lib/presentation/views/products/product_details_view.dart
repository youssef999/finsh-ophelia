
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/domain/models/cart_model.dart';
import 'package:shop_app/presentation/bloc/cart/cart_cubit.dart';
import 'package:shop_app/presentation/bloc/cart/cart_states.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';
import 'package:shop_app/presentation/views/cart/cart_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';



class ProductDetailsView extends StatefulWidget {

  DocumentSnapshot posts;
  String tag;
   ProductDetailsView({Key? key,required this.posts,required this.tag}) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  List data=[];
  bool loadx=false;
  // double left=0;
  // double right=20;
  @override
  initState(){

    // final box=GetStorage();
    // String keylocal=box.read('locale')??'';
    // String des='des';
    // if(keylocal=='en'){
    //   des='des';
    // }else if(keylocal=='ar'){
    //   des='desAr';
    //   left=20;
    //   right=0;
    // }
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        loadx=true;
      });

    });
  }

  @override
  Widget build(BuildContext context) {

  //  double left=0;
   // double right=20;
    final box=GetStorage();
    String keylocal=box.read('locale')??'';
    String des='des';
    if(keylocal=='en'){
      des='des';
    }else if(keylocal=='ar'){
      des='desAr';
      //left=20;
      //right=0;
    }

    return  BlocProvider(
        create: (BuildContext context) => CartCubit()..fetchDataFromFirestore()..changeLoad(),
        child: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {

        },
    builder: (context, state) {

    CartCubit cubit = CartCubit.get(context);
    return Scaffold(
      backgroundColor:Colors.grey[100],
     bottomNavigationBar:  Container(
       height: 55,
       color:ColorsManager.ColorHelper,
       padding: const EdgeInsets.all(16.0),
       child: InkWell(
         child:  Custom_Text(text: 'addToCart'.tr,color:ColorsManager.primary,
         alignment:Alignment.center,fontSize: 24,
         ),
         onTap:(){
           cubit.dialogAndAdd(
             cartProductModel:CartProductModel(
               name: widget.posts['name'],
               image: widget.posts['image'],
               price: widget.posts['price'].toString(),
               quantity: cubit.quant,
               productQuant: widget.posts['quant'],
               productId: widget.posts['productid'],
               color: '',
               size:'',
             ),
             productId:widget.posts['productid'],
           );
         },
       )

     ),
      body:SingleChildScrollView(
        child: Column(
          children:  [
          Stack(
            children: [
              Stack(
                children: [
                  SizedBox(
                   height:
                   MediaQuery.of(context).size.height,
                    child:Hero(
                      tag: widget.tag,
                      child: Image.network(widget.posts['image'],
                      fit:BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:18.0,top:47,right: 18),
                    child: InkWell(child: const Icon(Icons.arrow_back_ios,size: 39,color:ColorsManager.primary),
                      onTap:(){
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),

              (des=='des')?
              Positioned(
                  right:20,
                  bottom: 90,
                  child: Column(
                children: [
                 IconButton(onPressed: (){
                   Get.to( CartView(
                     appBar: true,
                   ));
                 }, icon: const Icon(Icons.shopping_cart_checkout_rounded,size: 41,
                 color:ColorsManager.primary,
                 )),
                  const SizedBox(height: 6,),
                  IconButton(onPressed: (){
                    share();
                  }, icon: const Icon(Icons.share,size: 41,
                    color:ColorsManager.primary,
                  )),

                ],
              )):Positioned(
                  left:20,
                  bottom: 90,
                  child: Column(
                    children: [
                      IconButton(onPressed: (){
                        Get.to( CartView(
                          appBar: true,
                        ));
                      }, icon: const Icon(Icons.shopping_cart_checkout_rounded,size: 41,
                        color:ColorsManager.primary,
                      )),
                      const SizedBox(height: 6,),
                      IconButton(onPressed: (){
                        share();
                      }, icon: const Icon(Icons.share,size: 41,
                        color:ColorsManager.primary,
                      )),

                    ],
                  )),
              Positioned(
                bottom: 21,
                child: Padding(
                  padding: const EdgeInsets.only(left:18.0,right: 22),
                  child: Container(
                    width: 270,
                    decoration:BoxDecoration(
                      border:Border.all(color:ColorsManager.primary),
                      borderRadius:BorderRadius.circular(11),
                      color:Colors.white
                    ),
                    child:     Column(
                      children: [
                        const SizedBox(height: 10,),
                        Custom_Text(text: widget.posts['name'],fontSize: 32,
                          color:ColorsManager.TextColor1,
                          alignment: Alignment.center,
                        ),
                        const SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Custom_Text(text:
                          widget.posts[des],fontSize:13,alignment:Alignment.center,
                            color:ColorsManager.TextColor1,
                          ),
                        ),
                       const SizedBox(height: 5,),
                        const Padding(
                          padding: EdgeInsets.only(left:25.0,right: 25),
                          child: Divider(
                            endIndent:0.8,
                            thickness: 0.7,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            const SizedBox(width: 14,),
                            Custom_Text(text:" ${widget.posts['price']}"+" " +"currency".tr ,
                              color:ColorsManager.ColorHelper,
                              fontSize:20,alignment:Alignment.center,),

                            const SizedBox(width:20,),

                            Row(
                              children: [
                                InkWell(
                                  child: const CircleAvatar
                                    (
                                      backgroundColor: ColorsManager.red,
                                      child: Center(child: Icon(Icons.minimize_sharp
                                        ,size: 22,color:ColorsManager.white,))),
                                  onTap:(){
                                    cubit.decreaseQuant();
                                  },
                                ),
                                const SizedBox(width:20,),
                                Custom_Text(text:cubit.quant.toString(),
                                  color:ColorsManager.TextColor1,
                                  fontSize:22,alignment:Alignment.center,),
                                const SizedBox(width:20,),
                                InkWell(
                                  child: const CircleAvatar
                                    (
                                      backgroundColor: Colors.green,
                                      child: Center(child: Icon(Icons.add,
                                        size: 22,color:ColorsManager.white,))),

                                  onTap:(){
                                    cubit.increaseQuant(widget.posts['quant']);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 20,)
                      ],
                    ),
                  ),
                ),
              ),

              (loadx==false)?
              Positioned(
                left: 200,
                top:333,
                child: Container(
                  height: 100,
                  width: 90,
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
              ):const SizedBox()
            ],
          ),




          ],
        ),
      ),
    );
    }));
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: StringManger.AppName,
        text: 'Try Now',
        linkUrl: 'https://play.google.com/store/apps/details?id=com.flowers23.market',
        chooserTitle: '');
  }
}








