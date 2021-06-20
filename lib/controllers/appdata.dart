import 'package:flutter/cupertino.dart';
import 'package:parking_assistant/model/address.dart';
import 'package:provider/provider.dart';

class AppData extends ChangeNotifier {
  Address dropoff, pickup;

  void updatepickup(Address Pickup) {
    pickup = Pickup;
    print("pick up lat" + pickup.latitude.toString());

    notifyListeners();
  }

  void updatedropoff(Address Dropoff) {
    dropoff = Dropoff;
    print(dropoff.latitude);
    notifyListeners();
  }
}
