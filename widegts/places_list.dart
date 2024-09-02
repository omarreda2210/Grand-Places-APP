// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:grand_pleasces_app/models/place.dart';
import 'package:grand_pleasces_app/screens/pleaces_ditels.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({
    super.key,
    required this.places,
  });
  final List<Place> places;
  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Container(
              width: 400,
              height: 400,
              child: const Image(
                image: AssetImage('images/effil.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: Text('you have no favorit place yet please add some ',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
            ),
          )
        ],
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(
            places[index].image,
          ),
        ),
        title: Text(
          places[index].title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        subtitle: Text(
          places[index].locatoin.adress,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlaceDitelsScreen(
              place: places[index],
            ),
          ));
        },
      ),
    );
  }
}
