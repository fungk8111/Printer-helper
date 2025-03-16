package com.example.printer_helper_v2.zebra

import android.graphics.Bitmap
import android.graphics.Color
import com.zebra.sdk.comm.BluetoothConnection
import com.zebra.sdk.graphics.internal.ZebraImageAndroid
import com.zebra.sdk.printer.PrinterLanguage
import com.zebra.sdk.printer.ZebraPrinter
import com.zebra.sdk.printer.ZebraPrinterFactory
import kotlin.math.ceil

class ZebraZQ320 {

    private lateinit var connection: BluetoothConnection

    fun connectBluetooth(
        macAddress: String
    ): Boolean {

        return try {
            connection = BluetoothConnection(macAddress)
            connection.open()
            if (connection.isConnected) {
                true
            } else {
                connection.close()
                false
            }
        } catch (e: Exception) {
            false
        }
    }


    fun disconnect() {
        connection.close()
    }


     fun printImage(bitmap: Bitmap) {
         try {

            val printer1 = ZebraPrinterFactory.getInstance(PrinterLanguage.CPCL, connection)
            val zebraImageToPrint = ZebraImageAndroid(bitmap)
             println(zebraImageToPrint)
            Thread.sleep(1000L)
            printer1.printImage(zebraImageToPrint, 0, 0, bitmap.width, bitmap.height, false)
        } catch (e: Exception) {
            e.toString()
        }

    }


}