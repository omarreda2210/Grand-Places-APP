import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grand_pleasces_app/provedrs/users_pleaces.dart';
import 'package:grand_pleasces_app/screens/add_places.dart';
import 'package:grand_pleasces_app/widegts/places_list.dart';

class PlcesListScreen extends ConsumerStatefulWidget {
  const PlcesListScreen({super.key});
  @override
  ConsumerState<PlcesListScreen> createState() {
    return _PlcesListScreenState();
  }
}

class _PlcesListScreenState extends ConsumerState<PlcesListScreen> {
  late Future<void> placessFuture;
  @override
  void initState() {
    super.initState();
    placessFuture = ref.read(userPlasesProvide.notifier).loadStordData();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final userPlaces = ref.watch(userPlasesProvide);
    return Scaffold(
      appBar: AppBar(
        title: const Text('your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: placessFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PlaceList(
                      places: userPlaces,
                    ),
        ),
      ),
    );
  }
}
