import 'package:flutter/material.dart';
import 'package:flutter_arch_template/features/pictures/presentation/pages/home_page.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(FlutterAppTemplate());
}

class FlutterAppTemplate extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App Template',
      theme: ThemeData(
        primaryColor: const Color(0xff455a64),
        accentColor: const Color(0xff1c313a),
      ),
      home: HomePage(),
    );
  }
}
