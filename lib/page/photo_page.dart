import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_camera/page/camera_page.dart';
import 'package:path_provider/path_provider.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  @override
  Widget build(BuildContext context) {
    Future<List<File>> getPhotos() async {
      final directory = await getApplicationDocumentsDirectory();
      final files = Directory(directory.path).listSync();
      return files
          .where((file) => file.path.endsWith('.jpg'))
          .toList()
          .cast<File>();
    }

    return Scaffold(
      body: FutureBuilder<List<File>>(
        future: getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Фотографий нет, нажмите на + чтобы сделать фото'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 400,
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Image.file(snapshot.data![index]))),
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CameraApp(),
            ),
          );
        },
      ),
    );
  }
}
