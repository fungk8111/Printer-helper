import 'dart:developer';

import 'package:flutter/services.dart';

class Zq320ConnectPrinter {
  final methodChannel = const MethodChannel('printer_helper_v2');

  Future<bool> connectBluetooth(
    String macAddress,
  ) async {
    try {
      Map<String, dynamic> params = {
        "macAddress": macAddress,
      };
      var res = await methodChannel.invokeMethod('zq320-miV2connectBT', params);
      print(res);
      // return res;
      return true;
    } catch (e) {
      log("zq320-miV2connectBT : Error $e");
      return false;
    }
  }

// Disconnect
  Future<void> disconnect() async {
    try {
      await methodChannel.invokeMethod('zq320-disconnect');
    } catch (e) {
      log("zq320-disconnect: Error $e");
    }
  }

  Future<void> image(
    Uint8List imgSr,
  ) async {
    try {
      Map<String, dynamic> arguments = <String, dynamic>{};
      arguments.putIfAbsent("bitmap", () => imgSr);
      var ii = await methodChannel.invokeMethod('zq320-printImage', arguments);
      print(ii);
    } catch (e) {
      log("zq320-printImage : Error $e");
    }
  }
}
