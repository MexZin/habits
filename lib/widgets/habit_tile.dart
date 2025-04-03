import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import '../screens/edit_habit_screen.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;

  const HabitTile({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);

    return Slidable(
      key: ValueKey(habit.id),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: (_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditHabitScreen(habit: habit),
                ),
              );
            },
            backgroundColor: Colors.blue,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, color: Colors.white),
                  SizedBox(height: 4),
                  Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomSlidableAction(
            onPressed: (_) {
              habitProvider.removeHabit(habit.id);
            },
            backgroundColor: Colors.red,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  SizedBox(height: 4),
                  Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      child: SizedBox(
        height: 80,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: habit.isCompleted,
                onChanged: (_) {
                  habitProvider.toggleHabit(habit.id);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(color: Colors.white70),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  habit.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                    color: habit.isCompleted
                        ? Color.fromARGB(108, 215, 215, 215)
                        : Color.fromARGB(255, 255, 255, 255),
                    decoration: habit.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
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
