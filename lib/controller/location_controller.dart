import 'dart:io';

import 'package:geolocator/geolocator.dart';

class LocationController {

  Future<Position> getLocationData() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      LocationPermission reqResult = await Geolocator.requestPermission();
      if (reqResult == LocationPermission.denied) {
        exit(0);
      }
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
