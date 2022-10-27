package com.example.flyy_test_task

import android.content.Intent
import android.graphics.Bitmap
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class MainActivity: FlutterActivity() {

    private val CHANNEL = "FLUTTER_CHANNEL"
    private val OPEN_CAMERA_METHOD = "OPEN_CAMERA"
    private val REQUEST_ID = 123

    private var methodResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result? ->
                if (call.method == OPEN_CAMERA_METHOD) {
                    methodResult = result
                    val camera_intent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
                    startActivityForResult(camera_intent, REQUEST_ID)
                }
            }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_ID && resultCode == RESULT_OK) {
            val photo = data.extras?.get("data") as Bitmap?

            val stream = ByteArrayOutputStream()
            photo?.compress(Bitmap.CompressFormat.PNG, 100, stream)
            val byteArray = stream.toByteArray()
            photo?.recycle()

            methodResult?.success(byteArray)
        } else {
            methodResult?.error("NO_IDEA", "Failed", null)
        }
    }
}