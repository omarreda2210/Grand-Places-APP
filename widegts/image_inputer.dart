import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInupter extends StatefulWidget {
  const ImageInupter({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;

  @override
  State<StatefulWidget> createState() {
    return ImageInputerState();
  }
}

class ImageInputerState extends State<ImageInupter> {
  File? selectedTakedImage;
  void addPohoto() async {
    final imagePiker = ImagePicker();
    final takedImage = await imagePiker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (takedImage == null) {
      return;
    }
    setState(() {
      selectedTakedImage = File(takedImage.path);
    });
    widget.onPickImage(selectedTakedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget takedContent = TextButton.icon(
      icon: const Icon(
        Icons.camera,
      ),
      onPressed: addPohoto,
      label: const Text('take a photo'),
    );
    if (selectedTakedImage != null) {
      takedContent = GestureDetector(
        onTap: addPohoto,
        child: Image.file(
          selectedTakedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      child: Container(child: takedContent),
    );
  }
}
