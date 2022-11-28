import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:lompat_karet_game/game/game.dart';
import 'package:lompat_karet_game/screens/main_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MaterialApp(
      home: MainMenu(),
    ),
  );
}
