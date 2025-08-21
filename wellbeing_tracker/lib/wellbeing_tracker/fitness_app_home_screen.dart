import 'package:wellbeing_tracker/wellbeing_tracker/models/tab_icon_data.dart';
import 'package:flutter/material.dart';
import 'fitness_app_theme.dart';
import 'my_diary/my_diary_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  const FitnessAppHomeScreen({super.key});

  @override
  FitnessAppHomeScreenState createState() => FitnessAppHomeScreenState();
}

class FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container();

  @override
  void initState() {
  animationController = AnimationController(
    duration: const Duration(milliseconds: 600), vsync: this);
  tabBody = MyDiaryScreen(animationController: animationController);
  super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: tabBody,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }


}
