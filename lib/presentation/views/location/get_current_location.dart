
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/domain/models/cart_model.dart';
import 'package:shop_app/domain/models/pred.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';

import '../../controller/map_controller.dart';
import 'location_form_view.dart';


class SearchPlacesScreen2 extends StatefulWidget
{

  List <CartProductModel> order;
  String total;

  SearchPlacesScreen2({required this.order, required this.total});

  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}



TextEditingController searchController=TextEditingController();
String placeNamex='';


class _SearchPlacesScreenState extends State<SearchPlacesScreen2>
{
  List<PredictedPlaces> placesPredictedList = [];

  String mapKey='AIzaSyCT5ti5wz4HUsPW38wSzMI0_snJFQmqdag';
      //'AIzaSyBPjjojes8Rt9APAFPn3mGcFzHHdKAhyHc';

  void findPlaceAutoCompleteSearch(String inputText) async
  {
    if(inputText.length > 1) //2 or more than 2 input characters
        {
      String urlAutoCompleteSearch = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapKey&components=country:EG";

      var responseAutoCompleteSearch = await receiveRequest(urlAutoCompleteSearch);

      if(responseAutoCompleteSearch == "Error Occurred, Failed. No Response.")
      {
        return;
      }

      if(responseAutoCompleteSearch["status"] == "OK")
      {
        var placePredictions = responseAutoCompleteSearch["predictions"];

        var placePredictionsList = (placePredictions as List).map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();

        setState(() {
          placesPredictedList = placePredictionsList;
        });
      }
    }
  }


  static Future<dynamic> receiveRequest(String url) async
  {
    http.Response httpResponse = await http.get(Uri.parse(url));

    try
    {
      if(httpResponse.statusCode == 200) //successful
          {
        String responseData = httpResponse.body; //json

        var decodeResponseData = jsonDecode(responseData);

        return decodeResponseData;
      }
      else
      {
        return "Error Occurred, Failed. No Response.";
      }
    }
    catch(exp)
    {
      return "Error Occurred, Failed. No Response.";
    }
  }




  final controller=Get.put(MapController());

  bool loadx=false;


  @override
  void initState() {

    controller.checkLocationPermission();
    Future.delayed(const Duration(seconds: 1)).then((value) {
      setState(() {
        loadx = true;
      });
    });
    controller.getCurrentLocation();
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context)
  {


    return Scaffold(
      backgroundColor: ColorsManager.primary,
      appBar: AppBar(
        backgroundColor: ColorsManager.ColorHelper,
        elevation: 0.4,
        toolbarHeight:55,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios,
        size: 27,color: ColorsManager.primary,
        ),
        onPressed:(){
          Get.back();
        },
        ),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
          text:'next'.tr,
          onPressed: (){

            Get.to(LocationFormView(
              total:
              widget.total,
              order: widget.order,
              place: '',
              lat: controller.latx,
              lng: controller.lngx,
            ));

          },
          color1:ColorsManager.ColorHelper,
          color2: ColorsManager.primary,
        ),
      ),
      body: SingleChildScrollView(
        child:
        Stack(
          children: [
            GetBuilder<MapController>(
                builder: (con) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height*0.80,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      onCameraMove: controller.onCameraMove,
                      initialCameraPosition: CameraPosition(
                        target: controller.currentLatLng,
                        //  zoom: controller.zoom,
                      ),
                      onMapCreated: controller.onMapCreated,
                      mapType: MapType.normal,
                    ),
                  );
                }
            ),
            (loadx==false)?
            Positioned(
              left: 160,
              top:300,
              child: Container(
                height: 90,
                width: 80,
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

      ),
    );
  }

}



Future<Map<String, dynamic>> getLatLng(String placeName) async {
  final controller=Get.put(MapController());
  String apiKey = 'AIzaSyBCRjQbAjjWsve_mxS2qcO2moflRSffGoo';
  //'AIzaSyDVhdP11IiB8X_BtG0NgFTkezTc98sEZ1M';
  String encodedPlaceName = Uri.encodeQueryComponent(placeName);
  String url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedPlaceName&key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final decodedResponse = json.decode(response.body);
    final results = decodedResponse['results'];

    if (results.isNotEmpty) {
      final location = results[0]['geometry']['location'];
      final lat = location['lat'];
      final lng = location['lng'];

      print(lat);
      print(lng);
      controller.latx=lat;
      controller.lngx=lng;
      placeNamex=placeName;
      return {'lat': lat, 'lng': lng};
    }
  }
  return {'lat': 0.0, 'lng': 0.0};
  //return null;
}


class PlacePredictionTileDesign extends StatelessWidget
{
  final PredictedPlaces? predictedPlaces;

  PlacePredictionTileDesign({this.predictedPlaces});

  @override
  Widget build(BuildContext context)
  {
    final controller=Get.put(MapController());
    return ElevatedButton(
      onPressed: ()
      async {
        searchController.text= predictedPlaces!.main_text!;
        print('sss');

        await getLatLng(predictedPlaces!.main_text!);
        controller.updateCameraPosition(controller.latx,controller.lngx);

      },
      style: ElevatedButton.styleFrom(
        primary: ColorsManager.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            const Icon(
              Icons.add_location,
              color: ColorsManager.purple2,
            ),
            const SizedBox(width: 14.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0,),
                  Text(
                    predictedPlaces!.main_text!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: ColorsManager.black,
                    ),
                  ),
                  const SizedBox(height: 2.0,),
                  Text(
                    predictedPlaces!.secondary_text!,
                    overflow: TextOverflow.ellipsis,
                    style:  const TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
