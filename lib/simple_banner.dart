import 'package:admob_util/admob_util.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class _BannerStateHolder extends InheritedWidget {
  _BannerStateHolder({
    Key key,
    @required Widget child,
    @required this.state,
  }) : super(key: key, child: child);

  final SimpleBannerAdState state;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

class SimpleBannerAd extends StatefulWidget {
  SimpleBannerAd(
      {Key key,
      @required this.child,
      @required this.adUnitId,
      this.targetingInfo,
      this.listener})
      : super(key: key);

  final Widget child;
  final String adUnitId;
  final MobileAdTargetingInfo targetingInfo;
  final MobileAdListener listener;

  @override
  State<StatefulWidget> createState() => SimpleBannerAdState();

  static SimpleBannerAdState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_BannerStateHolder)
            as _BannerStateHolder)
        .state;
  }
}

class SimpleBannerAdState extends State<SimpleBannerAd> {
  BannerAd _bannerAd;
  Size _bannerSize;

  @override
  void initState() {
    super.initState();

    _bannerAd = _createBannerAd();
    _showBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _bannerAd = null;
    _bannerSize = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: _BannerStateHolder(state: this, child: widget.child),
      padding: EdgeInsets.only(
          bottom: _bannerSize == null ? 0 : _bannerSize.height),
    );
  }

  BannerAd _createBannerAd() {
    return BannerAd(
      adUnitId: widget.adUnitId,
      size: AdSize.smartBanner,
      targetingInfo: widget.targetingInfo,
      listener: (MobileAdEvent event) async {
        if (widget.listener != null) {
          widget.listener(event);
        }

        if (event == MobileAdEvent.loaded) {
          final bannerSize = await AdmobUtil.getSmartBannerSize();
          setState(() {
            _bannerSize = bannerSize;
          });
        } else if (event == MobileAdEvent.failedToLoad) {
          setState(() {
            _bannerSize = null;
          });
        }
      },
    );
  }

  _showBannerAd() async {
    if (await AdmobUtil.isTestDevice || _bannerSize != null) {
      return;
    }

    await _bannerAd
      ..load()
      ..show();
  }
}
