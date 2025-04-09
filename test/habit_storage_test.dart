import 'package:daily/services/habit_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daily/models/habit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Показывается расписание', () async {
    SharedPreferences.setMockInitialValues({});

    final habits = [
      Habit(id: 1, title: 'write code', isCompleted: false),
      Habit(id: 2, title: 'eat burger', isCompleted: true),
    ];

    await HabitStorage.saveHabits(habits);
    final loaded = await HabitStorage.loadHabits();

    expect(loaded.length, 2);
    expect(loaded[0].id, 1);
    expect(loaded[0].title, 'write code');
    expect(loaded[1].isCompleted, true);
  });
}
