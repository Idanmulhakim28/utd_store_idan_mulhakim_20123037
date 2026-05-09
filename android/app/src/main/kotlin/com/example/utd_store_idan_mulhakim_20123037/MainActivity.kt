class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.example.device/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                if (call.method == "getBatteryLevel") {
                    val battery = getBatteryLevel()
                    result.success(battery)
                }

                else if (call.method == "showToast") {
                    val message = call.argument<String>("message")
                    Toast.makeText(applicationContext, message, Toast.LENGTH_SHORT).show()
                    result.success(null)
                }

                else {
                    result.notImplemented()
                }
            }
    }

    private fun getBatteryLevel(): Int {
        val bm = getSystemService(BATTERY_SERVICE) as BatteryManager
        return bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}