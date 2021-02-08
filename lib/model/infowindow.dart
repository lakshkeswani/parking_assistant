import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_assistant/model/parkingLocation.dart';

class InfoWindowModel extends ChangeNotifier {
  bool _showInfoWindow = false;
  bool _tempHidden = false;
  ParkingLocation _parkingLocation;
  double _leftMargin;
  double _topMargin;

  InfoWindowModel(BuildContext context, {bool listen});

  void rebuildInfowindow() {
    notifyListeners();
  }

  void updateParkingLocations(ParkingLocation parkingLocation) {
    _parkingLocation = parkingLocation;
  }

  updatevisibility(bool visibility) {
    _showInfoWindow = visibility;
  }

  updateInfoWindow(
    BuildContext context,
    GoogleMapController controller,
    LatLng location,
    double infoWindowWidth,
    double markerOffset,
  ) async {
    ScreenCoordinate screenCoordinate =
        await controller.getScreenCoordinate(location);
    double devicePixelRatio =
        Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
    double left = (screenCoordinate.x.toDouble() / devicePixelRatio) -
        (infoWindowWidth / 2);
    double top =
        (screenCoordinate.y.toDouble() / devicePixelRatio) - markerOffset;
    if (left < 0 || top < 0) {
      _tempHidden = true;
    } else {
      _tempHidden = false;
      _leftMargin = left;
      _topMargin = top;
    }
  }
  bool get showInfoWindow => ( _showInfoWindow ==true && _tempHidden ==false) ? true : false;

  double get leftMargin  => _leftMargin;
  double get topMargin => _topMargin;
  ParkingLocation get parkinglocation => _parkingLocation;

}
