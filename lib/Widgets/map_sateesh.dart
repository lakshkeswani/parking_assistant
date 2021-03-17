import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_assistant/model/parkingLocation.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  BitmapDescriptor mapMarker;
  Position locadresss;
  String adress;
  String data;
  final double _infoWindowWidth = 250;
  final double _markerOffset = 170;
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
    LatLng x = LatLng(currentposition.latitude, currentposition.longitude);
    return x;
  }

  void initState() {
    setCustomMarker();
    _determinePosition();
  }

  Set<Marker> _markers = {};

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(1, 1)), "images/car1.png");
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
        child: GoogleMap(
          onTap: (position) {
            print(position.latitude + position.longitude);
          },
          onCameraMove: (position) {},
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target: LatLng(24.810029018425254, 67.03093547181592),
            zoom: 100,
          ),
        ),
      ),
    );
  }
}
