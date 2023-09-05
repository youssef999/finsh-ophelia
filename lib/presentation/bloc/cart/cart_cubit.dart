

import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/data/services/data_base.dart';
import 'package:shop_app/domain/models/cart_model.dart';
import 'package:shop_app/domain/models/product_model.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_states.dart';
import 'dart:math' as math;


class CartCubit extends Cubit<CartStates> {

  CartCubit() :super(AppIntialState());

  static CartCubit get(context) => BlocProvider.of(context);
  String selectedOption='';
  String selectedOption2='';
  String selectedOption3='';


  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  List<CartProductModel> _cartProductModel = [];
  List<CartProductModel> get cartProductModel => _cartProductModel;
  double get totalPrice => _totalPrice;
  double _totalPrice = 0.0;
  num total = 0.0;
  int quant2 = 1;
  var dbHelper = CartDatabaseHelper.db;
  ProductModel ? model;
  bool isFav=false;
  bool isFav2=false;
  num quant=1;
  List data=[];
  final ScrollController scrollController = ScrollController();
  int currentIndex = 0;
  List image=[];
 String image2='';
  int index=0;

  bool load=false;
  bool checkLocation=false;
  double distancePrice=0.0;

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    _getCurrentLocation();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print("DENIED");
      //  permission = await Geolocator.requestPermission();
        // Handle the case when the user has denied location permission
        return;
      }
    }
    else{
      permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();
      _getCurrentLocation();
    }
  }


  Future<void> _getCurrentLocation() async {
    print("get location");
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
  }







