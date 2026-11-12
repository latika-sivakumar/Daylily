import 'package:material_ui/material_ui.dart';

import '../models/goal.dart';

class GoalCard extends StatelessWidget {
  final Goal goal;

  const GoalCard({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Goal title
            Text(
              goal.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Goal description
            Text(
              goal.description,
              style: const TextStyle(fontSize: 14, color: Color(0xFF93869F)),
            ),

            const SizedBox(height: 16),

            // Progress percentage
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your progress',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  '${(goal.progress * 100).toInt()}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9B7AE8),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: goal.progress,
                minHeight: 8,
                backgroundColor: const Color(0xFFE6D9FF),
                color: const Color(0xFF9B7AE8),
              ),
            ),

            const SizedBox(height: 12),

            // Target date
            Text(
              'Target date: ${goal.targetDate.day}/${goal.targetDate.month}/${goal.targetDate.year}',
              style: const TextStyle(fontSize: 12, color: Color(0xFF93869F)),
            ),
          ],
        ),
      ),
    );
  }
}
