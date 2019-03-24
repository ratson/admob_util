package io.github.ratson.admob_util;

import android.provider.Settings;

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
}
