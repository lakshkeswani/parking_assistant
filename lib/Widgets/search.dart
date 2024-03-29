import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_assistant/Widgets/progressdailog.dart';
import 'package:parking_assistant/controllers/appdata.dart';
import 'package:parking_assistant/controllers/direction%20controller.dart';
import 'package:parking_assistant/model/address.dart';
import 'package:parking_assistant/Widgets/divider.dart';
import 'package:parking_assistant/model/placepredictions.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

String APIKEY = "AIzaSyCFfiw05_LDHtbJoGPA3AkrEy7YxET6VIg";

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PlacePredictions> placePredictionsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: 215,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding:
                EdgeInsets.only(left: 25, top: 20, right: 25, bottom: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.0,
                    ),
                    Stack(
                      children: [
                        GestureDetector(
                          child: Icon(Icons.arrow_back),
                          onTap: () async {
                            Navigator.pop(context);
                          },
                        ),
                        Center(
                          child: Text(
                            "Set Drop off",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "images/marker.png",
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(
                          width: 18.0,
                        ),
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Pick Up",
                                    fillColor: Colors.grey[400],
                                    filled: true,
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.only(
                                      left: 11,
                                      top: 8,
                                      bottom: 8,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                        ),
                        SizedBox(
                          width: 18.0,
                        ),
                        Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: TextField(
                                  onChanged: (value) {
                                if (value != null) {
                                  findplace(value);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: " Where To",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                  left: 11,
                                  top: 8,
                                  bottom: 8,
                                ),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              )),
          //tile for displying places
          (placePredictionsList != null) ? Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListView.separated(
              padding: EdgeInsets.all(0.0),
              itemBuilder: (context, index) {
                return PredictionTile(
                  placepredictions: placePredictionsList[index],);
              },
              separatorBuilder: (BuildContext, int index) => DeviderWidget(),
              itemCount: placePredictionsList.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
            ),
          ) : Container(),
        ],
      ),
    );
  }

  void findplace(String placename) async {
    if (placename.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placename&key=$APIKEY&sessiontoken=1234567890&components=country:pk";
      var url = Uri.parse(autoCompleteUrl);
      var respose = await http.get(url);
      var dresponse = jsonDecode(respose.body);
      print(dresponse);
      if (respose == "failed") {
        return;
      } else {
        if (dresponse["status"] == "OK") {
          var pridictions = dresponse["predictions"];
          var placelist = (pridictions as List)
              .map((e) => PlacePredictions.fromJson(e))
              .toList();
          setState(() {
            placePredictionsList = placelist;
          });
        }
        ;
      }
    }
  }
}

class PredictionTile extends StatefulWidget {
  const PredictionTile({Key key, this.placepredictions}) : super(key: key);
  final PlacePredictions placepredictions;

  @override
  _PredictionTileState createState() => _PredictionTileState();
}

class _PredictionTileState extends State<PredictionTile> {
  DirectionController directionController = Get.find(tag: "directiondetails");

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        print("id by laksh " + widget.placepredictions.place_id);

        await getPlaceAddress(widget.placepredictions.place_id, context);
      },
      leading: Icon(Icons.add_location),
      title: Text(
        widget.placepredictions.main_text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16.0),
      ),
      subtitle: Text(
        widget.placepredictions.secondary_text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 12.0, color: Colors.grey),
      ),
    );
  }

  void getPlaceAddress(String Placeid, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgresDailog(
              message: "Drop off",
            ));
    String placedetailURL =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$Placeid&key=$APIKEY";
    var url = Uri.parse(placedetailURL);
    var response = await http.get(url);
    Navigator.pop(context);
    var dresponse = jsonDecode(response.body);
    Address address;
    if (response == "failed") {
      return;
    }
    if (dresponse["status"] == "OK") {
      address = Address.fromJson(dresponse);
      print("lat of address" + address.latitude.toString());
      Provider.of<AppData>(context, listen: false).updatedropoff(address);
      print("place name Laksh    " + Placeid.toString());

      Navigator.pop(context, "gotdirection");
    }
    print("place name Laksh    " + Placeid.toString());
  }
}
// Column(
// children: [
// SizedBox(width: 10.0,),
// Row(
// children: [Icon(Icons.add_location),SizedBox(width: 14.0,),
// Expanded(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(placepredictions.main_text,overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 16.0), ),
// SizedBox(height: 3.0,),
// ],
// ),
// ),
// ],
// ),
// SizedBox(width: 10.0,),
// ],
// ),
