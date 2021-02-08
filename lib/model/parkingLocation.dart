import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingLocation{
  final String locationName;
  final String  areaname;
  final String image;
  final LatLng location;
  final int rating;

ParkingLocation(

    this.locationName,
    this.areaname,
    this.location,
    this.image,
    this.rating

);

}