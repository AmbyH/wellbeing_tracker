import 'package:flutter/material.dart';
import 'models/user_daily_data.dart';

class MeasurementEntryPage extends StatefulWidget {
  const MeasurementEntryPage({super.key});

  @override
  MeasurementEntryPageState createState() => MeasurementEntryPageState();
}

class MeasurementEntryPageState extends State<MeasurementEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _bodyFatController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _bodyFatController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    double height = double.tryParse(_heightController.text) ?? 0.0;
    double bodyFat = double.tryParse(_bodyFatController.text) ?? 0.0;

    double bmi = (height > 0) ? weight / ((height / 100) * (height / 100)) : 0.0;

    DateTime today = DateTime.now();
    UserDailyData data = await UserDailyData.load(date: today);
    data.weightKg = weight;
    data.heightCm = height;
    data.bmi = bmi;
    data.bodyFatPercent = bodyFat;
    data.lastMeasurementTime = DateTime.now();
  await data.save(date: today);

  if (!mounted) return;
  Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Measurement')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _bodyFatController,
                decoration: InputDecoration(labelText: 'Body Fat (%)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _save();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
