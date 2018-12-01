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

  static var markers = List<Marker>();

  static final Species testSpecies = Species(
    id: 'albatros',
    name: 'Albatros du Galapagos',
    description: 'Les Albatros du Galapagos sont des oiseaux',
    callout: 'Sauvons les albatros du Galapagos !',
    imagePath: 'assets/markers/albatros-icon.png',
    location: LocationData(latitude: 0.037298, longitude: -90.497785),
  );

  // static final MarkerIcon albatrosMarkerIcon = new MarkerIcon(
  //     'assets/markers/albatros-icon.png',
  //     width: 64.0,
  //     height: 64.0);
  // static final Marker albatrosMarker = new Marker(
  //     "albatros", "Sauvons les albatros du Galapagos !", 0.037298, -90.497785,
  //     markerIcon: albatrosMarkerIcon);
  static final Marker albatrosMarker =
      MapViewHelper.createMapMarker(testSpecies);

  static final MarkerIcon belugaMarkerIcon = new MarkerIcon(
      'assets/markers/beluga-icon.png',
      width: 64.0,
      height: 64.0);
  static final Marker belugaMarker = new Marker(
      "beluga", "Sauvons les bélugas du Saint-Laurent !", 45.307874, -74.010008,
      markerIcon: belugaMarkerIcon);

  static final MarkerIcon dholeMarkerIcon = new MarkerIcon(
      'assets/markers/dhole-icon.png',
      width: 64.0,
      height: 64.0);
  static final Marker dholeMarker = new Marker(
      "dhole", "Sauvez les dholes !", 21.545191, 79.773318,
      markerIcon: dholeMarkerIcon);

  static final MarkerIcon loutreMarkerIcon = new MarkerIcon(
      'assets/markers/loutre-icon.png',
      width: 64.0,
      height: 64.0);
  static final Marker loutreMarker = new Marker(
      "loutre", "Sauvez les loutres de Californie !", 35.343647, -124.148841,
      markerIcon: loutreMarkerIcon);

  static final MarkerIcon martreMarkerIcon = new MarkerIcon(
      'assets/markers/martre-icon.png',
      width: 64.0,
      height: 64.0);
  static final Marker martreMarker = new Marker(
      "martre", "Sauvons les martres d'Amérique !", 48.611856, -57.834332,
      markerIcon: martreMarkerIcon);

  static final MarkerIcon okapiMarkerIcon = new MarkerIcon(
      'assets/markers/okapi-icon.png',
      width: 64.0,
      height: 64.0);
  static final Marker okapiMarker = new Marker(
      "okapi", "Sauvons les okapis !", 1.771273, 29.435216,
      markerIcon: okapiMarkerIcon);

  static final MarkerIcon rhinoJavaMarkerIcon = new MarkerIcon(
      'assets/markers/rhino-java-icon.png',
      width: 64.0,
      height: 64.0);
  static final Marker rhinoJavaMarker = new Marker(
      "rhino-java", "Sauvez les rhinos de Java !", -6.78602, 105.36108,
      markerIcon: rhinoJavaMarkerIcon);

  static const CLOSE_ACTION = 1;

  @override
  Widget build(BuildContext context) {
    Future<String> data =
        DefaultAssetBundle.of(context).loadString('assets/data/species.csv');
    data.then((value) {
      print(value);
      List<List<dynamic>> speciesData = CsvToListConverter(eol: '\n').convert(value);
      print(speciesData.length);
      print(speciesData);
      speciesData.removeAt(0);
      print("After");
      print(speciesData);
      speciesData.forEach((speciesDatum) {
Species species = Species(
    id: speciesDatum[0],
    name: speciesDatum[1],
    description: speciesDatum[2],
    callout: speciesDatum[3],
    imagePath: speciesDatum[4],
    location: LocationData(latitude: speciesDatum[5], longitude: speciesDatum[6]),
  );
  print(species);
  print(species.imagePath);
  print(species.name);
  print('++${species.imagePath}++');
  print(species.location.latitude);
  print(species.location.longitude);


Species patateSpecies = Species(
    id: species.id, //'albatros',
    name: species.name, //'Albatros du Galapagos',
    description: species.description, //'Les Albatros du Galapagos sont des oiseaux',
    callout: species.callout, //'Sauvons les albatros du Galapagos !',
    imagePath: 'assets/markers/albatros-icon.png',
    location: species.location, //LocationData(latitude: 0.037298, longitude: -90.497785),
  );

// Species patateSpecies = Species(
//     id: species.id, //'albatros',
//     name: species.name, //'Albatros du Galapagos',
//     description: species.description, //'Les Albatros du Galapagos sont des oiseaux',
//     callout: species.callout, //'Sauvons les albatros du Galapagos !',
//     imagePath: species.imagePath, //'assets/markers/albatros-icon.png',
//     location: species.location, //LocationData(latitude: 0.037298, longitude: -90.497785),
//   );

  markers.add(MapViewHelper.createMapMarker(species));
      });
      markers.add(rhinoJavaMarker);
      markers.add(martreMarker);
    });

    // markers.add(albatrosMarker);

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
          child: Text('Montrer une espèce'),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SpeciesPage(testSpecies),
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
      markers.forEach((marker) => mapView.addMarker(marker));
      // mapView.addMarker(albatrosMarker);
      // mapView.addMarker(belugaMarker);
      // mapView.addMarker(dholeMarker);
      // mapView.addMarker(loutreMarker);
      // mapView.addMarker(martreMarker);
      // mapView.addMarker(okapiMarker);
      // mapView.addMarker(rhinoJavaMarker);
    });
    // var sub = mapView.onMapReady.listen((_) => _updateRestaurantsAroundUser());
    // compositeSubscription.add(sub);

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
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SpeciesPage(testSpecies),
          ));
    });
    // compositeSubscription.add(sub);
  }
}
