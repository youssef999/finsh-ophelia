
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/data/services/data_base.dart';
import 'package:shop_app/domain/models/cart_model.dart';
import 'package:shop_app/domain/models/product_model.dart';
import 'package:shop_app/presentation/bloc/location/location_states.dart';
import 'package:shop_app/presentation/const/app_message.dart';






class LocationCubit extends Cubit<LocationStates> {

  LocationCubit() :super(AppIntialState());

  static LocationCubit get(context) => BlocProvider.of(context);

  TextEditingController addressController=TextEditingController();
  TextEditingController homeController=TextEditingController();
  TextEditingController floorController=TextEditingController();
  TextEditingController phoneController=TextEditingController();

  TextEditingController nearController=TextEditingController();

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController recNameController=TextEditingController();
  TextEditingController msgController=TextEditingController();
  TextEditingController senderController=TextEditingController();
  TextEditingController songController=TextEditingController();
  TextEditingController notesController=TextEditingController();

  TextEditingController hisNameController=TextEditingController();
  TextEditingController hisPhoneController=TextEditingController();


  TextEditingController deliveyNote1Controller=TextEditingController();
  TextEditingController deliveryNote2Controller=TextEditingController();


  String selectedOption = 'from1To3'.tr;

  handleRadioValueChange(String value) {

      selectedOption = value;
      emit(ChangeOrderTimeState());


  }

}













