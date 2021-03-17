import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_assistant/Service/auth.dart';
import 'package:parking_assistant/Widgets/divider.dart';
import 'package:parking_assistant/Widgets/mapsWidget.dart';
import 'package:parking_assistant/Widgets/search.dart';
import 'package:parking_assistant/model/infowindow.dart';
import 'package:parking_assistant/model/user.dart';
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
      drawer: Container(
        width: 266,
        color: Colors.white,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 175,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/laksh.png",
                        height: 65.0,
                        width: 65.0,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Column(
                        children: [
                          Text(
                            Provider.of<USer>(context).email,
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text("Visit Profile"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              DeviderWidget(),
              SizedBox(
                height: 12.0,
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  "History",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Profile",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Text("Parker"),
        actions: [
          // ignore: deprecated_member_use
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
          create: (context) => InfoWindowModel(context),
          child: Stack(
            children: [
              gmaps(),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(
                  height: 285.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          "hi there",
                          style: TextStyle(fontSize: 10.0),
                        ),
                        Text(
                          "Where to",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Search()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
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
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.yellowAccent,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text("Search Drop off"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 12.0),
                            Column(
                              children: [
                                Text("Add Home"),
                                SizedBox(height: 4.0),
                                Text(
                                  "Your living home address",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        DeviderWidget(),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.work,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 12.0),
                            Column(
                              children: [
                                Text("Add Work"),
                                SizedBox(height: 4.0),
                                Text(
                                  "Your Office address",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
