// import 'package:flutter/material.dart';
// import '../providers/currency_services.dart';

// class CurrencyScreen extends StatefulWidget {
//   const CurrencyScreen({super.key});

//   @override
//   State<CurrencyScreen> createState() => _CurrencyScreenState();
// }

// class _CurrencyScreenState extends State<CurrencyScreen> {
//   String selectedCurrency = "PKR";

//   final List<String> currencies = ["PKR", "USD", "EUR", "GBP", "INR", "AED"];

//   @override
//   void initState() {
//     super.initState();
//     loadCurrency();
//   }

//   Future<void> loadCurrency() async {
//     final currency = await CurrencyService.getCurrency();

//     setState(() {
//       selectedCurrency = currency;
//     });
//   }

//   Future<void> saveCurrency(String currency) async {
//     await CurrencyService.setCurrency(currency);

//     setState(() {
//       selectedCurrency = currency;
//     });

//     Navigator.pop(context, currency);
//   }

//   void addCustomCurrency() {
//     final controller = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           title: const Text("Add Currency"),
//           content: TextField(
//             controller: controller,
//             decoration: const InputDecoration(hintText: "Enter Currency Code"),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final code = controller.text.toUpperCase();

//                 if (code.isNotEmpty) {
//                   setState(() {
//                     currencies.add(code);
//                   });

//                   Navigator.pop(context);
//                 }
//               },
//               child: const Text("Add"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Select Currency")),
//       floatingActionButton: FloatingActionButton(
//         onPressed: addCustomCurrency,
//         child: const Icon(Icons.add),
//       ),
//       body: ListView.builder(
//         itemCount: currencies.length,
//         itemBuilder: (context, index) {
//           final currency = currencies[index];

//           return ListTile(
//             title: Text(currency),
//             trailing: selectedCurrency == currency
//                 ? const Icon(Icons.check_circle, color: Colors.green)
//                 : null,
//             onTap: () => saveCurrency(currency),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../providers/currency_services.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String selectedCurrency = "PKR";

  // final List<String> currencies = ["PKR", "USD", "EUR", "GBP", "INR", "AED"];
  final List<String> currencies = [
    // Asia
    "PKR",
    "INR",
    "CNY",
    "JPY",
    "KRW",
    "BDT",
    "LKR",
    "NPR",
    "AFN",
    "MMK",
    "THB",
    "MYR",
    "SGD",
    "IDR",
    "PHP",
    "VND",
    "KHR",
    "LAK",

    // Middle East
    "AED",
    "SAR",
    "QAR",
    "KWD",
    "BHD",
    "OMR",
    "ILS",
    "JOD",
    "LBP",
    "YER",
    "IQD",
    "IRR",

    // Europe
    "EUR",
    "GBP",
    "CHF",
    "SEK",
    "NOK",
    "DKK",
    "ISK",
    "PLN",
    "CZK",
    "HUF",
    "RON",
    "BGN",
    "HRK",
    "UAH",
    "RUB",

    // North America
    "USD", "CAD", "MXN",

    // South America
    "BRL", "ARS", "CLP", "COP", "PEN", "UYU", "BOB", "PYG", "VES",

    // Africa
    "ZAR",
    "NGN",
    "EGP",
    "KES",
    "GHS",
    "MAD",
    "DZD",
    "TND",
    "ETB",
    "UGX",
    "TZS",
    "XOF",
    "XAF",

    // Oceania
    "AUD", "NZD", "FJD",

    // Crypto-like ISO placeholders (optional but common in apps)
    "BTC", "ETH", "USDT",
  ];

  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadCurrency();
  }

  Future<void> loadCurrency() async {
    final currency = await CurrencyService.getCurrency();
    setState(() => selectedCurrency = currency);
  }

  Future<void> saveCurrency(String currency) async {
    await CurrencyService.setCurrency(currency);

    setState(() => selectedCurrency = currency);

    Navigator.pop(context, currency);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filteredCurrencies = currencies
        .where((c) => c.toLowerCase().contains(searchQuery))
        .toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      /// ================= APP BAR =================
      appBar: AppBar(
        title: const Text("Select Currency"),
        centerTitle: true,
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ================= SEARCH BAR =================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() => searchQuery = value.toLowerCase());
                },
                decoration: const InputDecoration(
                  hintText: "Search currency (e.g. USD)",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ================= LIST =================
            Expanded(
              child: ListView.builder(
                itemCount: filteredCurrencies.length,
                itemBuilder: (context, index) {
                  final currency = filteredCurrencies[index];
                  final isSelected = selectedCurrency == currency;

                  return GestureDetector(
                    onTap: () => saveCurrency(currency),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(18),
                        border: isSelected
                            ? Border.all(
                                color: theme.colorScheme.primary,
                                width: 1.5,
                              )
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(
                              theme.brightness == Brightness.dark ? 0.3 : 0.05,
                            ),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: theme.colorScheme.primary
                                .withOpacity(0.15),
                            child: Text(
                              currency.substring(0, 1),
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              currency,
                              style: theme.textTheme.titleMedium,
                            ),
                          ),

                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: theme.colorScheme.primary,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
