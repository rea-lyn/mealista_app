import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Meal Reminders",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Get notified for your planned meals.",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mealProvider.meals.length,
            itemBuilder: (context, index) {
              final meal = mealProvider.meals[index];
              return SwitchListTile(
                title: Text(
                  meal.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(meal.time),
                value: meal.isReminderOn,
                activeColor: Colors.green,
                onChanged: (bool value) {
                  mealProvider.toggleReminder(meal.id);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
