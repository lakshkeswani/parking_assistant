import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_assistant/Service/asistant.dart';
import 'package:parking_assistant/Widgets/progressdailog.dart';
import 'package:parking_assistant/controllers/appdata.dart';
import 'package:parking_assistant/controllers/direction%20controller.dart';
import 'package:parking_assistant/model/address.dart';
import 'package:parking_assistant/model/infowindow.dart';
import 'package:parking_assistant/model/parkingLocation.dart';
import 'package:parking_assistant/model/user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class gmaps extends StatefulWidget {
  final USer CurrentUser;
  final bool update;
  final CameraUpdate cameraUpdate;
  final Set<Polyline> polylineSet;
  final LatLng pickup, dropoff;

  const gmaps({this.CurrentUser,
    this.polylineSet,
    this.cameraUpdate,
    this.update,
    this.pickup,
    this.dropoff});

  @override
  _gmapsState createState() => _gmapsState();
}

class _gmapsState extends State<gmaps> {
  final databaseReference = FirebaseDatabase.instance.reference();
  BitmapDescriptor mapMarker;
  final double _infoWindowWidth = 250;
  final double _markerOffset = 170;
  DirectionController directionController =
  Get.put(DirectionController(), tag: "directiondetails");

  final Map<String, ParkingLocation> _locationList = {
    "Dolmenmall": ParkingLocation("Dolmenmall Parking", "Dolmen Parking",
        LatLng(24.802420689237305, 67.02998783238341), "images/marker.png", 5),
    "HyperStar Parking": ParkingLocation(
        "HyperStar Parking",
        "HyperStar Parking",
        LatLng(24.810029018425254, 67.03093547181592),
        "images/marker.png",
        5)
  };

  Future<LatLng> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    Position currentposition = await Geolocator.getCurrentPosition();

    print(currentposition.latitude.toString() +
        "     " +
        currentposition.longitude.toString());
    Geofire.initialize("Available users");
    Geofire.setLocation(widget.CurrentUser.uid, currentposition.latitude,
        currentposition.longitude);
    directionController.pickupLat.value = currentposition.latitude;
    directionController.pickupLng.value = currentposition.longitude;
    Address pickup = Address(
        placeid: "2020",
        placename: "farik",
        latitude: currentposition.latitude,
        longitude: currentposition.longitude);
    print("locations" + pickup.latitude.toString());
    Provider.of<AppData>(context, listen: false).updatepickup(pickup);
    Geofire.queryAtLocation(lat, lng, radius)
    return null;
  }

  void getlocation() {
    StreamSubscription<Position> UserPositionSubscriptions;
    UserPositionSubscriptions =
        Geolocator.getPositionStream().listen((Position UserPosition) {
      Geofire.setLocation(widget.CurrentUser.uid, UserPosition.latitude,
          UserPosition.longitude);
    });
  }

  Set<Marker> _markers = {};

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 1.5), "images/car1.png");
  }

  void initState() {
    setCustomMarker();
    _determinePosition();
    //getlocation();
    // getlocation();
    // Timer.periodic(Duration(seconds: 2), (timer) {
    //   _determinePosition();
    // });
  }

  GoogleMapController mapController;

/*  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("tooba_sweet"),
        position: LatLng(24.845397764908235, 67.05403349731932),
        icon: mapMarker,
        infoWindow: InfoWindow(
          title: '"Tooba Sweet"',
          snippet: 'get a Sweet',
        ),
      ));
      _markers.add(Marker(
        markerId: MarkerId("NMC"),
        position: LatLng(24.847663714992002, 67.05555926261309),
        icon: mapMarker,
        infoWindow: InfoWindow(
          title: '" NMC"',
          snippet: 'hospital',
        ),
      ));
    });
  }
*/
  void updatefordirection() {
    mapController.animateCamera(widget.cameraUpdate);
    _markers.add(Marker(
        markerId: MarkerId("pickup"),
        position: widget.pickup,
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow)));

    _markers.add(Marker(
        markerId: MarkerId("dropoff"),
        position: widget.dropoff,
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)));
  }

  @override
  Widget build(BuildContext context) {
    setCustomMarker();
    if (widget.update == true) {
      updatefordirection();
    }
    final ProviderObject = Provider.of<InfoWindowModel>(context, listen: false);
    _locationList.forEach((key, value) {
      _markers.add(
        Marker(
            markerId: MarkerId(value.locationName),
            position: value.location,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed),
            onTap: () {
              ProviderObject.updateInfoWindow(context, mapController,
                  value.location, _infoWindowWidth, _markerOffset);
              ProviderObject.updateParkingLocations(value);
              ProviderObject.updatevisibility(true);
              ProviderObject.rebuildInfowindow();
            }),
      );
    });
    return Consumer<InfoWindowModel>(
      builder: (context, model, child) {
        return Stack(
          children: [
            child,
            Positioned(
                left: 0,
                child: Visibility(
                  visible: ProviderObject.showInfoWindow,
                  child: (ProviderObject.parkinglocation == null ||
                      !ProviderObject.showInfoWindow)
                      ? Container()
                      : Container(
                    margin: EdgeInsets.only(
                      left: ProviderObject.leftMargin,
                      top: ProviderObject.topMargin,
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 6.0,
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.green],
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter,
                            ),
                          ),
                          height: 115,
                          width: 250,
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                ProviderObject.parkinglocation.image,
                                height: 75,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ProviderObject
                                        .parkinglocation.locationName,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconTheme(
                                      data: IconThemeData(
                                        color: Colors.red,
                                        size: 18,
                                      ),
                                      child: Row(
                                        children: List.generate(
                                            5,
                                                (index) => Icon(index <
                                                ProviderObject
                                                    .parkinglocation
                                                    .rating
                                                ? Icons.star
                                                : Icons.star_border)),
                                      )),
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/SlotView');
                                    },
                                    child: Text(
                                      "Book now",
                                      style:
                                      TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.red,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Triangle.isosceles(
                          edge: Edge.BOTTOM,
                          child: Container(
                            color: Colors.green,
                            width: 20,
                            height: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        );
      },
      child: Positioned(
        child: GoogleMap(
          onTap: (position) {
            if (ProviderObject.showInfoWindow) {
              ProviderObject.updatevisibility(false);
              ProviderObject.rebuildInfowindow();
            }
          },
          onCameraMove: (position) {
            if (ProviderObject.parkinglocation != null) {
              ProviderObject.updateInfoWindow(
                  context,
                  mapController,
                  ProviderObject.parkinglocation.location,
                  _infoWindowWidth,
                  _markerOffset);
              ProviderObject.rebuildInfowindow();
            }
          },
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: _markers,
          polylines: widget.polylineSet,
          initialCameraPosition: CameraPosition(
            target: LatLng(24.810029018425254, 67.03093547181592),
            zoom: 100,
          ),
        ),
      ),
    );
  }
}
