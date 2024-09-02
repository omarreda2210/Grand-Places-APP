import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grand_pleasces_app/models/place.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({
    super.key,
    this.locatoin =
        const PlaceLocieon(latitud: 37.422, longtoud: -122.084, adress: ""),
    this.isSelcteing = true,
  });
  final PlaceLocieon locatoin;
  final bool isSelcteing;

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? pikedLocatoin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelcteing ? 'pick your locatoin' : 'your locatoin'),
        actions: [
          if (widget.isSelcteing)
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop(pikedLocatoin);
                },
                icon: const Icon(Icons.save))
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelcteing
            ? null
            : (position) {
                setState(() {
                  pikedLocatoin = position;
                });
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.locatoin.latitud, widget.locatoin.longtoud),
          zoom: 15,
        ),
        markers: (pikedLocatoin == null && widget.isSelcteing)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('om1'),
                  position: pikedLocatoin ??
                      LatLng(widget.locatoin.latitud, widget.locatoin.longtoud),
                )
              },
      ),
    );
  }
}
