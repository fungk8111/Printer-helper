package com.example.printer_helper_v2.pr3connect

import android.graphics.Bitmap
import android.graphics.Color
import honeywell.connection.ConnectionBase
import honeywell.connection.Connection_Bluetooth
import honeywell.printer.DocumentEZ
import honeywell.printer.DocumentLP
import honeywell.printer.DocumentPCL
import kotlin.math.ceil


class IntermecPR3 {
    private var conn: ConnectionBase? = null
    fun connect(address: String): Boolean {
        return try {

            conn = Connection_Bluetooth.createClient(address, false)

            if (!conn!!.isOpen) {
                conn!!.open()
//                Thread.sleep(1000)
                true
            } else {
                false
            }

        } catch (ignore: Exception) {
            false
        }
    }


    fun disconnect() {
        conn?.close()
    }


    fun printPhoto(bitmap: Bitmap) {
        val docLP = DocumentLP("!")
        docLP.writeImage(bitmap, 576, 128)
        val printData = docLP.documentData
        var bytesWritten = 0
        var bytesToWrite = 1024
        val totalBytes = printData.size
        var remainingBytes = totalBytes
        while (bytesWritten < totalBytes) {
            if (remainingBytes < bytesToWrite) bytesToWrite = remainingBytes

            //Send data, 1024 bytes at a time until all data sent
            conn!!.write(printData, bytesWritten, bytesToWrite)
            bytesWritten += bytesToWrite
            remainingBytes -= bytesToWrite
//            Thread.sleep(100)
        }
        docLP.clear()
    }


}