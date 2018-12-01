import 'package:map_view/map_view.dart';

import '../models/species.dart';
import '../models/location_data.dart';

class MapViewHelper {
  static Marker createMapMarker(Species species) {
    MarkerIcon markerIcon = new MarkerIcon(
        species.imagePath,
        width: 64.0,
        height: 64.0);
    Marker marker = new Marker(species.name,
        species.callout, species.location.latitude, species.location.longitude,
        markerIcon: markerIcon);
    return marker;
  }
}
