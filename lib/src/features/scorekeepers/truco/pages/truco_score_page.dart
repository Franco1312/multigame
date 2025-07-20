import 'package:flutter/material.dart';
import '../models/truco_config.dart';

class TrucoScorePage extends StatefulWidget {
  final TrucoConfig config;
  const TrucoScorePage({super.key, required this.config});

  @override
  State<TrucoScorePage> createState() => _TrucoScorePageState();
}

class _TrucoScorePageState extends State<TrucoScorePage> {
  List<List<Widget>> _sticks = [[], []];
  final List<int> _history = [];

  void _addStick(int teamIndex) {
    if (_sticks[teamIndex].length >= widget.config.targetPoints) return; // Límite de puntos
    setState(() {
      _sticks[teamIndex].add(_stick());
      _history.add(teamIndex);
    });
  }

  void _undo() {
    if (_history.isEmpty) return;
    setState(() {
      final last = _history.removeLast();
      if (_sticks[last].isNotEmpty) {
        _sticks[last].removeLast();
      }
    });
  }

  void _reset() {
    setState(() {
      _sticks = [[], []];
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E7D32), // Fondo tipo mesa
      appBar: AppBar(
        title: const Text('Anotador de Truco'),
        backgroundColor: const Color(0xFF1B5E20),
        actions: [
          IconButton(icon: const Icon(Icons.undo), onPressed: _undo),
          IconButton(icon: const Icon(Icons.refresh), onPressed: _reset),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: List.generate(2, (i) => _buildDropZone(i)),
            ),
          ),
          const Divider(height: 1, color: Colors.white70),
          _buildDraggableSticks(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildDropZone(int teamIndex) {
    final teamName = widget.config.teamNames[teamIndex];
    final teamPoints = _sticks[teamIndex].length;

    return Expanded(
      child: DragTarget<int>(
        onAccept: (_) => _addStick(teamIndex),
        builder: (_, __, ___) => Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white70, width: 1),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
            ],
          ),
          child: Column(
            children: [
              Text(
                teamName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                '$teamPoints',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _sticks[teamIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableSticks() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(8),
          child: Draggable<int>(
            data: 1,
            feedback: _stick(opacity: 1),
            childWhenDragging: _stick(opacity: 0.3),
            child: _stick(),
          ),
        ),
      ),
    );
  }

  Widget _stick({double opacity = 1}) {
    return Opacity(
      opacity: opacity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            width: 6,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFF8B4513), // Marrón madera
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
