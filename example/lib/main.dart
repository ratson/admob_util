import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:admob_util/admob_util.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isTestDevice = false;

  @override
  void initState() {
    super.initState();
    initAppState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initAppState() async {
    bool isTestDevice = await AdmobUtil.isTestDevice;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _isTestDevice = isTestDevice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('isTestDevice: $_isTestDevice\n'),
        ),
      ),
    );
  }
}
