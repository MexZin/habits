import 'dart:convert';
import 'package:daily/models/habit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitStorage {
  static const _key = 'habits';

  static Future<void> saveHabits(List<Habit> habits) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = habits.map((habit) => habit.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }

  static Future<List<Habit>> loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);

    if (data == null) return [];

    final decoded = jsonDecode(data) as List<dynamic>;
    return decoded.map((e) => Habit.fromJson(e)).toList();
  }
}
