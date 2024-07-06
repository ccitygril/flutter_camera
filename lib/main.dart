import 'package:flutter/material.dart';
import 'package:flutter_camera/page/photo_page.dart';

void main() {
  runApp(const MaterialApp(
    home: PhotosPage(),
    localizationsDelegates: [],
    supportedLocales: [
      Locale('en', ''),
    ],
  ));
}
