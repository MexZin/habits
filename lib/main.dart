import 'package:daily/providers/habit_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final habitProvider = HabitProvider();
  await habitProvider.loadHabits();

  runApp(
    ChangeNotifierProvider.value(
      value: habitProvider,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Habits',
      theme: ThemeData(
        brightness: Brightness.dark,
        //scaffoldBackgroundColor: Color(0xFF1C1B33),
        fontFamily: 'SansSerif',
        colorSchemeSeed: Color(0xFF6C63FF),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
