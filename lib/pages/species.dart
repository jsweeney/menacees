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
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(species.name),
          ),
          body: Container(
            margin: EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              Row(children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text('Nombre restant : ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('~'),
                        Text('${species.remaining}')
                      ]),
                      Row(children: <Widget>[
                        Text('Espérance de vie : ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${species.lifeExpectancy}')
                      ]),
                      Row(children: <Widget>[
                        Text('Gestation : ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${species.gestation}'),
                        Text(' mois')
                      ]),
                      Row(children: <Widget>[
                        Text('Portée : ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${species.litter}')
                      ]),
                    ]),
                Container(
                    margin: EdgeInsets.all(30),
                    child: Image(
                        image: AssetImage(species.imagePathDetail),
                        height: 125,
                        width: 125)),
              ]),
              Text('Habitat',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(species.habitat),
              Text(''),
              Text('Alimentation',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(species.eating),
              Text(''),
              Text('En danger',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(species.danger),
              Text(''),
              Text('Organisations',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(species.organizations),
              Text(''),
              Text('Faits cocasses',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(species.funFacts),
              Text(''),
            ]),
          ),
        ));
  }
}
