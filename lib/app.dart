import 'package:material_ui/material_ui.dart';

import 'core/theme/app_theme.dart';
import 'features/home/screens/home_screen.dart';

class DaylilyApp extends StatelessWidget {
  const DaylilyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daylily',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
