import 'dart:developer';

import 'package:flutter/services.dart';

class SunmiV2connect {
  final methodChannel = const MethodChannel('printer_helper_v2');

// connect
  Future<bool> connect({
    required String ipConnect,
    int portConnect = 9100,
  }) async {
    try {
      Map<String, dynamic> params = {
        "ipPrinter": ipConnect,
        "portPrinter": portConnect.toString()
      };
      bool res = await methodChannel.invokeMethod(
        'sun-miV2connect',
        params,
      );
      return res;
    } catch (e) {
      log("sun-miV2connect : Error $e");
      return false;
    }
  }

  // Disconnect
  Future<void> disconnect() async {
    try {
      await methodChannel.invokeMethod('sun-miV2disconnect');
    } catch (e) {
      log("disconnectSunmiV2 : Error $e");
    }
  }

  Future<void> image(
    Uint8List imgSr,
  ) async {
    try {
      Map<String, dynamic> arguments = <String, dynamic>{};
      arguments.putIfAbsent("bitmap", () => imgSr);
      await methodChannel.invokeMethod('sun-miV2printImg', arguments);
    } catch (e) {
      log("sun-miV2printImg : Error $e");
    }
  }

  Future<void> cut() async {
    try {
      Map<String, dynamic> params = {
        "mode": 1,
      };
      await methodChannel.invokeMethod('sun-miV2cut', params);
    } catch (e) {
      log("sun-miV2cut : Error $e");
    }
  }

  void feed(
    int distance,
  ) async {
    try {
      Map<String, dynamic> params = {
        "distance": distance,
      };
      await methodChannel.invokeMethod('sun-miV2feed', params);
    } catch (e) {
      log("sun-miV2feed : Error $e");
    }
  }

  Future<bool> connectBT(
    String macAddress,
  ) async {
    try {
      // methodChannel
      Map<String, dynamic> params = {
        "macAddress": macAddress,
      };
      bool res = await methodChannel.invokeMethod('sun-miV2connectBT', params);
      return res;
    } catch (e) {
      log("sun-miV2connectBT : Error $e");
      return false;
    }
  }







  
}
