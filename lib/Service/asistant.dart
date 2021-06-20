import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_assistant/model/direction.dart';

class AsistantMethods {
  static Future<DirectionDetials> asistantDirectionApi(
      LatLng intialposition, LatLng finalpostion) async {
    double originlat = intialposition.latitude;
    String APIKEY = "AIzaSyCFfiw05_LDHtbJoGPA3AkrEy7YxET6VIg";
    double originlng = intialposition.longitude;
    double finallat = finalpostion.latitude;
    double finallng = finalpostion.longitude;

    String directionurl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$originlat,$originlng&destination=$finallat,$finallng&key=$APIKEY";
    var directionuri = Uri.parse(directionurl);
    var response = await http.get(directionuri);
    var dresponse = jsonDecode(response.body);
    DirectionDetials directionDetials = DirectionDetials();
    if (dresponse["status"] == "OK") {
      directionDetials.encodedPionts =
          dresponse["routes"][0]["overview_polyline"]["points"];

      directionDetials.distanceText =
          dresponse["routes"][0]["legs"][0]["distance"]["text"];
      directionDetials.distanceValue =
          dresponse["routes"][0]["legs"][0]["distance"]["value"];

      directionDetials.durationText =
          dresponse["routes"][0]["legs"][0]["duration"]["text"];
      directionDetials.distanceValue =
          dresponse["routes"][0]["legs"][0]["duration"]["value"];
      return directionDetials;
    }
  }
}
