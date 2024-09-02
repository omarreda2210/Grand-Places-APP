import 'package:flutter/material.dart';
import 'package:grand_pleasces_app/models/place.dart';
import 'package:grand_pleasces_app/screens/maps.dart';

class PlaceDitelsScreen extends StatelessWidget {
  const PlaceDitelsScreen({super.key, required this.place});
  final Place place;
  String get locaionImagee {
    final lat = place.locatoin.latitud;
    final lon = place.locatoin.longtoud;
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lon&key=***********";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => MapsScreen(
                              locatoin: place.locatoin,
                              isSelcteing: false,
                            )));
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(locaionImagee),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Colors.black54,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                  alignment: Alignment.center,
                  child: Text(
                    place.locatoin.adress,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
