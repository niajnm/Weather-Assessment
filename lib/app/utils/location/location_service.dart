import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static Position? _position;

  // static Future<bool> hasLocationPermission() async {
  //   PermissionStatus permissionStatus = await Permission.location.status;
  //   return (permissionStatus.isGranted || permissionStatus.isLimited);
  // }

  // static Future<bool> getIsGpsAccessible() {
  //   return Geolocator.isLocationServiceEnabled().then((value) async {
  //     bool isLocationPermissionDenied = await _getIsLocationPermissionDenied();

  //     return !isLocationPermissionDenied && value;
  //   });
  // }

  // static Future<bool> _getIsLocationPermissionDenied() {
  //   return Geolocator.checkPermission().then((value) {
  //     return value == LocationPermission.deniedForever ||
  //         value == LocationPermission.denied ||
  //         value == LocationPermission.unableToDetermine;
  //   });
  // }

  // static Future<bool> isLocationServiceEnable() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.always ||
  //       permission == LocationPermission.whileInUse) {
  //     return true;
  //   }
  //   return false;
  // }

  // ignore: prefer-conditional-expressions
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _openAppSettings();
      return Future.error("Location Permission Disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
         _openAppSettings();
        return Future.error("Location Permission Denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error("Location Permission Denied Permanently");
      }
    }

    if (_position == null) {
      return await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.low)
          .then((value) {
        _position = value;
        return value;
      }, onError: (error) {
        if (_position == null) {
          return Future.value(_position);
        }

        return Future.error(error);
      });
    } else {
      return Future.value(_position);
    }
  }

  static Future<void> _openAppSettings() async {
    await Geolocator.checkPermission();
    AppSettings.openAppSettings(type: AppSettingsType.location);
    // Open the app settings page
  }

//..............................................................

  Future<bool> requestLocationPermission() async {
    var position = await LocationService.getCurrentLocation();
    final PermissionStatus permissionStatus = await Permission.location.status;
    if (permissionStatus.isGranted || permissionStatus.isLimited) {
      _setCurrentLocation(position.latitude, position.longitude);
      return true;
    }
    return false;
  }

  Future<bool> isLocationServiceAvailable() async {
    final PermissionStatus permissionStatus = await Permission.location.status;

    requestLocationPermission();

    if (permissionStatus.isGranted) {
      log("Location access granted");
      try {
        final Position position = await LocationService.getCurrentLocation();
        if (position != null) {
          _setCurrentLocation(position.latitude, position.longitude);
          return true;
        }
      } catch (e) {
        log("Error getting current location: $e");
      }
    } else {
      log("Location access denied");
    }

    return false;
  }

  var _currentLat;
  var _currentLon;

  _setCurrentLocation(Lat, Lon) {
    _currentLat = Lat;
    _currentLon = Lon;
  }

  get getLat => _currentLat;

  get getLon => _currentLon;
}
