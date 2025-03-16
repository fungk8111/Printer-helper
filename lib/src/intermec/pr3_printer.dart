import 'dart:developer';

import 'package:flutter/services.dart';

class Pr3ConnectPrinter {
  final methodChannel = const MethodChannel('printer_helper_v2');

  Future<bool> connectBluetooth(
    String macAddress,
  ) async {
    try {
      // methodChannel
      Map<String, dynamic> params = {
        "mac": macAddress,
      };
      bool res = await methodChannel.invokeMethod('pr3ConnectBT', params);
      return res;
    } catch (e) {
      log("connectBluetoothPR3 : Error $e");
      return false;
    }
  }

  // Disconnect
  Future<void> disconnect() async {
    try {
      await methodChannel.invokeMethod('pr3Disconnect');
    } catch (e) {
      log("disconnectBluetoothPR3 : Error $e");
    }
  }

  Future<void> image(
    Uint8List imgSr,
  ) async {
    try {
      Map<String, dynamic> arguments = <String, dynamic>{};
      arguments.putIfAbsent("bitmap", () => imgSr);
      await methodChannel.invokeMethod('pr3PrintIMG', arguments);
    } catch (e) {
      log("pr3PrintIMG : Error $e");
    }
  }
}
