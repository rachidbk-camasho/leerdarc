import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'services/progress_service.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const LeerDarijaApp());
}

class LeerDarijaApp extends StatelessWidget {
  const LeerDarijaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProgressService()..load(),
      child: MaterialApp(
        title: 'Leer Darija',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const HomeScreen(),
      ),
    );
  }
}
