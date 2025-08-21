import 'package:flutter/material.dart';
import 'food_entry_page.dart';
import 'measurement_entry_page.dart';
import 'water_entry_page.dart';
import 'exercise_entry_page.dart';

class NewEntryActionPage extends StatelessWidget {
  const NewEntryActionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Entry')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: 1,
            shrinkWrap: true,
            children: [
              _QuadrantButton(
                icon: Icons.fastfood,
                label: 'Food',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FoodEntryPage())),
              ),
              _QuadrantButton(
                icon: Icons.monitor_weight,
                label: 'Measurement',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MeasurementEntryPage())),
              ),
              _QuadrantButton(
                icon: Icons.local_drink,
                label: 'Water',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WaterEntryPage())),
              ),
              _QuadrantButton(
                icon: Icons.fitness_center,
                label: 'Exercise',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ExerciseEntryPage())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuadrantButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuadrantButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      shape: SquircleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        customBorder: SquircleBorder(borderRadius: BorderRadius.circular(24)),
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

class SquircleBorder extends ShapeBorder {
  final BorderRadius borderRadius;
  final BorderSide side;
  final double opacity = 0.30; // Changed to 30%
  const SquircleBorder({
    this.borderRadius = BorderRadius.zero,
    this.side = BorderSide.none,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  ShapeBorder scale(double t) => SquircleBorder(
        borderRadius: borderRadius * t,
        side: side.scale(t),
      );

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final r = borderRadius.resolve(textDirection);
    return Path()
      ..addRRect(RRect.fromRectAndCorners(
        rect,
        topLeft: r.topLeft,
        topRight: r.topRight,
        bottomLeft: r.bottomLeft,
        bottomRight: r.bottomRight,
      ));
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final r = borderRadius.resolve(textDirection);
    return Path()
      ..addRRect(RRect.fromRectAndCorners(
        rect,
        topLeft: r.topLeft,
        topRight: r.topRight,
        bottomLeft: r.bottomLeft,
        bottomRight: r.bottomRight,
      ));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side == BorderSide.none || side.width == 0) return;
    final r = borderRadius.resolve(textDirection);
    final rrect = RRect.fromRectAndCorners(
      rect.deflate(side.width / 2),
      topLeft: r.topLeft,
      topRight: r.topRight,
      bottomLeft: r.bottomLeft,
      bottomRight: r.bottomRight,
    );
    final paint = side.toPaint();
    paint.color = paint.color.withAlpha((opacity * 255).toInt()); // Apply opacity
    canvas.drawRRect(rrect, paint);
  }

  @override
  ShapeBorder lerpFrom(ShapeBorder? a, double t) => this;
  @override
  ShapeBorder lerpTo(ShapeBorder? b, double t) => this;
}
