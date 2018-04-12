package com.example.flutterhud;

import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "samples.flutter.io/ip_address";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        createMethodChannel();
        GeneratedPluginRegistrant.registerWith(this);
    }

    private void createMethodChannel() {

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {

                        switch (call.method) {
                            case "ip_address":
                                String ip = new IpAddress().getWifiIp(getApplicationContext());
                                result.success(ip);
                                break;
                            case "mobile_address":
                                ip = new IpAddress().getMobileIp(getApplicationContext());
                                result.success(ip);
                                break;
                            default:
                                result.notImplemented();
                        }
                    }
                });
    }

}
