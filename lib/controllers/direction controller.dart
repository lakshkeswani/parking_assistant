import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionController extends GetxController {
  var pickupLat = 0.0.obs;
  var pickupLng = 0.0.obs;
  var dropofflat = 0.0.obs;
  var dropofflng = 0.0.obs;
}
