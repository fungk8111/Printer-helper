package com.example.printer_helper_v2

//import androidx.annotation.NonNull
//import honeywell.connection.ConnectionBase

import android.graphics.BitmapFactory
import com.example.printer_helper_v2.pr3connect.IntermecPR3
import com.example.printer_helper_v2.sunmiconnect.SunMiV2Connect
import com.example.printer_helper_v2.zebra.ZebraZQ320
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** PrinterHelperV2Plugin */
class PrinterHelperV2Plugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    private var pr3Printer: IntermecPR3 = IntermecPR3()

    private var sunMiV2Connect: SunMiV2Connect = SunMiV2Connect()
    private var zq320Connect: ZebraZQ320 = ZebraZQ320()


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "printer_helper_v2")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "pr3ConnectBT" -> {
                val macA: String? = call.argument("mac")
                val status: Boolean = pr3Printer.connect(macA.orEmpty())
                result.success(status)
            }

            "pr3Disconnect" -> {
                pr3Printer.disconnect()
            }

            "pr3PrintIMG" -> {
                val bytes: ByteArray? = call.argument("bitmap")
                val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes?.count() ?: 0)
                pr3Printer.printPhoto(bitmap)
            }

            "sun-miV2connect" -> {
                val ip: String? = call.argument("ipPrinter")
                val port: String? = call.argument("portPrinter")
                val res = sunMiV2Connect.connect(ip.orEmpty(), port.orEmpty())
                result.success(res)

            }

            "sun-miV2disconnect" -> {
                val res = sunMiV2Connect.disconnect()
                result.success(res)
            }

            "sun-miV2printImg" -> {
                val bytes: ByteArray? = call.argument("bitmap")
                val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes?.size ?: 0)
                sunMiV2Connect.printImage(bitmap)
//                result.success(res)
            }

            "sun-miV2cut" -> {
                val arg: Int? = call.argument("mode")
                val res = sunMiV2Connect.cutPaper(arg ?: 0)
                result.success(res)
            }

            "sun-miV2feed" -> {
                val arg: Int? = call.argument("distance")
                val res = sunMiV2Connect.feed(arg ?: 0)
                result.success(res)
            }

            "sun-miV2connectBT" -> {
                val arg: String? = call.argument("macAddress")
                val res = sunMiV2Connect.connectBT(arg.orEmpty())
                result.success(res)
            }

            "zq320-miV2connectBT" -> {
                val arg: String? = call.argument("macAddress")
                val res = zq320Connect.connectBluetooth(arg.orEmpty())
                result.success(res)
            }

            "zq320-disconnect" -> {
                zq320Connect.disconnect()
            }

            "zq320-printImage" -> {
                val bytes: ByteArray? = call.argument("bitmap")
                val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes?.count() ?: 0)
             zq320Connect.printImage(bitmap)
//                result.success(res)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


}
