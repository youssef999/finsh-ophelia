// import 'dart:collection';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shop_app/domain/models/cart_model.dart';
// import 'package:shop_app/domain/models/pred.dart';
// import 'package:shop_app/presentation/views/location/location_form_view.dart';
// import '../../bloc/location/location_cubit.dart';
// import '../../bloc/location/location_states.dart';
// import '../../const/app_message.dart';
// import '../../controller/map_controller.dart';
// import '../../resources/color_manager.dart';
// import '../../widgets/Custom_Text.dart';
// import '../../widgets/Custom_button.dart';
// import 'package:http/http.dart' as http;
//
//  class MapLocationView extends StatefulWidget {
//
//
//  List <CartProductModel> order;
//  String total;
//   //
//    MapLocationView({required this.order,required this.total});
//   @override
//   _Map1State createState() => _Map1State();
// }
//
// TextEditingController searchController=TextEditingController();
// String placeNamex='';
//
// class _Map1State extends State<MapLocationView> {
//
//    var locationMessage = "";
//   var position;
//   // var l1 = 37.43296265331129;
//   // var l2 = -122.08832357078792;
//   String? country='';
//   String? city='';
//   String? address='';
//   GoogleMapController ? newGooGleMapController;
//   LatLng ?latLng;
//   CameraPosition ?cameraPosition;
//   double lat=0.0;
//   double lng=0.0;
//    List<PredictedPlaces> placesPredictedList = [];
//
//    String mapKey='AIzaSyBPjjojes8Rt9APAFPn3mGcFzHHdKAhyHc';
//
//    void findPlaceAutoCompleteSearch(String inputText) async
//    {
//      if(inputText.length > 1) //2 or more than 2 input characters
//          {
//        String urlAutoCompleteSearch = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapKey&components=country:EG";
//
//        var responseAutoCompleteSearch = await receiveRequest(urlAutoCompleteSearch);
//
//        if(responseAutoCompleteSearch == "Error Occurred, Failed. No Response.")
//        {
//          return;
//        }
//
//        if(responseAutoCompleteSearch["status"] == "OK")
//        {
//          var placePredictions = responseAutoCompleteSearch["predictions"];
//
//          var placePredictionsList = (placePredictions as List).map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();
//
//          setState(() {
//            placesPredictedList = placePredictionsList;
//          });
//        }
//      }
//    }
//
//
//    static Future<dynamic> receiveRequest(String url) async
//    {
//      http.Response httpResponse = await http.get(Uri.parse(url));
//
//      try
//      {
//        if(httpResponse.statusCode == 200) //successful
//            {
//          String responseData = httpResponse.body; //json
//
//          var decodeResponseData = jsonDecode(responseData);
//
//          return decodeResponseData;
//        }
//        else
//        {
//          return "Error Occurred, Failed. No Response.";
//        }
//      }
//      catch(exp)
//      {
//        return "Error Occurred, Failed. No Response.";
//      }
//    }
//   //CameraPosition initCameraPosition() => CameraPosition(target: LatLng(widget.l1,widget.l2), zoom: 6);
//
//    final controller=Get.put(MapController());
//    @override
//    void initState() {
//      controller.getCurrentLocation();
//      // TODO: implement initState
//      super.initState();
//
//    }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//      var markers = HashSet<Marker>();
//
//     return BlocProvider(
//         create: (BuildContext context) => LocationCubit(),
//         child: BlocConsumer<LocationCubit, LocationStates>(
//             listener: (context, state) async {
//
//             },
//             builder: (context, state) {
//               LocationCubit authCubit = LocationCubit.get(context);
//               return Scaffold(
//                 appBar: AppBar(
//                   toolbarHeight: 1,
//                   backgroundColor: ColorsManager.primary,
//                   automaticallyImplyLeading: false,
//                 ),
//                 body: ListView(
//                   children: [
//                     const SizedBox(
//                       height: 12,
//                     ),
//                     Container(
//                       height: 180,
//                       decoration: const BoxDecoration(
//                         color: ColorsManager.purple2,
//                         boxShadow:
//                         [
//                           BoxShadow(
//                             color: Colors.white54,
//                             blurRadius: 8,
//                             spreadRadius: 0.5,
//                             offset: Offset(
//                               0.7,
//                               0.7,
//                             ),
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Column(
//                           children: [
//
//                             const SizedBox(height: 22.0),
//
//                             // Stack(
//                             //   children: [
//                             //
//                             //     GestureDetector(
//                             //       onTap: ()
//                             //       {
//                             //         Navigator.pop(context);
//                             //       },
//                             //       child: const Icon(
//                             //         Icons.arrow_back_ios,
//                             //         color: Colors.white,
//                             //       ),
//                             //     ),
//                             //
//                             //   ],
//                             // ),
//
//                             const SizedBox(height: 6.0),
//
//                             Row(
//                               children: [
//
//                                 const Icon(
//                                   Icons.adjust_sharp,
//                                   color: Colors.grey,
//                                 ),
//
//                                 const SizedBox(width: 18.0,),
//
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: TextField(
//                                       controller: searchController,
//                                       onChanged: (valueTyped)
//                                       {
//                                         findPlaceAutoCompleteSearch(valueTyped);
//                                       },
//                                       decoration: const InputDecoration(
//                                         hintText: "ابحث هنا ... ",
//                                         fillColor: Colors.white54,
//                                         filled: true,
//                                         border: InputBorder.none,
//                                         contentPadding: EdgeInsets.only(
//                                           left: 11.0,
//                                           top: 8.0,
//                                           bottom: 8.0,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//
//                               ],
//                             ),
//                             const SizedBox(height: 11,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 GetBuilder<MapController>(
//                                     builder: (context) {
//                                       return Column(
//                                         children: [
//                                           Custom_Text(text: 'latitude = ${controller.latx}'),
//                                           const SizedBox(height: 5,),
//                                           Custom_Text(text: 'longitude = ${controller.lngx}'),
//                                         ],
//                                       );
//                                     }
//                                 )
//                               ],)
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 310,
//                       child: GetBuilder<MapController>(
//                           builder: (cont) {
//                             return GoogleMap(
//                               myLocationEnabled: true,
//                               onCameraMove: controller.onCameraMove,
//                               initialCameraPosition: CameraPosition(
//                                 target: controller.currentLatLng,
//                                 //  zoom: controller.zoom,
//                               ),
//                               onMapCreated: controller.onMapCreated,
//                               mapType: MapType.normal,
//
//                               // myLocationEnabled: true;
//                               // _controllerGoogleMap.complete(controller);
//                               // newGoogleMapController = controller;
//                               // //black theme google map
//                               // //blackThemeGoogleMap(newGoogleMapController);
//                               //
//                               // locateDriverPosition();,
//
//                             );
//                           }
//                       ),
//                     ),
//                     // SizedBox(
//                     //   height: 560,
//                     //   child: GoogleMap(
//                     //     initialCameraPosition: CameraPosition(
//                     //         target: LatLng(lat, lng),
//                     //         zoom: 19.151926040649414),
//                     //     onMapCreated: (
//                     //         GoogleMapController googleMapController) {
//                     //       setState(() {
//                     //         markers.add(Marker(
//                     //             markerId: const MarkerId('1'),
//                     //             visible: true,
//                     //             draggable: true,
//                     //             position: LatLng(lat,lng),
//                     //             infoWindow:
//                     //             const InfoWindow(title: 'Shop', snippet: 'ssss'),
//                     //             onTap: () {
//                     //               print("marker");
//                     //             },
//                     //             onDragEnd: (LatLng) {
//                     //               print(LatLng);
//                     //             }));
//                     //       });
//                     //     },
//                     //     markers: markers,
//                     //   ),
//                     // ),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                    // display place predictions result
//                     (placesPredictedList.isNotEmpty)
//                         ? Expanded(
//                       child: ListView.separated(
//                         itemCount: placesPredictedList.length,
//                         physics: const ClampingScrollPhysics(),
//                         itemBuilder: (context, index)
//                         {
//                           return PlacePredictionTileDesign(
//                             predictedPlaces: placesPredictedList[index],
//                           );
//                         },
//                         separatorBuilder: (BuildContext context, int index)
//                         {
//                           return const Divider(
//                             height: 1,
//                             color: Colors.black,
//                             thickness: 1,
//                           );
//                         },
//                       ),
//                     )
//                         : Container(),
//
//
//                     // layers: [
//                     //   TileLayerOptions(
//                     //     urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                     //     subdomains: ['a', 'b', 'c'],
//                     //   ),
//                     //   MarkerLayerOptions(
//                     //     markers: [
//                     //       Marker(
//                     //         width: 40.0,
//                     //         height: 40.0,
//                     //         point: LatLng(latitude, longitude), // Use the same latitude and longitude for the marker
//                     //         builder: (ctx) => Container(
//                     //           child: Icon(Icons.location_on, color: Colors.red),
//                     //         ),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ],
//
//                     CustomButton(text: 'تاكيد', onPressed: () {
//
//                       Get.to( LocationFormView(
//                         total: widget.total,
//                         order: widget.order,
//                       ));
//                     }, color1: ColorsManager.ColorHelper, color2: Colors.white),
//
//                     CustomButton(text: ' تخطي ', onPressed: () {
//
//                       final box = GetStorage();
//
//                       box.write('l1', 0.0);
//
//                       box.write('l2',0.0);
//
//                       Get.to( LocationFormView(
//                         total: widget.total,
//                         order: widget.order,
//                       ));
//
//                     }, color1: ColorsManager.ColorHelper2, color2: Colors.white),
//                     const SizedBox(
//                       height: 25,
//                     ),
//
//                   ],
//                 ),
//               );
//             }));
//
//   }
//
//
//   void currentLocation() async {
//     position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     latLng = LatLng(position.latitude, position.longitude);
//     cameraPosition = CameraPosition(target: latLng!, zoom: 14);
//     var lastposition = await Geolocator.getLastKnownPosition();
//  lat = position.latitude;
//  lng = position.longitude;
//     print(lastposition);
//     print("lll=$locationMessage");
//     print(
//       "ooo=${position.latitude}",
//     );
//     print(
//       "yyy=${position.longitude}",
//     );
//     setState(() {
//       locationMessage = "$position";
//      lat = position.latitude;
//      lng = position.longitude;
//     });
//     print("LAT===$lat");
//     print("LAT===$lng");
//   }
//
//   Future<void> getData() async {
//     bool serviceEnabled=await Geolocator.isLocationServiceEnabled();
//     if(!serviceEnabled){
//       appMessage(text: 'Location service disapled');
//     }
//     LocationPermission permission=await Geolocator.checkPermission();
//     if(permission==LocationPermission.denied){
//       permission=await Geolocator.requestPermission();
//     }
//
//
//     print("HERE");
//     Future.delayed(const Duration(seconds: 4)).then((value) async {
//       try {
//         // emit(GetLocationLoadingState());
//         Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best,
//         );
//
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//           position.latitude,
//           position.longitude,
//         );
//         Placemark placemark = placemarks.first;
//         // print(placemark);
//         // print(position.longitude);
//         setState(() {
//         lat = position.latitude;
//         lng = position.longitude;
//           // emit(GetLocationSuccessState());
//           country = placemark.country!;
//           city = placemark.locality!;
//         });
//         // print(position.latitude);
//
//
//         address = placemark.street.toString();
//      //   locatate = true;
//         appMessage(text: 'تم تحديد موقعك بنجاح');
//        // emit(GetLocationSuccessState());
//       } catch (e) {
//         print(e);
//         appMessage(text: '$e');
//       }
//     });
//
//   }
// }
//
// Future<Map<String, dynamic>> getLatLng(String placeName) async {
//   final controller=Get.put(MapController());
//   String apiKey = 'AIzaSyBCRjQbAjjWsve_mxS2qcO2moflRSffGoo';
//   //'AIzaSyDVhdP11IiB8X_BtG0NgFTkezTc98sEZ1M';
//   String encodedPlaceName = Uri.encodeQueryComponent(placeName);
//   String url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedPlaceName&key=$apiKey';
//
//   final response = await http.get(Uri.parse(url));
//
//   if (response.statusCode == 200) {
//     final decodedResponse = json.decode(response.body);
//     final results = decodedResponse['results'];
//
//     if (results.isNotEmpty) {
//       final location = results[0]['geometry']['location'];
//       final lat = location['lat'];
//       final lng = location['lng'];
//
//       print(lat);
//       print(lng);
//       controller.latx=lat;
//       controller.lngx=lng;
//       placeNamex=placeName;
//       return {'lat': lat, 'lng': lng};
//     }
//   }
//   return {'lat': 0.0, 'lng': 0.0};
//   //return null;
// }
//
//
// class PlacePredictionTileDesign extends StatelessWidget
// {
//   final PredictedPlaces? predictedPlaces;
//
//   PlacePredictionTileDesign({this.predictedPlaces});
//
//   @override
//   Widget build(BuildContext context)
//   {
//     final controller=Get.put(MapController());
//     return ElevatedButton(
//       onPressed: ()
//       async {
//         searchController.text= predictedPlaces!.main_text!;
//         print('sss');
//
//         await getLatLng(predictedPlaces!.main_text!);
//         controller.updateCameraPosition(controller.latx,controller.lngx);
//
//       },
//       style: ElevatedButton.styleFrom(
//         primary: ColorsManager.primary,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: Row(
//           children: [
//             const Icon(
//               Icons.add_location,
//               color: ColorsManager.purple2,
//             ),
//             const SizedBox(width: 14.0,),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 8.0,),
//                   Text(
//                     predictedPlaces!.main_text!,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 16.0,
//                       color: ColorsManager.black,
//                     ),
//                   ),
//                   const SizedBox(height: 2.0,),
//                   Text(
//                     predictedPlaces!.secondary_text!,
//                     overflow: TextOverflow.ellipsis,
//                     style:  const TextStyle(
//                       fontSize: 12.0,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(height: 8.0,),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_app/domain/models/cart_model.dart';
import 'package:shop_app/domain/models/pred.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/presentation/controller/map_controller.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import '../../resources/color_manager.dart';
import 'location_form_view.dart';


class SearchPlacesScreen extends StatefulWidget
{

    List <CartProductModel> order;
    String total;


    SearchPlacesScreen({required this.order, required this.total});

  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}



TextEditingController searchController=TextEditingController();


class _SearchPlacesScreenState extends State<SearchPlacesScreen>
{
  List<PredictedPlaces> placesPredictedList = [];

  String mapKey='AIzaSyCT5ti5wz4HUsPW38wSzMI0_snJFQmqdag';
      //'AIzaSyBPjjojes8Rt9APAFPn3mGcFzHHdKAhyHc';


// @override
//   void dispose() {
//   searchController.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: ColorsManager.primary,
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
          text: 'Next',
          onPressed: (){
            Get.to(LocationFormView(
              total:
              widget.total,
              order: widget.order,
              place: controller.placeNamex,
              lat: controller.latx,
              lng: controller.lngx,
            ));
          },
          color1:ColorsManager.purple2,
          color2: ColorsManager.primary,
        ),
      ),
      body: Column(
        children: [
          //search place ui
          Container(
            height: 160,
            decoration: const BoxDecoration(
              color: ColorsManager.purple2,
              boxShadow:
              [
                BoxShadow(
                  color: Colors.white54,
                  blurRadius: 8,
                  spreadRadius: 0.5,
                  offset: Offset(
                    0.7,
                    0.7,
                  ),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [

                  const SizedBox(height: 25.0),

                  Stack(
                    children: [

                      GestureDetector(
                        onTap: ()
                        {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),

                      const Center(
                        child: Text(
                          "Search Location ",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: ColorsManager.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0),

                  Row(
                    children: [

                      const Icon(
                        Icons.adjust_sharp,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 18.0,),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchController,
                            onChanged: (valueTyped)
                            {
                              findPlaceAutoCompleteSearch(valueTyped);
                            },
                            decoration: const InputDecoration(
                              hintText: "Search Here .. ",
                              fillColor: Colors.white54,
                              filled: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 11.0,
                                top: 8.0,
                                bottom: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 260,
            child: GetBuilder<MapController>(
                builder: (cont) {
                  return GoogleMap(
                    myLocationEnabled: true,
                    onCameraMove: controller.onCameraMove,
                    initialCameraPosition: CameraPosition(
                      target: controller.currentLatLng,
                      //  zoom: controller.zoom,
                    ),
                    onMapCreated: controller.onMapCreated,
                    mapType: MapType.normal,
                  );
                }
            ),
          ),
          //display place predictions result
          (placesPredictedList.isNotEmpty)
              ? Expanded(
            child: ListView.separated(
              itemCount: placesPredictedList.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index)
              {
                return PlacePredictionTileDesign(
                  predictedPlaces: placesPredictedList[index],
                );
              },
              separatorBuilder: (BuildContext context, int index)
              {
                return const Divider(
                  height: 1,
                  color: Colors.black,
                  thickness: 1,
                );
              },
            ),
          )
              : Container(),
        ],
      ),
    );
  }


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


}



class PlacePredictionTileDesign extends StatelessWidget
{
  final controller=Get.put(MapController());
  final PredictedPlaces? predictedPlaces;

  PlacePredictionTileDesign({this.predictedPlaces});

  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
      onPressed: ()
      {
        searchController.text= predictedPlaces!.main_text!;
        print('sss');

       controller.getLatLng(predictedPlaces!.main_text!);
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