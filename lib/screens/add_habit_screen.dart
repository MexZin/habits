import 'package:daily/models/habit.dart';
import 'package:daily/providers/habit_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily/widgets/app_background.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final TextEditingController _controller = TextEditingController();

  void _addHabit() {
    final inputText = _controller.text.trim();

    if (inputText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter habit's name"),
        ),
      );
      return;
    }

    final habit = Habit(
      id: DateTime.now().millisecondsSinceEpoch,
      title: inputText,
      isCompleted: false,
    );

    Provider.of<HabitProvider>(context, listen: false).addHabit(habit);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Add Habit'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AppBackground(
        child: Padding(
          padding: EdgeInsets.only(
            top: kToolbarHeight + 24,
            left: 24,
            right: 24,
            bottom: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter new habit',
                  hintStyle: TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: Color.fromARGB(30, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addHabit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3A0CA3),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 231, 231, 231),
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
