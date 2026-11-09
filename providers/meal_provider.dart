import 'package:flutter/material.dart';
import '../models/meal_model.dart';

// Requirement 5: Provider State Management
class MealProvider extends ChangeNotifier {
  final List<MealItem> _meals = [
    MealItem(
      id: 1,
      name: "Breakfast",
      detail: "Egg + Rice + Banana",
      time: "7:00 AM",
      isCompleted: true,
      isReminderOn: true,
    ),
    MealItem(
      id: 2,
      name: "Morning Snack",
      detail: "Apple",
      time: "10:00 AM",
      isCompleted: true,
      isReminderOn: false,
    ),
    MealItem(
      id: 3,
      name: "Lunch",
      detail: "Chicken + Vegetables",
      time: "12:30 PM",
      isCompleted: true,
      isReminderOn: true,
    ),
    MealItem(
      id: 4,
      name: "Afternoon Snack",
      detail: "Bread + Fruit",
      time: "3:30 PM",
      isCompleted: false,
      isReminderOn: false,
    ),
    MealItem(
      id: 5,
      name: "Dinner",
      detail: "Fish + Rice",
      time: "7:00 PM",
      isCompleted: false,
      isReminderOn: true,
    ),
  ];

  String _userMood = 'Good';
  String _mealNote =
      'I enjoyed my lunch today. It was delicious and kept me full for the rest of the day.';
  String _additionalNote = 'Stay consistent and keep choosing healthy foods!';

  List<MealItem> get meals => _meals;
  String get userMood => _userMood;
  String get mealNote => _mealNote;
  String get additionalNote => _additionalNote;

  int get completedCount => _meals.where((m) => m.isCompleted).length;
  double get progressPercentage =>
      _meals.isEmpty ? 0 : completedCount / _meals.length;

  void toggleMealCompletion(int id) {
    final index = _meals.indexWhere((m) => m.id == id);
    if (index != -1) {
      _meals[index].isCompleted = !_meals[index].isCompleted;
      notifyListeners();
    }
  }

  void toggleReminder(int id) {
    final index = _meals.indexWhere((m) => m.id == id);
    if (index != -1) {
      _meals[index].isReminderOn = !_meals[index].isReminderOn;
      notifyListeners();
    }
  }

  void setMood(String mood) {
    _userMood = mood;
    notifyListeners();
  }

  void saveNotes(String mealNote, String addNote) {
    _mealNote = mealNote;
    _additionalNote = addNote;
    notifyListeners();
  }
}
