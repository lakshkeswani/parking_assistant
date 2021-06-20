// To parse this JSON data, do
//
//     final adress = adressFromJson(jsonString);

import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.placeid,
    this.placename,
    this.longitude,
    this.latitude,
  });

  String placeid;
  String placename;
  double longitude;
  double latitude;

  Address.fromJson(Map<String, dynamic> json) {
    placeid = json["result"]["place_id"];
    placename = json["result"]["name"];
    longitude = json["result"]["geometry"]["location"]["lng"].toDouble();
    latitude = json["result"]["geometry"]["location"]["lat"].toDouble();
  }

  Map<String, dynamic> toJson() => {
        "placeid": placeid,
        "placename": placename,
        "longitude": longitude,
        "latitude": latitude,
      };
}
