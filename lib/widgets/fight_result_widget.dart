import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult? fightResult;
  const FightResultWidget({Key? key, required this.fightResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ColoredBox(
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white, const Color(0xFFC5D1EA)])),
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: const Color(0xFFC5D1EA),
                ),
              ),
            ],
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                  ],
                ),
                Center(
                  child: Container(
                    height: 44,
                    width: 88,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.0),
                          shape: BoxShape.rectangle,
                          color: _resultColor(fightResult!.result)),
                      child: Center(
                        child: Text(
                          fightResult!.result,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _resultColor(String data) {
    if(data == "won"){
      return const Color(0xFF038800);
    } else if(data == "lost"){
      return const Color(0xFFEA2C2C);
    } else if(data == "draw"){
      return const Color(0xFF1C79CE);
    }
    return const Color(0xFF1C79CE);
  }
}
