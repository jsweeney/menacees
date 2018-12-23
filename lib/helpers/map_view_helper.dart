import 'package:map_view/map_view.dart';

import '../models/species.dart';

class MapViewHelper {
  static Marker createMapMarker(Species species) {
    MarkerIcon markerIcon =
        new MarkerIcon(species.imagePathMarker, width: 64.0, height: 64.0);
    Marker marker = new Marker(species.id, species.callout,
        species.location.latitude, species.location.longitude,
        markerIcon: markerIcon);
    return marker;
  }
}
