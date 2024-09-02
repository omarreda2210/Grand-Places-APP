import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grand_pleasces_app/screens/maps.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'package:grand_pleasces_app/models/place.dart';

class LocationInpouter extends StatefulWidget {
  const LocationInpouter({super.key, required this.onSelectLocaion});
  final void Function(PlaceLocieon location) onSelectLocaion;

  @override
  State<LocationInpouter> createState() => _LocationInpouterState();
}

class _LocationInpouterState extends State<LocationInpouter> {
  PlaceLocieon? pickedLocation;
  var isGittengLocatoin = false;
  String get locaionImagee {
    if (pickedLocation == null) {
      return '';
    }
    final lat = pickedLocation!.latitud;
    final lon = pickedLocation!.longtoud;
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lon&key=**********";
  }

  Future<void> saivePlace(double lat, double long) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyCMo9Y409Qx_VpCS0wUgADpokDBMJffNE0');
    final responce = await http.get(url);
    final resoData = json.decode(responce.body);
    final adrees = resoData['results'][0]['formatted_address'];
    setState(() {
      pickedLocation =
          PlaceLocieon(adress: adrees, latitud: lat, longtoud: long);
      isGittengLocatoin = false;
    });

    widget.onSelectLocaion(pickedLocation!);
  }

  void getCurrentLocatoin() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isGittengLocatoin = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lon = locationData.longitude;
    if (lon == null || lat == null) {
      return;
    }
    saivePlace(lat, lon);
  }

  void selectOnMap() async {
    final pikedLocatoin = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(builder: (ctx) => const MapsScreen()),
    );
    if (pikedLocatoin == null) {
      return;
    }
    saivePlace(pikedLocatoin.latitude, pikedLocatoin.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget prevoiContent = Text(
      'no locatoin chossed ',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
    if (pickedLocation != null) {
      prevoiContent = Image.network(
        locaionImagee,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    if (isGittengLocatoin) {
      prevoiContent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: prevoiContent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: getCurrentLocatoin,
              icon: const Icon(Icons.location_on),
              label: const Text('Get Current location  '),
            ),
            TextButton.icon(
              onPressed: selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('select on map'),
            ),
          ],
        )
      ],
    );
  }
}
