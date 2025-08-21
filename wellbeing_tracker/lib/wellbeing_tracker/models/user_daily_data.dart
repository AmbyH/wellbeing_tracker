import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserDailyData {
  int caloriesEaten;
  int caloriesBurned;
  int caloriesRemaining;
  int carbs;
  int protein;
  int fat;
  double waterMl;
  double weightKg;
  double heightCm;
  double bmi;
  double bodyFatPercent;
  DateTime lastDrinkTime;
  DateTime lastMeasurementTime;

  UserDailyData({
    this.caloriesEaten = 0,
    this.caloriesBurned = 0,
    this.caloriesRemaining = 0,
    this.carbs = 0,
    this.protein = 0,
    this.fat = 0,
    this.waterMl = 0.0,
    this.weightKg = 0.0,
    this.heightCm = 0.0,
    this.bmi = 0.0,
    this.bodyFatPercent = 0.0,
    DateTime? lastDrinkTime,
    DateTime? lastMeasurementTime,
  })  : lastDrinkTime = lastDrinkTime ?? DateTime.now(),
        lastMeasurementTime = lastMeasurementTime ?? DateTime.now();

  Map<String, dynamic> toMap() => {
        'caloriesEaten': caloriesEaten,
        'caloriesBurned': caloriesBurned,
        'caloriesRemaining': caloriesRemaining,
        'carbs': carbs,
        'protein': protein,
        'fat': fat,
        'waterMl': waterMl,
        'weightKg': weightKg,
        'heightCm': heightCm,
        'bmi': bmi,
        'bodyFatPercent': bodyFatPercent,
        'lastDrinkTime': lastDrinkTime.toIso8601String(),
        'lastMeasurementTime': lastMeasurementTime.toIso8601String(),
      };

  static UserDailyData fromMap(Map<String, dynamic> map) => UserDailyData(
        caloriesEaten: map['caloriesEaten'] ?? 0,
        caloriesBurned: map['caloriesBurned'] ?? 0,
        caloriesRemaining: map['caloriesRemaining'] ?? 0,
        carbs: map['carbs'] ?? 0,
        protein: map['protein'] ?? 0,
        fat: map['fat'] ?? 0,
        waterMl: (map['waterMl'] ?? 0.0).toDouble(),
        weightKg: (map['weightKg'] ?? 0.0).toDouble(),
        heightCm: (map['heightCm'] ?? 0.0).toDouble(),
        bmi: (map['bmi'] ?? 0.0).toDouble(),
        bodyFatPercent: (map['bodyFatPercent'] ?? 0.0).toDouble(),
        lastDrinkTime: map['lastDrinkTime'] != null
            ? DateTime.parse(map['lastDrinkTime'])
            : DateTime.now(),
        lastMeasurementTime: map['lastMeasurementTime'] != null
            ? DateTime.parse(map['lastMeasurementTime'])
            : DateTime.now(),
      );

  Future<void> save({DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _keyForDate(date ?? DateTime.now());
    await prefs.setString(key, jsonEncode(toMap()));
  }

  static Future<UserDailyData> load({DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _keyForDate(date ?? DateTime.now());
    final jsonStr = prefs.getString(key);
    if (jsonStr == null) return UserDailyData();
    final map = jsonDecode(jsonStr) as Map<String, dynamic>;
    return UserDailyData.fromMap(map);
  }

  static String _keyForDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return 'user_daily_data_$y-$m-$d';
  }
}