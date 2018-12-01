import 'dart:async';

import 'package:flutter/material.dart';

import '../models/species.dart';

class SpeciesPage extends StatelessWidget {
  final Species species;

  SpeciesPage(this.species);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(species.name),
          ),
          body: Text("patate")),
    );
  }
}
