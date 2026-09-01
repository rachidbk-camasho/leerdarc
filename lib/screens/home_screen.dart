import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/content.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/level_card.dart';
import 'level_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: AppColors.heroGradient,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Text('🇲🇦', style: TextStyle(fontSize: 22)),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Leer Darija',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Marokkaans Darija leren, stap voor stap — speciaal '
                      'gemaakt voor Nederlandstalige leerders.',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.softGrey,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final level = DarijaContent.levels[index];
                    final completed = progress.completedInLevel(
                      level.lessons.map((l) => l.id).toList(),
                    );
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: LevelCard(
                        level: level,
                        completedLessons: completed,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => LevelScreen(level: level),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  childCount: DarijaContent.levels.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
