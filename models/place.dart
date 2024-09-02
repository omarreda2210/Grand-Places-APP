import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocieon {
  const PlaceLocieon({
    required this.adress,
    required this.latitud,
    required this.longtoud,
  });
  final double latitud;
  final double longtoud;
  final String adress;
}

class Place {
  Place(
      {required this.title,
      required this.image,
      required this.locatoin,
      String? id})
      : id = id ?? uuid.v4();
  final String id;
  final String title;
  final File image;
  final PlaceLocieon locatoin;
}
