import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

import './pages/home.dart';

void main() {
  // Google Cloud Platform - Project: Rachel Endangered Species
  MapView.setApiKey('AIzaSyCqqB2E2FCnYIWyRV9CEYJW7Sqpar147Ko');
  runApp(MenaceesApp());
} 

class MenaceesApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menacées',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}