import 'dart:io';

import 'package:flutter/cupertino.dart' as IOS;
import 'package:flutter/material.dart' as Android;
import 'package:flutter/widgets.dart';
import 'package:flutter_arch_template/features/home/presentation/pages/home_page.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(FlutterAppTemplate());
}

const _APP_NAME = 'Flutter App Template';

class FlutterAppTemplate extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildCupertinoApp();
    } else {
      return buildMaterialApp();
    }
  }

  // create iOS app
  IOS.CupertinoApp buildCupertinoApp() {
    return IOS.CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: IOS.CupertinoThemeData(
            primaryColor: const IOS.Color(0xff455a64),
            primaryContrastingColor: const IOS.Color(0xff1c313a)),
        title: _APP_NAME,
        home: HomePage());
  }

  // create android app
  Android.MaterialApp buildMaterialApp() {
    return Android.MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _APP_NAME,
      theme: Android.ThemeData(
        primaryColor: const Android.Color(0xff455a64),
        accentColor: const Android.Color(0xff1c313a),
      ),
      home: HomePage(),
    );
  }
}
