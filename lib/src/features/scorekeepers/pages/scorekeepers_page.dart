import 'package:flutter/material.dart';
import 'package:multigame/src/app/search_bar.dart';
import 'package:multigame/src/features/scorekeepers/truco/pages/truco_score_keeper_page.dart';

class ScoreKeepersPage extends StatefulWidget {
  const ScoreKeepersPage({super.key});

  @override
  State<ScoreKeepersPage> createState() => _ScoreKeepersPageState();
}

class _ScoreKeepersPageState extends State<ScoreKeepersPage> {
  final TextEditingController _searchController = TextEditingController();
  String query = '';

  final List<_ScorekeeperItem> scorekeeperItems = [
    _ScorekeeperItem(
      title: 'Anotador de Truco',
      icon: Icons.sports_esports,
      builder: () => TrucoScoreKeeperPage(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        query = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filteredItems = scorekeeperItems.where((item) {
      return item.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: AppSearchBar(
          controller: _searchController,
          hintText: 'Buscar anotadores...',
          onChanged: (_) {},
          onClear: () => _searchController.clear(),
        ),
        elevation: 1,
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredItems.length,
        itemBuilder: (_, index) {
          final item = filteredItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item.builder()),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Row(
                  children: [
                    Icon(item.icon, color: theme.colorScheme.primary, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Icon(Icons.chevron_right,
                        color: theme.colorScheme.primary.withOpacity(0.6)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ScorekeeperItem {
  final String title;
  final IconData icon;
  final Widget Function() builder;

  _ScorekeeperItem({
    required this.title,
    required this.icon,
    required this.builder,
  });
}
