import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<LocationPermission?> hasPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      print('denied');
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        print('denied forever');
        return Future.error('Location Not Available');
      }
    } else {
      print('The permission is $permission');
    }
    return permission;
  }

  Future<Position?> getCurrentPosition() async {
    late Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      print('The current position is: $position');
    } on Exception catch (e) {
      print(e);
    }
    return position;
  }
}
