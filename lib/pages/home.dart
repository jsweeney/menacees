import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  final MapView mapView = new MapView();

  static final MarkerIcon gannetMarkerIcon =
      new MarkerIcon('assets/markers/bird-icon.png', width: 64.0, height: 64.0);
  static final Marker gannetMarker = new Marker(
      "TEST", "Save the gannets bro!", 48.494843, -64.145990,
      markerIcon: gannetMarkerIcon);

  static final MarkerIcon dholeMarkerIcon =
      new MarkerIcon('assets/markers/dhole-icon.png', width: 64.0, height: 64.0);
  static final Marker dholeMarker = new Marker(
      "TEST", "Save the dhole bro!", 21.545191, 79.773318,
      markerIcon: dholeMarkerIcon);

  static final MarkerIcon rhinoJavaMarkerIcon =
      new MarkerIcon('assets/markers/rhino-java-icon.png', width: 64.0, height: 64.0);
  static final Marker rhinoJavaMarker = new Marker(
      "Rhino Java", "Save the rhino bro!", -6.78602,	105.36108,
      markerIcon: rhinoJavaMarkerIcon);


  static const CLOSE_ACTION = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              title: Text('Learn more...'),
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
        Text('Appuyer sur le bouton "carte" ci-dessous pour en apprendre plus.')
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
          new ToolbarAction("Close", CLOSE_ACTION)
        ]);

    // //2. Listen for the onMapReady
    mapView.onMapReady.listen((_) {
      mapView.addMarker(gannetMarker);
      mapView.addMarker(dholeMarker);
      mapView.addMarker(rhinoJavaMarker);
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
    });
    // compositeSubscription.add(sub);
  }
}
