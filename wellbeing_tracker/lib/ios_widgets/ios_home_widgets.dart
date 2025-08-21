import 'package:flutter/material.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';

/// This file provides iOS-style home screen widgets for Wellbeing Tracker.
/// You can use these widgets in an App Extension or as part of your app's main screen.
/// The UI is kept similar to the main app for consistency.

class IOSHomeWidgets extends StatelessWidget {
  final VoidCallback onFoodTap;
  final VoidCallback onWaterTap;
  final VoidCallback onMeasurementTap;
  final VoidCallback onExerciseTap;

  const IOSHomeWidgets({
    super.key,
    required this.onFoodTap,
    required this.onWaterTap,
    required this.onMeasurementTap,
    required this.onExerciseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        childAspectRatio: 1,
        shrinkWrap: true,
        children: [
          _IOSWidgetButton(
            icon: Icons.fastfood,
            label: 'Food',
            onTap: onFoodTap,
          ),
          _IOSWidgetButton(
            icon: Icons.local_drink,
            label: 'Water',
            onTap: onWaterTap,
          ),
          _IOSWidgetButton(
            icon: Icons.monitor_weight,
            label: 'Measurement',
            onTap: onMeasurementTap,
          ),
          _IOSWidgetButton(
            icon: Icons.fitness_center,
            label: 'Exercise',
            onTap: onExerciseTap,
          ),
        ],
      ),
    );
  }
}

class _IOSWidgetButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _IOSWidgetButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
              SizedBox(height: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> updateIOSHomeWidget({
  required int calories,
  required int waterMl,
  required int steps,
  required int carbs,
  required int protein,
  required int fat,
}) async {
  await WidgetKit.setItem('calories', calories, 'group.com.wellbeingtracker');
  await WidgetKit.setItem('waterMl', waterMl, 'group.com.wellbeingtracker');
  await WidgetKit.setItem('steps', steps, 'group.com.wellbeingtracker');
  await WidgetKit.setItem('carbs', carbs, 'group.com.wellbeingtracker');
  await WidgetKit.setItem('protein', protein, 'group.com.wellbeingtracker');
  await WidgetKit.setItem('fat', fat, 'group.com.wellbeingtracker');
  WidgetKit.reloadAllTimelines();
}

class IOSHomeWidgetPreview extends StatelessWidget {
  final int calories;
  final int waterMl;
  final int steps;
  final int carbs;
  final int protein;
  final int fat;

  const IOSHomeWidgetPreview({
    super.key,
    required this.calories,
    required this.waterMl,
    required this.steps,
    required this.carbs,
    required this.protein,
    required this.fat,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          shrinkWrap: true,
          childAspectRatio: 1.2,
          children: [
            _WidgetTile(icon: Icons.fastfood, label: 'Food', value: '$calories kcal'),
            _WidgetTile(icon: Icons.local_drink, label: 'Water', value: '$waterMl ml'),
            _WidgetTile(icon: Icons.directions_walk, label: 'Steps', value: '$steps'),
            _WidgetTile(icon: Icons.monitor_weight, label: 'Macros', value: '$carbs/$protein/$fat'),
          ],
        ),
      ),
    );
  }
}

class _WidgetTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WidgetTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 1.5),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
            SizedBox(height: 8),
            Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.primary)),
          ],
        ),
      ),
    );
  }
}
