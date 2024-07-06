import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/page/photo_page.dart';
import 'package:path_provider/path_provider.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({super.key, required this.cameras});
  final List<CameraDescription> cameras;

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
  }

  Future<void> _takePicture() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/${DateTime.now()}.jpg';
    final file = File(path);
    final image = await controller.takePicture();
    await file.writeAsBytes(await image.readAsBytes());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return CameraPreview(
      controller,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: IconButton(
          icon: const Icon(
            CupertinoIcons.photo_camera_solid,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            _takePicture();
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Отлично'),
                content: const Text('Фото добавлено в колекцию'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhotosPage(
                              cameras: widget.cameras,
                            ),
                          ),
                        );
                      },
                      child: const Text("Ok"))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
