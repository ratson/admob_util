package io.github.ratson.admob_util;

import androidx.annotation.NonNull;
import android.content.Context;
import android.provider.Settings;

import com.google.android.gms.ads.AdSize;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class AdmobUtilPlugin implements FlutterPlugin, MethodCallHandler {
    private Context applicationContext;
    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
      this.applicationContext = flutterPluginBinding.getApplicationContext();
      channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "admob_util");
      channel.setMethodCallHandler(this);
    }
  
    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
      if (call.method.equals("isTestDevice")) {
          result.success(isTestDevice());
      } else if (call.method.equals("getSmartBannerSize")) {
          result.success(getSmartBannerSize());
      } else {
        result.notImplemented();
      }
    }
  
    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
      applicationContext = null;
      channel.setMethodCallHandler(null);
      channel = null;
    }

    private boolean isTestDevice() {
        try {
            String testLabSetting = Settings.System.getString(applicationContext.getContentResolver(), "firebase.test.lab");
            return "true".equals(testLabSetting);
        } catch (Exception e) {
            return false;
        }
    }

    private double[] getSmartBannerSize() {
        final Context context = applicationContext;
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
