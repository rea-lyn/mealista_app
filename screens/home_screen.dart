import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Good Morning!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text("Here's your eating plan for today.", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),

          // Progress Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.calendar_month, color: Colors.green, size: 18),
                      SizedBox(width: 8),
                      Text('Thursday, September 25, 2026', style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: mealProvider.progressPercentage,
                          strokeWidth: 10,
                          backgroundColor: Colors.grey.shade200,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        '${(mealProvider.progressPercentage * 100).toInt()}%',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Meal Plan Progress', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${mealProvider.completedCount} of ${mealProvider.meals.length} meals completed', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Text("Today's Meals", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mealProvider.meals.length,
            itemBuilder: (context, index) {
              final meal = mealProvider.meals[index];
              return Card(
                child: ListTile(
                  title: Text(meal.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(meal.detail),
                  trailing: IconButton(
                    icon: Icon(
                      meal.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: meal.isCompleted ? Colors.green : Colors.grey,
                    ),
                    onPressed: () => mealProvider.toggleMealCompletion(meal.id),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}