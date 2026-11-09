import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  // Local screen state management with setState()
  bool _isAddingMeal = false;

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Meal Plan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Thursday, September 25, 2026",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue.shade50,
              foregroundColor: Colors.lightBlue.shade800,
              minimumSize: const Size(double.infinity, 45),
            ),
            onPressed: () {
              // Local state trigger demonstration
              setState(() {
                _isAddingMeal = !_isAddingMeal;
              });
            },
            icon: const Icon(Icons.add),
            label: Text(_isAddingMeal ? "Close Add Form" : "Add New Meal"),
          ),
          const SizedBox(height: 16),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: mealProvider.meals.length,
            itemBuilder: (context, index) {
              final meal = mealProvider.meals[index];
              return Card(
                color: meal.isCompleted ? Colors.green.shade50 : Colors.white,
                child: CheckboxListTile(
                  title: Text(
                    meal.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(meal.detail),
                  value: meal.isCompleted,
                  activeColor: Colors.green,
                  onChanged: (bool? value) {
                    mealProvider.toggleMealCompletion(meal.id);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
