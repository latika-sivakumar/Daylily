import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/goal.dart';

class GoalsNotifier extends Notifier<List<Goal>> {
  @override
  List<Goal> build() {
    // Initially, the user has no goals.
    return [];
  }

  void addGoal({
    required String title,
    required String description,
    required DateTime targetDate,
    required List<GoalStep> steps,
  }) {
    final newGoal = Goal(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      description: description,
      targetDate: targetDate,
      steps: steps,
    );

    state = [...state, newGoal];
  }

  void toggleStep({required String goalId, required String stepId}) {
    state = state.map((goal) {
      if (goal.id != goalId) {
        return goal;
      }

      final updatedSteps = goal.steps.map((step) {
        if (step.id == stepId) {
          return GoalStep(
            id: step.id,
            title: step.title,
            isCompleted: !step.isCompleted,
          );
        }

        return GoalStep(
          id: step.id,
          title: step.title,
          isCompleted: step.isCompleted,
        );
      }).toList();

      return Goal(
        id: goal.id,
        title: goal.title,
        description: goal.description,
        targetDate: goal.targetDate,
        steps: updatedSteps,
      );
    }).toList();
  }
}

final goalsProvider = NotifierProvider<GoalsNotifier, List<Goal>>(
  GoalsNotifier.new,
);
