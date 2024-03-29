import 'package:camera/camera.dart';
import 'package:emotions/EmotionDetector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'Splach_Screen.dart';
List<CameraDescription>? cameras;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  cameras= await availableCameras();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplachScreen(),
    );
  }
}

