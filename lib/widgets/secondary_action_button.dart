import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

class SecondaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SecondaryActionButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: FightClubColors.darkGreyText,
          ),
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: FightClubColors.darkGreyText,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
