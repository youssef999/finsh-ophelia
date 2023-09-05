import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapController extends GetxController {


  String placeNamex='';


  LatLng currentLatLng = const LatLng(27.9654198,
      34.3617769); // Initial latitude and longitude (Cairo Airport: 30.1112, 31.4139)
  double zoom = 13.0;
  double latx=27.9654198;
  double lngx=34.3617769;


  GoogleMapController? mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    update();
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    getCurrentLocation();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        print("DENIED");
        //  permission = await Geolocator.requestPermission();
        // Handle the case when the user has denied location permission
        return;
      }
      getCurrentLocation();
    }
    else{
      permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();
      getCurrentLocation();
    }
  }

  Future<Map<String, dynamic>> getLatLng(String placeName) async {
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

        latx=lat;
      lngx=lng;

        placeNamex=placeName;
        update();
        updateCameraPosition(latx,lngx);
        return {'lat': lat, 'lng': lng};
      }
    }
    return {'lat': 0.0, 'lng': 0.0};
    //return null;
  }

  void onCameraMove(CameraPosition position) {
    print("move");
    currentLatLng = position.target;
    latx=currentLatLng.latitude;
    lngx=currentLatLng.longitude;
    update();
  }

  // changeLocationOnMap(double lat,double lng){
  //   print("CHANGESSSSSSSSSSS........................");
  //   //   currentLatLng = position.target;
  //   //     latx=currentLatLng.latitude;
  //   //     lngx=currentLatLng.longitude;
  //   currentLatLng = LatLng(lat,
  //     lng);
  //
  //
  //   // Initial latitude and longitude (Cairo Airport: 30.1112, 31.4139)
  //   // double zoom = 13.0;
  //   // double latx=0.0;
  //   // double lngx=0.0;
  //
  //
  //   update();
  // }


  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latx = position.latitude;

    lngx = position.longitude;

    print('Latitude: $latx, Longitude: $lngx');
    updateCameraPosition(latx,lngx);

  }





  void updateCameraPosition(double lat, double lng) {
    print("UPDATE");
    print(lat);
    print(lng);
    print("UPDATE");

    currentLatLng = LatLng(lat, lng);
    zoom = 13.0; // You can set a different zoom level if needed
    latx=currentLatLng.latitude;
    lngx=currentLatLng.longitude;
    mapController
        ?.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, zoom));

    update();
  }
}
