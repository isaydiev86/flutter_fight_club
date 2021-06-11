import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:flutter_fight_club/fight_club_images.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.pressStart2pTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const maxLives = 5;

  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  BodyPart whatEnemyAttacks = BodyPart.random();
  BodyPart whatEnemyDefends = BodyPart.random();

  int yourLives = maxLives;
  int enemiesLives = maxLives;

  String centerText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              maxLivesCount: maxLives,
              yourLivesCount: yourLives,
              enemiesLivesCount: enemiesLives,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 30.0),
                child: ColoredBox(
                  color: Color(0xFFC5D1EA),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Text(
                        centerText,
                        style: TextStyle(
                          color: FightClubColors.centerText,
                          fontSize: 10,
                          height: 2.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ControlsWidget(
              defendingBodyPart: defendingBodyPart,
              attackingBodyPart: attackingBodyPart,
              selectAttackingBodyPart: _selectAttackingBodyPart,
              selectDefendingBodyPart: _selectDefendingBodyPart,
            ),
            SizedBox(height: 14),
            GoButtonWidget(
              text: (yourLives == 0 || enemiesLives == 0)
                  ? "start new game"
                  : "go",
              onTap: pressedGo,
              color: _getColor(),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Color _getColor() {
    if (yourLives == 0 || enemiesLives == 0) {
      return FightClubColors.blackButton;
    } else if (defendingBodyPart == null || attackingBodyPart == null) {
      return FightClubColors.greyButton;
    } else {
      return FightClubColors.blackButton;
    }
  }

  void pressedGo() {
    if (enemiesLives == 0 || yourLives == 0) {
      setState(() {
        centerText = '';
        enemiesLives = maxLives;
        yourLives = maxLives;
      });
    } else if (defendingBodyPart != null && attackingBodyPart != null) {
      setState(() {
        final bool enemyLoseLife = attackingBodyPart != whatEnemyDefends;
        final bool yourLoseLife = defendingBodyPart != whatEnemyAttacks;

        if(enemyLoseLife && yourLoseLife){
          centerText = "You hit enemy’s ${attackingBodyPart!.name} \n Enemy hit your ${defendingBodyPart!.name}";
        }

        if(!enemyLoseLife && !yourLoseLife){
          centerText = "Enemy’s attack was blocked \n Your attack was blocked";
        }

        if(enemyLoseLife && !yourLoseLife){
          centerText = "Enemy’s attack was blocked \n You hit enemy’s ${attackingBodyPart!.name}";
        }
        if(!enemyLoseLife && yourLoseLife){
          centerText = "Your attack was blocked \n Enemy hit your ${defendingBodyPart!.name}";
        }

        if (enemyLoseLife) {
          //centerText = "Enemy’s attack was blocked \n You hit enemy’s ${attackingBodyPart!.name}";
          enemiesLives -= 1;
        }
        if (yourLoseLife) {
          //centerText = "Your attack was blocked \n Enemy hit your ${defendingBodyPart!.name}";
          yourLives -= 1;
        }


        whatEnemyDefends = BodyPart.random();
        whatEnemyAttacks = BodyPart.random();

        defendingBodyPart = null;
        attackingBodyPart = null;

        if (enemiesLives == 0 || yourLives == 0) {
          centerText = _getTextFinish();
        }
      });
    }
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    if (enemiesLives == 0 || yourLives == 0) {
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttackingBodyPart(final BodyPart value) {
    if (enemiesLives == 0 || yourLives == 0) {
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }

  String _getTextFinish() {
    if (yourLives > enemiesLives) {
      return 'You won';
    } else if (yourLives < enemiesLives) {
      return 'You lost';
    } else {
      return 'Draw';
    }
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlsWidget({
    Key? key,
    required this.defendingBodyPart,
    required this.attackingBodyPart,
    required this.selectDefendingBodyPart,
    required this.selectAttackingBodyPart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Text(
                'defend'.toUpperCase(),
                style: TextStyle(color: FightClubColors.darkGreyText),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: defendingBodyPart == BodyPart.torso,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingBodyPart == BodyPart.legs,
                bodyPartSetter: selectDefendingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                'attack'.toUpperCase(),
                style: TextStyle(color: FightClubColors.darkGreyText),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attackingBodyPart == BodyPart.head,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: attackingBodyPart == BodyPart.torso,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attackingBodyPart == BodyPart.legs,
                bodyPartSetter: selectAttackingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }
}

class GoButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const GoButtonWidget({
    Key? key,
    required this.text,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 40,
          child: ColoredBox(
            color: color,
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: TextStyle(
                  color: FightClubColors.whiteText,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemiesLivesCount;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemiesLivesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ColoredBox(
                  color: Colors.white,
                  child: SizedBox(height: 160),
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: const Color(0xFFC5D1EA),
                  child: SizedBox(height: 160),
                ),
              ),
            ],
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LivesWidget(
                  overallLivesCount: maxLivesCount,
                  currentLivesCount: yourLivesCount,
                ),
                Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'You',
                      style: TextStyle(color: FightClubColors.darkGreyText),
                    ),
                    const SizedBox(height: 12),
                    Image.asset(FightClubImages.youAvatar,
                        height: 92, width: 92)
                    // ColoredBox(
                    //   color: Colors.red,
                    //   child: SizedBox(height: 92, width: 92),
                    // )
                  ],
                ),
                Center(
                  child: ColoredBox(
                    color: Colors.green,
                    child: SizedBox(height: 44, width: 44),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Enemy',
                      style: TextStyle(color: FightClubColors.darkGreyText),
                    ),
                    const SizedBox(height: 12),
                    Image.asset(FightClubImages.enemyAvatar,
                        height: 92, width: 92)
                  ],
                ),
                LivesWidget(
                  overallLivesCount: maxLivesCount,
                  currentLivesCount: enemiesLivesCount,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;

  const LivesWidget({
    Key? key,
    required this.overallLivesCount,
    required this.currentLivesCount,
  })  : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 27.0),
      child: Column(
        children: List.generate(
          overallLivesCount,
          (index) {
            if (index < currentLivesCount) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Image.asset(
                  FightClubIcons.heartFull,
                  width: 18,
                  height: 18,
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Image.asset(
                  FightClubIcons.heartEmpty,
                  width: 18,
                  height: 18,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._('head');
  static const torso = BodyPart._('torso');
  static const legs = BodyPart._('legs');

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    Key? key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: selected
              ? FightClubColors.blueButton
              : FightClubColors.greyButton,
          child: Center(
            child: Text(
              bodyPart.name.toUpperCase(),
              style: TextStyle(
                  color: selected
                      ? FightClubColors.whiteText
                      : FightClubColors.darkGreyText),
            ),
          ),
        ),
      ),
    );
  }
}
