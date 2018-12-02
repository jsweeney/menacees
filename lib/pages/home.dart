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
      List<List<dynamic>> speciesData =
          CsvToListConverter(textDelimiter: '\"', eol: '\n').convert(value);
      speciesData.removeAt(0);

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
          gestation: speciesDatum[11],
          litter: speciesDatum[12],
          lifeExpectancy: speciesDatum[13],
          danger: speciesDatum[14],
          funFacts: speciesDatum[15],
          organizations: speciesDatum[16],
        );
        speciesMap[species.id] = species;
      });
    });

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
              title: Text('Quelques mots sur moi...'),
            ),
            Container(
              child: Column(children: <Widget>[
                Text(
                    'Mon nom est Rachel Sweeney et je suis dans le programme PEI en secondaire 5.',
                    style: TextStyle(fontSize: 16)),
                Text(''),
                Text(
                    'Pour mon projet personnel cette année, j’ai décidé de développer cette application pour vous informer sur les espèces en voie d’extinction.',
                    style: TextStyle(fontSize: 16)),
                Text(''),
                Text('J’espère que vous allez l’apprécier.  Merci!',
                    style: TextStyle(fontSize: 16)),
              ]),
              margin: EdgeInsets.all(15),
            )
          ],
        ),
      ),
      appBar: AppBar(title: Text('Menacées!')),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          child: new Text(
            'Trop d\'espèces sont en danger dans le monde!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          child: new Text(
            'Nous pouvons tous aider les espèces en voie d’extinction en nous informant plus à leur sujet. Vous allez pouvoir en apprendre davantage sur certaines de celles-ci à l’aide de cette application. Elle inclut une carte qui vous aidera à situer ces espèces ainsi que certaines informations pertinentes à propos d’elles.',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          child: new Text(
            'Appuyer sur l\'icône "carte" ci-dessous pour en apprendre plus.',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ]),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addFavorite,
        tooltip: 'Add Favorite',
        child: new Icon(Icons.map),
      ),
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

    // mapView.onInfoWindowTapped.listen((marker) {
    // });

    mapView.onTouchAnnotation.listen((marker) {
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
  }
}
