package com.example.printer_helper_v2.sunmiconnect

import android.app.Activity
import android.content.Context
import android.graphics.Bitmap
import print.Print

class SunMiV2Connect {

    private val context: Context? = null

    fun connect(ipPrinter: String, portPrinter: String): Boolean {

        return try {
//            Print.PortClose()
            val strIP = ipPrinter.trim()
            val strPort = portPrinter.trim()
            val connectStatus = Print.PortOpen(context, "WiFi,$strIP,$strPort")

            if (connectStatus == 0) {
                true
            } else {
                false
            }

        } catch (e: Exception) {
            false
        }
    }

    fun connectBT(macAddress: String): Boolean {
        return try {
//            Print.PortClose()
//            val strMAC = macAddress

            if (Print.PortOpen(context, "Bluetooth,$macAddress") != 0) {
                false
            } else {
                true
            }

        } catch (e: Exception) {
            e.message ?: "Error"
            false
        }

    }

    fun disconnect(): Boolean {
        return try {
            Print.PortClose()
//            finish()
            true
        } catch (e: Exception) {
            false
        }
    }

    fun cutPaper(mode: Int) {
        try {
            Print.CutPaper(mode)

        } catch (e: Exception) {
            e.toString()
        }
    }

    fun feed(distance: Int): String {
        return try {
            var result = Print.PrintAndFeed(distance)
            result.toString()
        } catch (e: Exception) {
            e.toString()
        }
    }

    fun printImage(args: Bitmap) {
        try {
            Print.PrintBitmap(args, 1, 0)


        } catch (e: Exception) {
            e.toString()
        }
    }


}