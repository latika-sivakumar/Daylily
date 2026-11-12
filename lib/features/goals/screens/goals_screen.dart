import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_goal_screen.dart';
import '../providers/goals_provider.dart';
import '../widgets/goal_card.dart';

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(goalsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Goals 🌸')),
      body: goals.isEmpty
          ? const Center(
              child: Text(
                'No goals yet.\nLet’s dream big! ✨',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: goals.length,
              itemBuilder: (context, index) {
                final goal = goals[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GoalCard(goal: goal),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddGoalScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Goal'),
      ),
    );
  }
}
