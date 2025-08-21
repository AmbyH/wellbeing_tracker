import 'package:flutter/material.dart';
import 'models/user_daily_data.dart';

class WaterEntryPage extends StatefulWidget {
  const WaterEntryPage({super.key});

  @override
  @override
  WaterEntryPageState createState() => WaterEntryPageState();
}

class WaterEntryPageState extends State<WaterEntryPage> {
  double _water = 10.0; //min value

  Future<void> _save() async {
    DateTime today = DateTime.now();
    UserDailyData data = await UserDailyData.load(date: today);
    data.waterMl += _water; 
    data.lastDrinkTime = DateTime.now();
    await data.save(date: today);
  if (!mounted) return;
  Navigator.pop(context);
  }
  WaterEntryPageState createState() => WaterEntryPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Water')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Water: ${_water.round()} ml', style: TextStyle(fontSize: 20)),
            Slider(
              value: _water,
              min: 10,
              max: 1000,
              divisions: 99,
              label: _water.round().toString(),
              onChanged: (v) => setState(() => _water = v),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _save, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
