import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ScreenGallery extends StatefulWidget {
  const ScreenGallery({Key? key}) : super(key: key);

  @override
  State<ScreenGallery> createState() => _ScreenGalleryState();
}

class _ScreenGalleryState extends State<ScreenGallery> {
  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    items.add(image.path);
    return File(imagePath).copy(image.path);
  }

  final List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 244, 223, 31),
          title: const Text(
            'Gallery',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: (() {
                pickCamera();
              }),
              icon: const Icon(Icons.camera_alt_outlined),
            )
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
                itemBuilder: ((context, index) {
                  return SizedBox(
                    height: 100,
                    width: 100,
                    child: Image(
                      image: FileImage(
                        File(items[index].toString()),
                      ),
                      fit: BoxFit.cover,
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  File? image;

  Future pickCamera() async{
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }

    final imagePermanent = await saveImagePermanently(image.path);
    setState(() => this.image = imagePermanent);
  }
}
