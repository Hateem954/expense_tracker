import 'package:flutter/material.dart';
import '../providers/currency_services.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String selectedCurrency = "PKR";

  final List<String> currencies = ["PKR", "USD", "EUR", "GBP", "INR", "AED"];

  @override
  void initState() {
    super.initState();
    loadCurrency();
  }

  Future<void> loadCurrency() async {
    final currency = await CurrencyService.getCurrency();

    setState(() {
      selectedCurrency = currency;
    });
  }

  Future<void> saveCurrency(String currency) async {
    await CurrencyService.setCurrency(currency);

    setState(() {
      selectedCurrency = currency;
    });

    Navigator.pop(context, currency);
  }

  void addCustomCurrency() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add Currency"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter Currency Code"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final code = controller.text.toUpperCase();

                if (code.isNotEmpty) {
                  setState(() {
                    currencies.add(code);
                  });

                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Currency")),
      floatingActionButton: FloatingActionButton(
        onPressed: addCustomCurrency,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currencies.length,
        itemBuilder: (context, index) {
          final currency = currencies[index];

          return ListTile(
            title: Text(currency),
            trailing: selectedCurrency == currency
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            onTap: () => saveCurrency(currency),
          );
        },
      ),
    );
  }
}
