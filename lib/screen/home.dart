import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_assistant/Service/auth.dart';
import 'package:parking_assistant/Widgets/mapsWidget.dart';
import 'package:parking_assistant/model/infowindow.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
BitmapDescriptor mapMarker;
class _HomeState extends State<Home> {
var geolocator = Geolocator();
Position currentposition;

  final AuthService _auth = AuthService();
  String verifed = "";
  void initState() {
    dynamic x = _auth.verifyEmail();
    verifed = x.toString();

  }

  Widget reload() {
    if (verifed != "") {
      return RaisedButton(
        onPressed: () {
          setState(() {
            verifed = _auth.verifyEmail();
          });
          print(verifed);
        },
        child: Text("click here to reload"),
      );
    } else
      return Text("good");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[60],
        drawer: Drawer(),
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          title: Text("Parker"),
          actions: [
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Logout"),
            )
          ],
        ),
        body: ChangeNotifierProvider(
          create: (context)=>InfoWindowModel(context),
            child: Maps()),);
  }








}
