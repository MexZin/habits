// import 'package:daily/models/habit.dart';
import 'package:daily/providers/habit_provider.dart';
import 'package:daily/screens/add_habit_screen.dart';
// import 'package:daily/screens/edit_habit_screen.dart';
import 'package:daily/screens/quote_screen.dart';
import 'package:daily/widgets/habit_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily/widgets/app_background.dart';
// import 'package:daily/widgets/animated_fade_in.dart';
import 'package:daily/widgets/slide_fade_in.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    final habits = habitProvider.habits;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 16),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: AppBar(
            title: const Text(
              'My Habits',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.star_border_rounded,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const QuoteScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: AppBackground(
        child: Padding(
          padding: EdgeInsets.only(
            top: kToolbarHeight + 16,
            bottom: 16,
          ),
          child: habits.isEmpty
              ? const Center(
                  child: Text(
                    "You don't have habits yet",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  itemCount: habits.length,
                  itemBuilder: (context, index) {
                    final habit = habits[index];

                    return SlideFadeIn(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 0.08),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: HabitTile(habit: habit),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddHabitScreen(),
            ),
          );
        },
        label: const Text(
          'Add Habit',
          style: TextStyle(fontSize: 18),
        ),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
