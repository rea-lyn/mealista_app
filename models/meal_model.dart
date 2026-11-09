class MealItem {
  final int id;
  final String name;
  final String detail;
  final String time;
  bool isCompleted;
  bool isReminderOn;

  MealItem({
    required this.id,
    required this.name,
    required this.detail,
    required this.time,
    this.isCompleted = false,
    this.isReminderOn = true,
  });
}
