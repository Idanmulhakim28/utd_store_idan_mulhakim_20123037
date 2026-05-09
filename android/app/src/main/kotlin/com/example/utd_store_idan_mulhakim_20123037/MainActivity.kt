package com.example.utd_store_idan_mulhakim_20123037

import android.os.BatteryManager
import android.content.Context
import android.widget.Toast

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.device/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                "getBatteryLevel" -> {
                    val batteryManager =
                        getSystemService(Context.BATTERY_SERVICE)
                                as BatteryManager

                    val batteryLevel = batteryManager.getIntProperty(
                        BatteryManager.BATTERY_PROPERTY_CAPACITY
                    )

                    result.success(batteryLevel)
                }

                "showToast" -> {
                    val message =
                        call.argument<String>("message")

                    Toast.makeText(
                        this,
                        message,
                        Toast.LENGTH_SHORT
                    ).show()

                    result.success(null)
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}