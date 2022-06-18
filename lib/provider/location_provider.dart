import 'package:flutter/cupertino.dart';
import 'package:restroapp/models/address.dart';

class LocationProvider extends ChangeNotifier {
  Address? currentAddress;
  void updateCurrentAddress(Address current) {
    currentAddress = current;
    notifyListeners();
  }
}
