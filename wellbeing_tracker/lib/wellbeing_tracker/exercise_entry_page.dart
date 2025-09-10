import 'package:flutter/material.dart';
import 'models/user_daily_data.dart'; 

class ExerciseEntryPage extends StatefulWidget {
  const ExerciseEntryPage({super.key});

  @override
  ExerciseEntryPageState createState() => ExerciseEntryPageState();
}

class ExerciseEntryPageState extends State<ExerciseEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _minutesController = TextEditingController();
  final _notesController = TextEditingController();
  final _otherCaloriesController = TextEditingController();

  String? _selectedExercise;
  final List<String> _exerciseOptions = [
    'Running',
    'Cycling',
    'Swimming',
    'Walking',
    'Yoga',
    'Other'
  ];

  bool get isOtherSelected => _selectedExercise == 'Other';

  //change calorie equations
  double _caloriesBurned(String exercise, int minutes) {
    switch (exercise) {
      case 'Running':
        return minutes * 10; 
      case 'Cycling':
        return minutes * 8; 
      case 'Swimming':
        return minutes * 7; 
      case 'Walking':
        return minutes * 4;
      case 'Yoga':
        return minutes * 3; 
      default:
        return 0;
    }
  }

  Future<void> _save() async {
    int minutes = int.tryParse(_minutesController.text) ?? 0;
    int newCalories;
    if (isOtherSelected) {
      newCalories = int.tryParse(_otherCaloriesController.text) ?? 0;
    } else if (_selectedExercise != null) {
      newCalories = _caloriesBurned(_selectedExercise!, minutes).toInt();
    } else {
      newCalories = 0;
    }

    DateTime today = DateTime.now();
    UserDailyData data = await UserDailyData.load(date: today);
    data.caloriesBurned += newCalories;

  await data.save(date: today);

  if (!mounted) return;
  Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Exercise')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Exercise'),
                initialValue: _selectedExercise,
                items: _exerciseOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedExercise = val;
                  });
                },
                validator: (val) => val == null || val.isEmpty ? 'Please select an exercise' : null,
              ),
              if (isOtherSelected)
                TextFormField(
                  controller: _otherCaloriesController,
                  decoration: InputDecoration(labelText: 'Calories burned'),
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (isOtherSelected && (val == null || val.isEmpty)) {
                      return 'Please enter calories burned';
                    }
                    return null;
                  },
                ),
              TextFormField(
                controller: _minutesController,
                decoration: InputDecoration(labelText: 'Minutes'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'Notes'),
              ),
              SizedBox(height: 20),
              if (!isOtherSelected && _selectedExercise != null && _minutesController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Calories burned: ${_caloriesBurned(_selectedExercise!, int.tryParse(_minutesController.text) ?? 0).toInt()}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ElevatedButton(child: Text('Save'), onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _save();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
