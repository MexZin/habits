import 'package:daily/models/habit.dart';
import 'package:daily/services/habit_storage.dart';
import 'package:flutter/material.dart';

class HabitProvider extends ChangeNotifier {
  final List<Habit> _habits = [];

  List<Habit> get habits => _habits;

  void addHabit(Habit habit) {
    _habits.add(habit);
    HabitStorage.saveHabits(_habits);
    notifyListeners();
  }

  void removeHabit(int id) {
    _habits.removeWhere((habit) => habit.id == id);
    HabitStorage.saveHabits(_habits);
    notifyListeners();
  }

  void toggleHabit(int id) {
    final index = _habits.indexWhere((habit) => habit.id == id);
    if (index != -1) {
      final habit = _habits[index];
      _habits[index] = Habit(
        id: habit.id,
        title: habit.title,
        isCompleted: !habit.isCompleted,
      );
      HabitStorage.saveHabits(_habits);
      notifyListeners();
    }
  }

  void updateHabit(Habit updatedHabit) {
    final index = _habits.indexWhere((h) => h.id == updatedHabit.id);
    if (index != -1) {
      _habits[index] = updatedHabit;
      HabitStorage.saveHabits(_habits);
      notifyListeners();
    }
  }

  Future<void> loadHabits() async {
    final loaded = await HabitStorage.loadHabits(); // ✅ загружаем снаружи
    _habits.clear();
    _habits.addAll(loaded);
    notifyListeners();
  }
}
