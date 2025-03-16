import Flutter
import UIKit

public class PrinterHelperV2Plugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "printer_helper_v2", binaryMessenger: registrar.messenger())
    let instance = PrinterHelperV2Plugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
      break
    
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  

}
