package com.example.flutterapp;

import android.os.Bundle;

import com.example.flutterapp.utils.BatteryUtils;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL_BATTERY = "samples.flutter.io/battery";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL_BATTERY).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if (methodCall.method.equals("getBatteryLevel")) {
                    int battery = BatteryUtils.getBatteryLevel(MainActivity.this.getApplicationContext());
                    if (battery != -1) {
                        result.success(battery);
                    } else {
                        result.error("UNAVAILABLE", "Battery level not available.", null);
                    }
                } else {
                    result.notImplemented();
                }
            }
        });
    }
}
