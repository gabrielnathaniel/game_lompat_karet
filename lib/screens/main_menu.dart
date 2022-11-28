import 'package:flutter/material.dart';
import 'package:lompat_karet_game/screens/difficulty_menu.dart';
import 'package:lompat_karet_game/screens/game_play.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/rumahgadang.png',
          width: 1000,
          height: 900,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    'LOMPAT KARET',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 40,
                        shadows: [
                          const Shadow(
                            blurRadius: 20,
                            color: Colors.grey,
                            offset: Offset(0, 0),
                          )
                        ],
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: ElevatedButton(
                    child: const Text(
                      'Lompat!',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const DifficultyMenu(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
