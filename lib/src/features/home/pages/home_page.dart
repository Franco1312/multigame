import 'package:flutter/material.dart';
import 'package:multigame/src/features/discover/pages/discover.dart';
import 'package:multigame/src/features/discover/widgets/discover_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Descubre'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // cambia esto
          children: [
            const Text(
              'Explora!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  DiscoverCard(
                    title: 'Utilidades para jugadores',
                    subtitle:
                        'Accede a anotadores, dados digitales, relojes y más.',
                    icon: Icons.extension,
                    onTap: () {
                      _goToScreen(context, const DiscoverPage());
                    },
                  ),
                  DiscoverCard(
                    title: 'Análisis y estadísticas',
                    subtitle:
                        'Visualiza tus progresos y patrones para mejorar tu estrategia.',
                    icon: Icons.bar_chart,
                    onTap: () {
                      _goToScreen(context, const DiscoverPage());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
