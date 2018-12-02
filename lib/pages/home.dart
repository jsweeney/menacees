import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import 'package:csv/csv.dart';
import 'dart:async';

import './species.dart';
import '../helpers/map_view_helper.dart';
import '../models/species.dart';
import '../models/location_data.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  final MapView mapView = new MapView();

  final Map<String, Species> speciesMap = {};

  Species currentSpecies;

  @override
  void initState() {
    Future<String> data =
        DefaultAssetBundle.of(context).loadString('assets/data/species.csv');
    data.then((value) {
      print(value);
      List<List<dynamic>> speciesData =
          CsvToListConverter(textDelimiter: '\"', eol: '\n').convert(value);
      print(speciesData.length);
      speciesData.removeAt(0);
      print("After");

      speciesData.forEach((speciesDatum) => print('${speciesDatum[0]} / ${speciesDatum[5]} : ${speciesDatum[6]} / ${speciesDatum[4]}'));

      speciesData.forEach((speciesDatum) {
        Species species = Species(
          id: speciesDatum[0],
          name: speciesDatum[1],
          description: speciesDatum[2],
          callout: speciesDatum[3],
          imagePath: 'assets/markers/${speciesDatum[4]}',
          location: LocationData(
              latitude: speciesDatum[5], longitude: speciesDatum[6]),
          remaining: speciesDatum[7],
          habitat: speciesDatum[8],
          eating: speciesDatum[9],
          reproduction: speciesDatum[10],
          lifeExpectancy: speciesDatum[11],
          danger: speciesDatum[12],
          funFacts: speciesDatum[13],
          organizations: speciesDatum[14],
        );
        speciesMap[species.id] = species;
      });
    });

    speciesMap.forEach((id, species) => print('$id - ${species.imagePath}'));

    super.initState();
  }

  static var markers = List<Marker>();

  static const CLOSE_ACTION = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Encore plus'),
            ),
            ListTile(
              title: Text('D\'autres informations très bientôt...'),
              onTap: () {},
            )
          ],
        ),
      ),
      appBar: AppBar(title: Text('Menacées!')),
      body: Column(children: [
        Text(''),
        Text('Trop d\'espèces sont en danger dans le monde!'),
        Text(''),
        Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          child: new Text(
              'Appuyer sur le bouton "carte" ci-dessous pour en apprendre plus.'),
        ),
        FlatButton(
          child: Text('Montrer une espèce: ${currentSpecies != null ? currentSpecies.name : 'NONE'}'),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      SpeciesPage(speciesMap.values.toList()[0]),
                ),
              ),
        )
      ]),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addFavorite,
        tooltip: 'Add Favorite',
        child: new Icon(Icons.map),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future _addFavorite() async {
    // 1. Show the map
    mapView.show(
        new MapOptions(
            showUserLocation: true,
            title: "Trouvez les espèces en danger!",
            initialCameraPosition:
                new CameraPosition(new Location(0.000, -64.225), 1.0)),
//                new CameraPosition(new Location(48.471031, -64.225), 11.0)),
//                new CameraPosition(new Location(-6.78602,	105.36108), 11.0)),

        toolbarActions: <ToolbarAction>[
          new ToolbarAction("Fermer", CLOSE_ACTION)
        ]);

    // //2. Listen for the onMapReady
    mapView.onMapReady.listen((_) {
      speciesMap.values.forEach((species) =>
          mapView.addMarker(MapViewHelper.createMapMarker(species)));
    });
    // //3. Listen for camera changed events
    // sub =
    //     mapView.onCameraChanged.listen((cam) => _updateRestaurantsAroundUser());
    // compositeSubscription.add(sub);

    //4. Listen for toolbar actions
    mapView.onToolbarAction.listen((id) {
      if (id == CLOSE_ACTION) {
        mapView.dismiss();
      }
    });

    mapView.onInfoWindowTapped.listen((marker) {
      print("onInfoWindowTapped: ${marker.id}");
    });
    // compositeSubscription.add(sub);
    mapView.onTouchAnnotation.listen((marker) {
      print("onTouchAnnotation: ${marker.id}");
      mapView.dismiss();
      Species selectedSpecies = speciesMap[marker.id];
      if (currentSpecies != selectedSpecies) {
        currentSpecies = selectedSpecies;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SpeciesPage(currentSpecies),
            ));
      }
    });
    // compositeSubscription.add(sub);
  }
}