void getLocationDistance(double lat,double lng) async {

    print("==========================Location Distance...............");
    //Position position = await Geolocator.getCurrentPosition();
    LatLng userLocation =  LatLng(lat,lng);
    LatLng storeLocation = const LatLng(30.1111,31.4139);
    //LatLng(position.latitude, position.longitude);

    print(userLocation);

    // 3. Calculate distances and filter nearby products
    const Distance distance = Distance();

    const double radius = 50000; // 20 km
    double calculatedDistance = distance.distance(userLocation, storeLocation).toDouble();

    if (calculatedDistance <= radius) {

      if (calculatedDistance <= 10000) {
       distancePrice=13;
      }
      else if (calculatedDistance > 10000&& calculatedDistance<=13000) {
        distancePrice=23;
      }
      else if (calculatedDistance > 13000&& calculatedDistance<=18000) {
        distancePrice=25;
      }
      else if (calculatedDistance > 18000&& calculatedDistance<=22000) {
        distancePrice=28;
      }
      else if (calculatedDistance > 25000&& calculatedDistance<=32000) {
        distancePrice=38;
      }
      else if (calculatedDistance > 32000&& calculatedDistance<=38000) {
        distancePrice=41;
      }
      else if (calculatedDistance > 38000&& calculatedDistance<=50000) {
        distancePrice=89;
      }


     print("Done");
     checkLocation=true;
     emit(CashOnDeliverySuccessState());
    }

    else{
      print("NOOXXXXX");
      checkLocation=false;
      emit(CashOnDeliveryErrorState());
    }
  }

  changeSelectedOption(String val){

    selectedOption=val;
    emit(ChangeSelectedOptionState());
  }

  getImageData(DocumentSnapshot posts){
    image=posts['image'];
    image2=image[index];
    emit(GetImageSuccessState());
  }
   buildImageWidget(DocumentSnapshot posts){
     index++;
     emit(NextImageSuccessState());
     getImageData(posts);
  }

  returnImage(DocumentSnapshot posts){
    index--;
    emit(NextImageSuccessState());
    getImageData(posts);
  }


  void scrollToIndex(int index) {
    scrollController.animateTo(
      index * 100.0, // Adjust the value based on the item width
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    emit(AnimateImageSuccessState());
  }

  CartViewModel() {
    getAllProduct();
    getTotalPrice();
  }

  increaseQuant(int num)async{
    if(quant<num){
      quant++;
      emit(IncreaseQuantitySuccessState());
    }else{
      appMessage(text: 'لا يمكن الزيادة عن هذا العدد لهذا المنتج ');
    }
  }

  decreaseQuant()async{
    if(quant>1){
      quant--;
      emit( DecreaseQuantitySuccessState());
    }
  }

  getAllProduct() async {
    emit(GetAllProductsLoadingState());
    _loading.value = true;
    try{
      _cartProductModel = await dbHelper.getAllProduct();
      print('CART LEGNTH =${_cartProductModel.length}');
      _loading.value = false;
      getTotalPrice();
      emit(GetAllProductsSuccessState());

    }
    catch(e){
      print(e);
      emit(GetAllProductsErrorState('$e'));
    }


  }


  addProduct(CartProductModel cartProductModel, String productId) async {

    //
    // if (_cartProductModel.length == 10) {
    //   appMessage(text: 'لا يمكن اضافة اكثر من 10 منتجات في كل طلب');
    // }
    // else {

      emit(AddProductProductLoadingState());
      var dbHelper = CartDatabaseHelper.db;
      await dbHelper.insert(cartProductModel);
      appMessage(text: 'productAdded'.tr);
      _cartProductModel.add(cartProductModel);
      _totalPrice +=
      (double.parse(cartProductModel.price!) * cartProductModel.quantity!);
      emit(AddProductProductSuccessState());
      getAllProduct();
//    }


  }


  dialogAndAdd ({required CartProductModel cartProductModel, required String productId}) {

    Get.defaultDialog(
      title: "AreYouSure".tr,
      middleText: "",
      onConfirm: () {
        addProduct (cartProductModel, productId);
        Get.back();
      },
      onCancel: () {
      },
      textCancel: "no".tr,
      textConfirm: "yes".tr,
      cancelTextColor: Colors.black,
      buttonColor: ColorsManager.ColorHelper2,
      confirmTextColor: Colors.white,
      barrierDismissible: true,
      //middleText: "Hello world!",
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(color: Colors.black),
      middleTextStyle: const TextStyle(color: Colors.white),
    );
  }

  dialogAndDelete(CartProductModel cartProductModel, String productId) {
    Get.defaultDialog(
      title: "AreYouSureToDelete".tr,
      middleText: "",
      onConfirm: () {
        DeleteAll(cartProductModel);
        addProduct(cartProductModel, productId);
        print("");
        Get.back();
        // Get.off(ControlView());
      },

      onCancel: () {

      },
      textCancel: "no".tr,
      textConfirm: "yes".tr,
      cancelTextColor: Colors.deepOrange,
      buttonColor: Colors.red,
      confirmTextColor: Colors.white,
      barrierDismissible: true,
      //middleText: "Hello world!",
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(color: Colors.green),
      middleTextStyle: const TextStyle(color: Colors.white),
    );
  }

  DeleteProducts (CartProductModel cartProductModel, String productId) async {
    try{
      emit(DeleteAllLoadingState());
      var dbHelper = CartDatabaseHelper.db;
      await dbHelper.Delete(cartProductModel);
      _totalPrice = 0;
      emit(DeleteAllSuccessState());
      getAllProduct();
    }catch(e){
      emit(DeleteAllErrorState(e.toString()));
    }

  }

  DeleteAll(CartProductModel cartProductModel) async {
    var dbHelper = CartDatabaseHelper.db;
    try{
      emit(DeleteAllLoadingState());
      await dbHelper.DeleteAll(cartProductModel);
      final box = GetStorage();
      box.remove('brand');
      print("delete Done");
      emit(DeleteAllSuccessState());
    }catch(e){
      emit(DeleteAllErrorState('$e'));
    }

  }


  getTotalPrice() {
    _totalPrice = 0.0;
    for (int i = 0; i < _cartProductModel.length; i++) {
      _totalPrice = _totalPrice +
          (double.parse(_cartProductModel[i].price!) *
              _cartProductModel[i].quantity!);
      print('t=$_totalPrice');
      emit(GetTotalPriceSuccessState());
    }
  }

  increaseQuantity(int index,num quant) async {
    if (_cartProductModel[index].quantity ! < quant) {
      _cartProductModel[index].quantity = _cartProductModel[index].quantity! + 1;
      _totalPrice += (double.parse(_cartProductModel[index].price!));
      dbHelper.updateProduct(_cartProductModel[index]);
      emit(IncreaseQuantitySuccessState());
      getTotalPrice();
    } else {
      appMessage(text: 'Cant add more');
    }
  }

  decreaseQuantity(int index) async {
    if (_cartProductModel[index].quantity! > 1) {
      _cartProductModel[index].quantity = _cartProductModel[index].quantity! - 1;
      _totalPrice -= (double.parse(_cartProductModel[index].price!));
      dbHelper.updateProduct(_cartProductModel[index]);
      emit(DecreaseQuantitySuccessState());
      getTotalPrice();
    } else {
      print("very small num");
    }
  }



  void changeLoad(){
    Future.delayed(const Duration(seconds: 4)).then((value) {
      load=true;
    });
    emit(ChangeLoadSuccessState());
  }
  Future <List<DocumentSnapshot>> fetchDataFromFirestore() async {

    emit(GetDataFireBaseLoadingState());
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('fav').get();
      List<DocumentSnapshot> documents = querySnapshot.docs;

      for(int i=0;i<documents.length;i++){
        data.add(documents[i]['productid']);
      }


      print(data);
      emit(GetDataFireBaseSuccessState());
      return documents;

    } catch (e) {
      // Handle any errors that occur during the data retrieval process
      print('Error retrieving data from Firestore: $e');
      emit(GetDataFireBaseErrorState());
      return [];

    }
  }

//   addToFav({required DocumentSnapshot posts }) async {
//
// final box=GetStorage();
// String email=box.read('email')??"x";
// String country=box.read('country')??"x";
//
//     emit(AddToFireBaseLoadingState());
//     await FirebaseFirestore.instance.collection('fav').add({
//       'user_email': email,
//       'country': country,
//       'name':posts['name'],
//       'image':posts['image'],
//       'productid':posts['productid'],
//       'des':posts['des'],
//       'price':posts['price'],
//       'rate':posts['rate'],
//     }).then((value) {
//       isFav=true;
//       isFav2=false;
//       appMessage(text: 'تم الاضافة الي المفضلة ');
//       emit(AddToFireBaseSuccessState());
//     });
//   }
//
//   DeleteFromFav({required DocumentSnapshot posts})async{
//     emit(DeleteFromFavLoadingState());
//     final CollectionReference _updates =
//     FirebaseFirestore.instance.collection('fav');
//     await _updates
//         .where('productid', isEqualTo: posts['productid'])
//         .get().then((snapshot) {
//       snapshot.docs.last.reference.delete().then((value) {
//         print("Deleted");
//
//         isFav=false;
//         isFav2=true;
//
//         emit(DeleteFromFavSuccessState());
//       });
//     });
//   }

}













