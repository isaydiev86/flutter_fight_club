import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24.0),
              child: Text(
                "Statistics",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: FightClubColors.darkGreyText, fontSize: 24),
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SecondaryActionButton(text: "Back", onTap: (){
                Navigator.of(context).pop();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
