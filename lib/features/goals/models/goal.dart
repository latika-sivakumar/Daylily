class Goal {
  final String id;
  final String title;
  final String description;
  final DateTime targetDate;
  final List<GoalStep> steps;

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.targetDate,
    required this.steps,
  });

  int get totalSteps => steps.length;

  int get completedSteps => steps.where((step) => step.isCompleted).length;

  double get progress {
    if (steps.isEmpty) {
      return 0;
    }

    return completedSteps / totalSteps;
  }
}

class GoalStep {
  final String id;
  final String title;
  bool isCompleted;

  GoalStep({required this.id, required this.title, this.isCompleted = false});
}
