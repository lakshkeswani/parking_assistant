// To parse this JSON data, do
//
//     final parkingLocations = parkingLocationsFromJson(jsonString);

import 'dart:convert';

List<ParkingLocations> parkingLocationsFromJson(String str) =>
    List<ParkingLocations>.from(
        json.decode(str).map((x) => ParkingLocations.fromJson(x)));

String parkingLocationsToJson(List<ParkingLocations> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParkingLocations {
  ParkingLocations({
    this.id,
    this.price,
    this.totalSlots,
    this.longitude,
    this.latitude,
    this.address,
    this.city,
  });

  int id;
  int price;
  int totalSlots;
  int longitude;
  double latitude;
  String address;
  String city;

  factory ParkingLocations.fromJson(Map<String, dynamic> json) =>
      ParkingLocations(
        id: json["id"],
        price: json["price"],
        totalSlots: json["totalSlots"],
        longitude: json["longitude"],
        latitude: json["latitude"].toDouble(),
        address: json["address"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "totalSlots": totalSlots,
        "longitude": longitude,
        "latitude": latitude,
        "address": address,
        "city": city,
      };
}
