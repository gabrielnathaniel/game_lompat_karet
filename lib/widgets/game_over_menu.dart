import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lompat_karet_game/screens/difficulty_menu.dart';
import 'package:lompat_karet_game/screens/game_play.dart';
import 'package:lompat_karet_game/screens/main_menu.dart';

import 'package:provider/provider.dart';

import '../game/game.dart';

// This represents the game over overlay,
// displayed with dino runs out of lives.
class GameOverMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const ID = 'GameOverMenu';

  // Reference to parent game.
  final LompatKaretGame gameRef;

  const GameOverMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  const Text(
                    'Ayo lompat doang masa gagal sih!',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                  const Text(
                    'Yuk main lagi kalo mau dapet star!',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    child: const Text(
                      'Ulang!',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                    onPressed: () {
                      gameRef.overlays.remove(GameOverMenu.ID);
                      gameRef.resumeEngine();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const DifficultyMenu(),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text(
                      'Keluar',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                    onPressed: () async {
                      gameRef.overlays.remove(GameOverMenu.ID);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => MainMenu(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
