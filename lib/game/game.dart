import 'package:flame/components.dart';
import 'dart:math' as math;
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:lompat_karet_game/game/actor.dart';
import 'package:lompat_karet_game/game/enemy.dart';
import 'package:lompat_karet_game/game/player.dart';
import 'package:lompat_karet_game/game/rope.dart';
import 'package:lompat_karet_game/game/ufo.dart';
import 'package:lompat_karet_game/game/ufo2.dart';
import 'package:lompat_karet_game/widgets/game_over_menu.dart';
import 'package:lompat_karet_game/widgets/game_win_menu.dart';

class LompatKaretGame extends FlameGame {
  late Player player;
  late Enemy enemy;
  late Rope rope;
  late Actor actor;
  late Ufo ufo;
  late Ufo2 ufo2;

  bool halfScreen = false;

  int difficulty;
  double finalValue;

  LompatKaretGame(this.difficulty, this.finalValue);

  bool _isAlreadyLoaded = false;

  @override
  Color backgroundColor() => Colors.transparent;

  @override
  Future<void>? onLoad() async {
    await images.load('ufo.png');
    await images.load('ufo2.png');

    player = Player(
      sprite: await loadSprite('isiboy.png'),
      size: Vector2(55, 73),
      position: Vector2(size.x * (3 / 12) - 7, size.y * (6 / 7)),
      anchor: Anchor.center,
    );

    actor = Actor(
      sprite: await loadSprite('isiboy.png'),
      size: Vector2(55, 73),
      position: Vector2(size.x * (3 / 12) - 7, size.y * (3.5 / 5)),
    );

    enemy = Enemy(
      sprite: await loadSprite('goblin.png'),
      size: Vector2(55, 73),
      position: Vector2(size.x * (8 / 12) + 3, size.y * (3.5 / 5) + 5),
    );

    rope = Rope(
      sprite: await loadSprite('rope.png'),
      size: Vector2(size.x * (9 / 10), size.x * (8 / 10) / 12 + 5),
      position: Vector2(
          size.x / 2 - (size.x * (9 / 10) / 2) - 5, size.y * (3.5 / 5) + 47),
    );

    ufo = Ufo();
    ufo.position = Vector2(size.x * (1 / 3), -90);
    ufo.size = Vector2(159, 90);

    ufo2 = Ufo2();
    ufo2.size = Vector2(159, 202);

    add(actor);
    add(enemy);
    add(rope);
    add(player);
    add(ufo);

    _isAlreadyLoaded = true;
  }

