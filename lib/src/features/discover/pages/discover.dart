import 'package:flutter/material.dart';
import 'package:multigame/src/app/search_bar.dart';
import 'package:multigame/src/features/scorekeepers/pages/scorekeepers_page.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final TextEditingController _searchController = TextEditingController();
  String query = '';

  final Map<String, IconData> itemIcons = {
    'Anotadores': Icons.note,
    'Dados digitales': Icons.casino,
    'Relojes': Icons.access_time,
    'Generador de nombres': Icons.person,
    'Temporizadores': Icons.timer,
    'Estadísticas': Icons.bar_chart,
  };

  final Map<String, Widget> itemPages = {
    'Anotadores': const ScoreKeepersPage(),
    // Agregá más cuando tengas más pantallas:
    // 'Dados digitales': const DicePage(),
    // 'Relojes': const ClockPage(),
  };

  final List<String> allItems = [
    'Anotadores',
    'Dados digitales',
    'Relojes',
    'Generador de nombres',
    'Temporizadores',
    'Estadísticas',
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
    final filteredItems = allItems.where((item) {
      return item.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: AppSearchBar(
          controller: _searchController,
          onChanged: (text) {},
          onClear: () => _searchController.clear(),
          hintText: 'Buscar utilidades...',
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
                final Widget? page = itemPages[item];
                if (page != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => page),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Página no disponible para: $item')),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Icon(
                      itemIcons[item] ?? Icons.device_unknown,
                      color: theme.colorScheme.primary,
                      size: 32,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.primary.withOpacity(0.6),
                    ),
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
