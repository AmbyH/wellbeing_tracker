import 'package:flutter/material.dart';
import 'models/user_daily_data.dart';

class FoodEntryPage extends StatefulWidget {
  const FoodEntryPage({super.key});

  @override
  FoodEntryPageState createState() => FoodEntryPageState();
}

class FoodEntryPageState extends State<FoodEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _caloriesController = TextEditingController();
  final _carbsController = TextEditingController();
  final _proteinController = TextEditingController();
  final _fatController = TextEditingController();

  Future<void> _save() async {
    int calories = int.tryParse(_caloriesController.text) ?? 0;
    int carbs = int.tryParse(_carbsController.text) ?? 0;
    int protein = int.tryParse(_proteinController.text) ?? 0;
    int fat = int.tryParse(_fatController.text) ?? 0;

    DateTime today = DateTime.now();
    UserDailyData data = await UserDailyData.load(date: today);

    data.caloriesEaten += calories;
    data.carbs += carbs;
    data.protein += protein;
    data.fat += fat;

    data.caloriesRemaining = (data.caloriesRemaining - calories);

  await data.save(date: today);

  if (!mounted) return;
  Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Food')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _caloriesController, decoration: InputDecoration(labelText: 'Calories (kcal)')),
              TextFormField(controller: _carbsController, decoration: InputDecoration(labelText: 'Carbs (g)')),
              TextFormField(controller: _proteinController, decoration: InputDecoration(labelText: 'Protein (g)')),
              TextFormField(controller: _fatController, decoration: InputDecoration(labelText: 'Fat (g)')),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: Text('Save')),
            ],
          ),
        ),
      ),
    );
  }
}
