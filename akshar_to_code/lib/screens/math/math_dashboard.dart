import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/module_card.dart';
import 'counting_screen.dart';
import 'tables_screen.dart';

class MathDashboard extends StatelessWidget {
  const MathDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('गणित / Math'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF43E97B), AppTheme.primary],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ModuleCard(
              title: 'गिनती (Counting) 1-100',
              subtitle: 'संख्याएँ, English & हिंदी शब्द',
              icon: Icons.numbers,
              color: AppTheme.moduleColors[2],
              badge: '1-100',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CountingScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 14),
            ModuleCard(
              title: 'पहाड़े (Tables) 2-30',
              subtitle: 'दो एकम दो... लयबद्ध अभ्यास',
              icon: Icons.calculate_outlined,
              color: const Color(0xFFFF9800),
              badge: '×2 to ×30',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TablesScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}