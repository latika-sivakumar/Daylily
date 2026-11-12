import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/goal.dart';
import '../providers/goals_provider.dart';

class AddGoalScreen extends ConsumerStatefulWidget {
  const AddGoalScreen({super.key});

  @override
  ConsumerState<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends ConsumerState<AddGoalScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final stepController = TextEditingController();

  DateTime targetDate = DateTime.now().add(const Duration(days: 30));

  final List<GoalStep> steps = [];

  void addStep() {
    final stepTitle = stepController.text.trim();

    if (stepTitle.isEmpty) return;

    setState(() {
      steps.add(
        GoalStep(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: stepTitle,
        ),
      );
    });

    stepController.clear();
  }

  Future<void> selectTargetDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: targetDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        targetDate = selectedDate;
      });
    }
  }

  void saveGoal() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a goal title 🌸')),
      );
      return;
    }

    ref
        .read(goalsProvider.notifier)
        .addGoal(
          title: title,
          description: description,
          targetDate: targetDate,
          steps: steps,
        );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    stepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create a Goal ✨')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What do you want to achieve?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Goal title',
                hintText: 'Example: Learn Flutter',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Describe your goal...',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Target date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            OutlinedButton.icon(
              onPressed: selectTargetDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(
                '${targetDate.day}/${targetDate.month}/${targetDate.year}',
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Small steps towards your goal 🌱',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: stepController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a small step',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                IconButton(
                  onPressed: addStep,
                  icon: const Icon(Icons.add_circle),
                  color: const Color(0xFF9B7AE8),
                ),
              ],
            ),

            const SizedBox(height: 12),

            ...steps.map(
              (step) => ListTile(
                leading: const Icon(
                  Icons.circle_outlined,
                  color: Color(0xFF9B7AE8),
                ),
                title: Text(step.title),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveGoal,
                child: const Text('Create My Goal 🌸'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
