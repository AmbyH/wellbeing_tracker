import 'package:flutter/material.dart';
import 'models/user_daily_data.dart';

class DietSummaryScreen extends StatefulWidget {
  final AnimationController? animationController;
  const DietSummaryScreen({super.key, this.animationController});

  @override
  DietSummaryScreenState createState() => DietSummaryScreenState();
}

class DietSummaryScreenState extends State<DietSummaryScreen> with TickerProviderStateMixin {
  List<MapEntry<DateTime, UserDailyData>> history = [];
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    List<MapEntry<DateTime, UserDailyData>> temp = [];
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime date = today.subtract(Duration(days: i));
      UserDailyData data = await UserDailyData.load(date: date);
      temp.add(MapEntry(date, data));
    }
    _controllers = List.generate(temp.length, (i) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
      );
    });
    _animations = _controllers
        .map((controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: controller,
                  curve: Curves.easeOutCubic),
            ))
        .toList();

    setState(() {
      history = temp;
    });

    // Staggered animation
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: 120 * i), () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    if (_controllers.isNotEmpty) {
      for (final c in _controllers) {
        c.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diet Summary')),
      body: history.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final entry = history[index];
                final date = entry.key;
                final data = entry.value;
                return AnimatedBuilder(
                  animation: _animations[index],
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 40 * (1 - _animations[index].value)),
                      child: Opacity(
                        opacity: _animations[index].value,
                        child: child,
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Calories Eaten: ${data.caloriesEaten}"),
                          Text("Calories Burned: ${data.caloriesBurned}"),
                          Text("Carbs: ${data.carbs}g, Protein: ${data.protein}g, Fat: ${data.fat}g"),
                          Text("Water: ${data.waterMl} ml"),
                          Text("Body Mass: ${data.weightKg} kg"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
