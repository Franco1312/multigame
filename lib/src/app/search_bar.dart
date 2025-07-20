import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onClear;
  final ValueChanged<String> onChanged;

  const AppSearchBar({
    super.key,
    this.hintText = 'Buscar...',
    required this.controller,
    this.onClear,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: theme.textTheme.bodyMedium,
        cursorColor: theme.colorScheme.primary,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          isDense: true,
          hintText: hintText,
          prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary.withOpacity(0.7)),
          suffixIcon: controller.text.isNotEmpty && onClear != null
              ? GestureDetector(
                  onTap: onClear,
                  child: Icon(Icons.clear, color: theme.colorScheme.primary.withOpacity(0.7)),
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
