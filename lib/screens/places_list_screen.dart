import 'package:flutter/material.dart';
import 'package:great_place_app/screens/place_detail_screen.dart';
import '../providers/great_places.dart';
import '../screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                })
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (ctx, snapShot) => snapShot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                )
              : Consumer<GreatPlaces>(
                  child: Center(
                    child: const Text('Got no places yet, Start adding more!!!'),
                  ),
                  builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <=
                          0
                      ? ch
                      : ListView.builder(
                          itemBuilder: (ctx, index) => Padding(
                            padding: EdgeInsets.all(10),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: FileImage(
                                  greatPlaces.items[index].image,
                                ),
                              ),
                              title: Text(greatPlaces.items[index].title),
                              subtitle: Text(
                                  greatPlaces.items[index].location.address),
                              onTap: () {
                                // navigate to detail page
                                Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: greatPlaces.items[index].id);
                              },
                            ),
                          ),
                          itemCount: greatPlaces.items.length,
                        ),
                ),
        ));
  }
}
