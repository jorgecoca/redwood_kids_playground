import 'package:flutter/material.dart';
import 'car.dart';

void main() => runApp(RedwoodPlaygroundApp());

class RedwoodPlaygroundApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Redwood!👋'),
          backgroundColor: Colors.orange,
        ),
        body: Car(
          color: Colors.orange,
          sound: Sound.horn,
        ),
      ),
    );
  }
}
