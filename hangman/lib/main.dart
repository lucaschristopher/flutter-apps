import 'package:flutter/material.dart';
import 'package:jogo_forca/screens/new-game/new_game.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NewGame(),
    theme: ThemeData(
      // primarySwatch: Colors.blue,
      primaryColor: Colors.blue,
      accentColor: Colors.white
    )
  ));
}