import 'package:flutter/material.dart';

import './location_data.dart';

class Species {
  final String id;
  final String name;
  final String description;
  final String callout;
  final String imagePath;
  final LocationData location;
  final bool isFavorite;

  Species(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.callout,
      @required this.imagePath,
      @required this.location,
      this.isFavorite = false});
}
