import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late TextEditingController _mealNoteController;
  late TextEditingController _addNoteController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<MealProvider>(context, listen: false);
    _mealNoteController = TextEditingController(text: provider.mealNote);
    _addNoteController = TextEditingController(text: provider.additionalNote);
  }

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Daily Eating Notes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text("Thursday, September 25, 2026", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),

          const Text("How was your day?", style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Good', 'Okay', 'Not Good'].map((mood) {
              final selected = mealProvider.userMood == mood;
              return ChoiceChip(
                label: Text(mood),
                selected: selected,
                selectedColor: Colors.green.shade100,
                onSelected: (_) => mealProvider.setMood(mood),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _mealNoteController,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Meal Notes', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _addNoteController,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Additional Note', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 45),
            ),
            onPressed: () {
              mealProvider.saveNotes(_mealNoteController.text, _addNoteController.text);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notes Log Saved!')),
              );
            },
            child: const Text('Save Log', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mealNoteController.dispose();
    _addNoteController.dispose();
    super.dispose();
  }
}