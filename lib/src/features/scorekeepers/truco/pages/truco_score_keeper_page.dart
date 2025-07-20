import 'package:flutter/material.dart';
import 'package:multigame/src/features/scorekeepers/truco/models/truco_config.dart';
import 'truco_config_page.dart';
import 'truco_score_page.dart';

class TrucoScoreKeeperPage extends StatefulWidget {
  const TrucoScoreKeeperPage({super.key});

  @override
  State<TrucoScoreKeeperPage> createState() => _TrucoScoreKeeperPageState();
}

class _TrucoScoreKeeperPageState extends State<TrucoScoreKeeperPage> {
  TrucoConfig? _config;

  void _startGame(TrucoConfig config) {
    setState(() {
      _config = config;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_config == null) {
      return TrucoConfigPage(onStartGame: _startGame);
    }

    return TrucoScorePage(config: _config!);
  }
}
