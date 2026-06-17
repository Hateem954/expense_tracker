import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class DarkModeTile extends StatelessWidget {
  const DarkModeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SwitchListTile(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
            secondary: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Colors.teal,
            ),
            title: const Text(
              "Dark Mode",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              themeProvider.isDarkMode
                  ? "Dark theme enabled"
                  : "Light theme enabled",
            ),
            activeColor: Colors.teal,
          ),
        );
      },
    );
  }
}
