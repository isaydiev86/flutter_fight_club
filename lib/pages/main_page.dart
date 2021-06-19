import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:flutter_fight_club/widgets/fight_result_widget.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return _MainPageContent();
  }
}

class _MainPageContent extends StatelessWidget {
  const _MainPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Center(
                child: Text(
              "The\nFight\nClub".toUpperCase(),
              style: TextStyle(
                  fontSize: 30,
                  color: FightClubColors.darkGreyText,
                  height: 1.5),
              textAlign: TextAlign.center,
            )),
            Expanded(child: SizedBox()),
            FutureBuilder<String?>(
              future: SharedPreferences.getInstance().then(
                      (sharedPreferences) =>
                      sharedPreferences.getString("last_fight_result")),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const SizedBox();
                }
                return Center(
                  child: Column(
                    children: [
                      Text(
                        "Last fight result",
                        style: TextStyle(
                            color: FightClubColors.darkGreyText, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      FightResultWidget(fightResult: _result(snapshot.data)),
                    ],
                  ),
                );
              },
            ),
            Expanded(child: SizedBox()),
            SecondaryActionButton(
                text: "Statistics",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StatisticsPage(),
                    ),
                  );
                }),
            const SizedBox(height: 12),
            ActionButton(
              text: "Start".toUpperCase(),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FightPage(),
                  ),
                );
              },
              color: FightClubColors.blackButton,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  FightResult _result(String? data) {
    if(data == "won"){
      return FightResult.won;
    } else if(data == "lost"){
      return FightResult.lost;
    } else if(data == "draw"){
      return FightResult.draw;
    } else{
      return FightResult.won;
    }
  }

}
