import 'dart:ui';

import 'package:flame/components.dart';
import 'package:lompat_karet_game/game/game.dart';

class Ufo2 extends SpriteAnimationComponent with HasGameRef<LompatKaretGame> {
  @override
  Future<void>? onLoad() {
    animation = SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('ufo2.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.3,
        textureSize: Vector2(159, 202),
      ),
    );
  }
}
