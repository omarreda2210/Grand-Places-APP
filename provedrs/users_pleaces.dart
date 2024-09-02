import 'dart:io';

import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:grand_pleasces_app/models/place.dart';

Future<Database> getDataBase() async {
  final dbPath = await sql.getDatabasesPath();
  final dataP = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_pacese(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,lng REAL,addres TEXT)');
    },
    version: 1,
  );
  return dataP;
}

class UsersPleasNotifer extends StateNotifier<List<Place>> {
  UsersPleasNotifer() : super(const []);

  Future<void> loadStordData() async {
    final dataP = await getDataBase();
    final data = await dataP.query('user_pacese');
    final places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            locatoin: PlaceLocieon(
              latitud: row['lat'] as double,
              longtoud: row['lng'] as double,
              adress: row['addres'] as String,
            ),
          ),
        )
        .toList();
    state = places;
  }

  void addPlace(String title, File image, PlaceLocieon locatoin) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace =
        Place(title: title, image: copiedImage, locatoin: locatoin);
    final dataP = await getDataBase();
    dataP.insert('user_pacese', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.locatoin.latitud,
      'lng': newPlace.locatoin.longtoud,
      'addres': newPlace.locatoin.adress,
    });

    state = [newPlace, ...state];
  }
}

final userPlasesProvide = StateNotifierProvider<UsersPleasNotifer, List<Place>>(
    (ref) => UsersPleasNotifer());
