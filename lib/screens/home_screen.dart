import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/content.dart';
import '../models/models.dart';
import '../services/progress_service.dart';
import '../theme/app_theme.dart';
import '../widgets/level_card.dart';
import 'level_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DarijaLevel>>(
      future: DarijaContent.load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text('De lesinhoud kon niet worden geladen.\n${snapshot.error ?? ''}', textAlign: TextAlign.center),
              ),
            ),
          );
        }
        return _LoadedHome(levels: snapshot.data!);
      },
    );
  }
}

class _LoadedHome extends StatelessWidget {
  final List<DarijaLevel> levels;
  const _LoadedHome({required this.levels});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final total = levels.fold<int>(0, (sum, level) => sum + level.totalCards);

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
                            gradient: const LinearGradient(colors: AppColors.heroGradient),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Text('🇲🇦', style: TextStyle(fontSize: 22)),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text('Leer Darija', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Van Nederlands naar natuurlijk Marokkaans Darija — met woordenschat, dialogen, oefeningen en uitspraak.',
                      style: TextStyle(fontSize: 15, color: AppColors.softGrey, fontWeight: FontWeight.w500, height: 1.4),
                    ),
                    const SizedBox(height: 10),
                    Text('$total woorden & uitdrukkingen · 160 dialogen',
                        style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.teal)),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final level = levels[index];
                    final completed = progress.completedInLevel(level.lessons.map((l) => l.id).toList());
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: LevelCard(
                        level: level,
                        completedLessons: completed,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => LevelScreen(level: level)),
                        ),
                      ),
                    );
                  },
                  childCount: levels.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
