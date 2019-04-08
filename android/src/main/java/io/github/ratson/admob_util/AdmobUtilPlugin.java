package io.github.ratson.admob_util;

import android.content.Context;
import android.provider.Settings;

import com.google.android.gms.ads.AdSize;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class AdmobUtilPlugin implements MethodCallHandler {
    private final Registrar registrar;

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "admob_util");
        channel.setMethodCallHandler(new AdmobUtilPlugin(registrar));
    }

    private AdmobUtilPlugin(Registrar registrar) {
        this.registrar = registrar;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("isTestDevice")) {
            result.success(isTestDevice());
        } else if (call.method.equals("getSmartBannerSize")) {
            result.success(getSmartBannerSize());
        } else {
            result.notImplemented();
        }
    }


    private boolean isTestDevice() {
        try {
            String testLabSetting = Settings.System.getString(registrar.context().getContentResolver(), "firebase.test.lab");
            return "true".equals(testLabSetting);
        } catch (Exception e) {
            return false;
        }
    }

    private double[] getSmartBannerSize() {
        final Context context = registrar.context();
        return new double[]{
                toLogicalPixels(AdSize.SMART_BANNER.getWidthInPixels(context), context),
                toLogicalPixels(AdSize.SMART_BANNER.getHeightInPixels(context), context)
        };
    }

    private double toLogicalPixels(double physicalPixels, Context context) {
        final float density = context.getResources().getDisplayMetrics().density;
        return physicalPixels / density;
    }
}
