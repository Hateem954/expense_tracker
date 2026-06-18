import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // bool darkMode = false;
  bool biometricLogin = false;
  bool notifications = false;

  String selectedCurrency = "PKR";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Appearance
            _sectionTitle("Appearance"),

            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return _settingsTile(
                  icon: Icons.dark_mode,
                  title: "Dark Mode",
                  trailing: Switch(
                    value: themeProvider.isDarkMode,
                    activeColor: Colors.teal,
                    onChanged: (value) {
                      themeProvider.toggleTheme(value);
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            /// Security
            _sectionTitle("Security"),

            // _settingsTile(
            //   icon: Icons.fingerprint,
            //   title: "Fingerprint Login",
            //   trailing: Switch(
            //     value: biometricLogin,
            //     onChanged: (value) {
            //       setState(() {
            //         biometricLogin = value;
            //       });
            //     },
            //   ),
            // ),
            const SizedBox(height: 16),

            /// Notifications
            _sectionTitle("Notifications"),

            _settingsTile(
              icon: Icons.notifications,
              title: "Enable Notifications",
              trailing: Switch(
                value: notifications,
                onChanged: (value) {
                  setState(() {
                    notifications = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 16),

            /// Currency
            _sectionTitle("Preferences"),

            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(16),
            //   ),
            //   child: ListTile(
            //     leading: const Icon(Icons.currency_exchange),
            //     title: const Text("Currency"),
            //     trailing: DropdownButton<String>(
            //       value: selectedCurrency,
            //       underline: const SizedBox(),
            //       items: const [
            //         DropdownMenuItem(value: "PKR", child: Text("PKR")),
            //         DropdownMenuItem(value: "USD", child: Text("USD")),
            //         DropdownMenuItem(value: "EUR", child: Text("EUR")),
            //         DropdownMenuItem(value: "GBP", child: Text("GBP")),
            //       ],
            //       onChanged: (value) {
            //         setState(() {
            //           selectedCurrency = value!;
            //         });
            //       },
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16),

            /// About
            _sectionTitle("About"),

            _settingsTile(
              icon: Icons.info_outline,
              title: "App Version",
              subtitle: "Version 1.0.0",
            ),

            const SizedBox(height: 30),

            /// Logout
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    String? subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal),
        title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
        subtitle: subtitle != null ? Text(subtitle) : null,
        trailing: trailing,
      ),
    );
  }
}
