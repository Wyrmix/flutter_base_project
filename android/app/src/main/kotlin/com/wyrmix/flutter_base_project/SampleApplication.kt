package com.wyrmix.flutter_base_project

import android.content.Context
import androidx.multidex.MultiDex
import io.flutter.app.FlutterApplication

class SampleApplication: FlutterApplication() {
    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        MultiDex.install(this)
    }
}