  @override
  void update(double dt) {
    super.update(dt);
    double _speed = 300;
    if (difficulty == 1) {
      if (finalValue > 69 && finalValue < 86 && halfScreen == false) {
        player.position += Vector2(2, -6) * _speed * dt;
        ufo.position += Vector2(0, 5) * _speed * dt;
        if (player.position.x > size.x / 2) {
          halfScreen = true;
          Future.delayed(const Duration(milliseconds: 700)).then((value) {
            ufo2.position = ufo.position;
            add(ufo2);
            remove(ufo);
          });
          Future.delayed(const Duration(milliseconds: 900)).then((value) {
            player.position += Vector2(0, -1) * _speed * dt;
            player.size -= Vector2(5, 5) * _speed * dt;
          });
          Future.delayed(const Duration(milliseconds: 1300)).then((value) {
            player.position += Vector2(0, -1) * _speed * dt;
            player.size -= Vector2(5, 5) * _speed * dt;
          });
          Future.delayed(const Duration(milliseconds: 1700)).then((value) {
            remove(player);
          });
          Future.delayed(const Duration(milliseconds: 2000)).then((value) {
            remove(ufo2);
            add(ufo);
          });
          Future.delayed(const Duration(milliseconds: 2300)).then((value) {
            overlays.add(GameOverMenu.ID);
            pauseEngine();
          });
        }
      }
      if (finalValue > 85 && finalValue <= 100) {
        player.position += Vector2(2, -6) * _speed * dt;
        Future.delayed(const Duration(milliseconds: 700)).then((value) {
          overlays.add(GameOverMenu.ID);
          pauseEngine();
        });
      }
      if (finalValue > 14 && finalValue < 31) {
        player.position += Vector2(7, -5) * 50 * dt;
        if (player.position.x > size.x / 2) {
          player.position += Vector2(0, 15) * 50 * dt;
          player.angle += -10 * dt;
          player.angle %= 2 * math.pi;
          Future.delayed(const Duration(milliseconds: 800)).then((value) {
            overlays.add(GameOverMenu.ID);
            pauseEngine();
          });
        }
      }
      if (finalValue > 0 && finalValue < 15) {
        player.position += Vector2(2, 0) * _speed * dt;
        player.angle += 25 * dt;
        player.angle %= 2 * math.pi;
        Future.delayed(const Duration(milliseconds: 800)).then((value) {
          overlays.add(GameOverMenu.ID);
          pauseEngine();
        });
      }
      if (finalValue <= 69 && finalValue >= 31) {
        player.position += Vector2(3, -5) * 50 * dt;
        if (player.position.x > size.x / 2) {
          overlays.add(GameWinMenu.ID);
          pauseEngine();
        }
      }
    }
    if (difficulty == 2) {
      if (finalValue > 63 && finalValue < 82 && halfScreen == false) {
        player.position += Vector2(2, -6) * _speed * dt;
        ufo.position += Vector2(0, 5) * _speed * dt;
        if (player.position.x > size.x / 2) {
          halfScreen = true;
          Future.delayed(const Duration(milliseconds: 700)).then((value) {
            ufo2.position = ufo.position;
            add(ufo2);
            remove(ufo);
          });
          Future.delayed(const Duration(milliseconds: 900)).then((value) {
            player.position += Vector2(0, -1) * _speed * dt;
            player.size -= Vector2(5, 5) * _speed * dt;
          });
          Future.delayed(const Duration(milliseconds: 1300)).then((value) {
            player.position += Vector2(0, -1) * _speed * dt;
            player.size -= Vector2(5, 5) * _speed * dt;
          });
          Future.delayed(const Duration(milliseconds: 1700)).then((value) {
            remove(player);
          });
          Future.delayed(const Duration(milliseconds: 2000)).then((value) {
            remove(ufo2);
            add(ufo);
          });
          Future.delayed(const Duration(milliseconds: 2300)).then((value) {
            overlays.add(GameOverMenu.ID);
            pauseEngine();
          });
        }
      }
      if (finalValue > 81 && finalValue <= 100) {
        player.position += Vector2(2, -6) * _speed * dt;
        Future.delayed(const Duration(milliseconds: 700)).then((value) {
          overlays.add(GameOverMenu.ID);
          pauseEngine();
        });
      }
      if (finalValue > 18 && finalValue < 38) {
        player.position += Vector2(7, -5) * 50 * dt;
        if (player.position.x > size.x / 2) {
          player.position += Vector2(0, 15) * 50 * dt;
          player.angle += -10 * dt;
          player.angle %= 2 * math.pi;
          Future.delayed(const Duration(milliseconds: 800)).then((value) {
            overlays.add(GameOverMenu.ID);
            pauseEngine();
          });
        }
      }
      if (finalValue > 0 && finalValue < 19) {
        player.position += Vector2(2, 0) * _speed * dt;
        player.angle += 25 * dt;
        player.angle %= 2 * math.pi;
        Future.delayed(const Duration(milliseconds: 800)).then((value) {
          overlays.add(GameOverMenu.ID);
          pauseEngine();
        });
      }
      if (finalValue <= 63 && finalValue >= 38) {
        player.position += Vector2(3, -5) * 50 * dt;
        if (player.position.x > size.x / 2) {
          overlays.add(GameWinMenu.ID);
          pauseEngine();
        }
      }
    }
    if (difficulty == 3) {
      if (finalValue > 58 && finalValue < 81 && halfScreen == false) {
        player.position += Vector2(2, -6) * _speed * dt;
        ufo.position += Vector2(0, 5) * _speed * dt;
        if (player.position.x > size.x / 2) {
          halfScreen = true;
          Future.delayed(const Duration(milliseconds: 700)).then((value) {
            ufo2.position = ufo.position;
            add(ufo2);
            remove(ufo);
          });
          Future.delayed(const Duration(milliseconds: 900)).then((value) {
            player.position += Vector2(0, -1) * _speed * dt;
            player.size -= Vector2(5, 5) * _speed * dt;
          });
          Future.delayed(const Duration(milliseconds: 1300)).then((value) {
            player.position += Vector2(0, -1) * _speed * dt;
            player.size -= Vector2(5, 5) * _speed * dt;
          });
          Future.delayed(const Duration(milliseconds: 1700)).then((value) {
            remove(player);
          });
          Future.delayed(const Duration(milliseconds: 2000)).then((value) {
            remove(ufo2);
            add(ufo);
          });
          Future.delayed(const Duration(milliseconds: 2300)).then((value) {
            overlays.add(GameOverMenu.ID);
            pauseEngine();
          });
        }
      }
      if (finalValue > 80 && finalValue <= 100) {
        player.position += Vector2(2, -6) * _speed * dt;
        Future.delayed(const Duration(milliseconds: 700)).then((value) {
          overlays.add(GameOverMenu.ID);
          pauseEngine();
        });
      }
      if (finalValue > 20 && finalValue < 43) {
        player.position += Vector2(7, -5) * 50 * dt;
        if (player.position.x > size.x / 2) {
          player.position += Vector2(0, 15) * 50 * dt;
          player.angle += -10 * dt;
          player.angle %= 2 * math.pi;
          Future.delayed(const Duration(milliseconds: 800)).then((value) {
            overlays.add(GameOverMenu.ID);
            pauseEngine();
          });
        }
      }
      if (finalValue > 0 && finalValue < 21) {
        player.position += Vector2(2, 0) * _speed * dt;
        player.angle += 25 * dt;
        player.angle %= 2 * math.pi;
        Future.delayed(const Duration(milliseconds: 800)).then((value) {
          overlays.add(GameOverMenu.ID);
          pauseEngine();
        });
      }
      if (finalValue <= 58 && finalValue >= 43) {
        player.position += Vector2(3, -5) * 50 * dt;
        if (player.position.x > size.x / 2) {
          overlays.add(GameWinMenu.ID);
          pauseEngine();
        }
      }
    }
  }
}
