import 'package:wellbeing_tracker/wellbeing_tracker/fitness_app_home_screen.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
  imagePath: 'assets/wellbeing_tracker/fitness_app.png',
      navigateScreen: FitnessAppHomeScreen(),
    ),
  ];
}
