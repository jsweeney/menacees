import 'package:flutter/material.dart';

import './location_data.dart';

class Species {
  final String id;
  final String name;
  final String description;
  final String callout;
  final String imagePath;
  final LocationData location;
  final String remaining;
  final String habitat;
  final String eating;
  final String reproduction;
  final String lifeExpectancy;
  final String danger;
  final String funFacts;
  final String organizations;
  final bool isFavorite;

  Species(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.callout,
      @required this.imagePath,
      @required this.location,
      @required this.remaining,
      @required this.habitat,
      @required this.eating,
      @required this.reproduction,
      @required this.lifeExpectancy,
      @required this.danger,
      @required this.funFacts,
      @required this.organizations,
      this.isFavorite = false});
}
