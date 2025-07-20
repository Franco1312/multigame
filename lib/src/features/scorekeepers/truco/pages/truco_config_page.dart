import 'package:flutter/material.dart';
import 'package:multigame/src/features/scorekeepers/truco/models/truco_config.dart';

class TrucoConfigPage extends StatefulWidget {
  final void Function(TrucoConfig config) onStartGame;

  const TrucoConfigPage({super.key, required this.onStartGame});

  @override
  State<TrucoConfigPage> createState() => _TrucoConfigPageState();
}

class _TrucoConfigPageState extends State<TrucoConfigPage> {
  int playersCount = 2;
  int targetPoints = 30;
  bool florEnabled = false;
  late List<TextEditingController> teamControllers;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    int count = (playersCount == 2) ? 2 : 2;
    teamControllers = List.generate(count, (index) {
      if (playersCount == 2) {
        return TextEditingController(text: 'Jugador ${index + 1}');
      } else {
        return TextEditingController(text: 'Equipo ${index + 1}');
      }
    });
  }

  @override
  void dispose() {
    for (var c in teamControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _onPlayersCountChanged(int v) {
    setState(() {
      playersCount = v;
      for (var c in teamControllers) {
        c.dispose();
      }
      _initControllers();
    });
  }

  void _onStart() {
    final teamNames = teamControllers.map((c) => c.text.trim()).toList();
    final config = TrucoConfig(
      playersCount: playersCount,
      targetPoints: targetPoints,
      florEnabled: florEnabled,
      teamNames: teamNames,
    );
    widget.onStartGame(config);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configura el juego')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                labelText: 'Cantidad de jugadores',
              ),
              value: playersCount,
              items: [2, 4, 6]
                  .map(
                    (e) =>
                        DropdownMenuItem(value: e, child: Text('$e jugadores')),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) {
                  _onPlayersCountChanged(v);
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Meta de puntos'),
              value: targetPoints,
              items: [15, 30]
                  .map(
                    (e) => DropdownMenuItem(value: e, child: Text('$e puntos')),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) {
                  setState(() {
                    targetPoints = v;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Jugar con Flor'),
              value: florEnabled,
              onChanged: (v) {
                setState(() {
                  florEnabled = v;
                });
              },
            ),
            const SizedBox(height: 16),
            Text(
              playersCount == 2
                  ? 'Nombres de jugadores:'
                  : 'Nombres de equipos:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ...teamControllers.map(
              (controller) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _onStart,
              child: const Text('Iniciar juego'),
            ),
          ],
        ),
      ),
    );
  }
}
