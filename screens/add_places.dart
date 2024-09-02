import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grand_pleasces_app/models/place.dart';
import 'package:grand_pleasces_app/provedrs/users_pleaces.dart';
import 'package:grand_pleasces_app/widegts/image_inputer.dart';
import 'package:grand_pleasces_app/widegts/locotion_inpouter.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final titleControll = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? selectedImage;
  PlaceLocieon? selectedLocaion;
  void addPlace() {
    final enterdText = titleControll.text;

    if (enterdText.isEmpty ||
        selectedImage == null ||
        selectedLocaion == null) {
      return;
    }

    ref
        .read(userPlasesProvide.notifier)
        .addPlace(enterdText, selectedImage!, selectedLocaion!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    titleControll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add new place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Form(
            key: formKey,
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text('title'),
              ),
              controller: titleControll,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ImageInupter(
            onPickImage: (image) {
              selectedImage = image;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          LocationInpouter(
            onSelectLocaion: (location) {
              selectedLocaion = location;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton.icon(
            onPressed: addPlace,
            icon: const Icon(Icons.add),
            label: const Text('add place'),
          ),
        ]),
      ),
    );
  }
}
