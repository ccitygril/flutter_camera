import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/page/photo_page.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MaterialApp(
    home: PhotosPage(cameras: cameras),
    localizationsDelegates: [],
    supportedLocales: const [
      Locale('en', ''),
    ],
  ));
}
