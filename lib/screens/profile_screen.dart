// import 'package:expense_tracker/models/user_profile_model.dart';
// import 'package:expense_tracker/providers/profile_service.dart';
// import 'package:flutter/material.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final addressController = TextEditingController();
//   final incomeController = TextEditingController();
//   final occupationController = TextEditingController();

//   bool isLoading = false;

//   String selectedCurrency = "";

//   List<String> currencies = [
//     "PKR",
//     "USD",
//     "EUR",
//     "GBP",
//     "INR",
//     "AED",
//     "SAR",
//     "JPY",
//     "CAD",
//     "AUD",
//   ];
//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//   }

//   // Future<void> loadProfile() async {
//   //   final profile = await ProfileService.getProfile();

//   //   if (profile == null) return;

//   //   nameController.text = profile.name;
//   //   emailController.text = profile.email;
//   //   phoneController.text = profile.phone;
//   //   addressController.text = profile.address;
//   //   incomeController.text = profile.monthlyIncome.toString();
//   //   occupationController.text = profile.occupation;

//   //   setState(() {});
//   // }

//   Future<void> loadProfile() async {
//     final profile = await ProfileService.getProfile();

//     if (profile == null) {
//       emailController.text = ProfileService.getCurrentEmail();
//       return;
//     }

//     nameController.text = profile.name;
//     emailController.text = profile.email;
//     phoneController.text = profile.phone;
//     addressController.text = profile.address;
//     incomeController.text = profile.monthlyIncome.toString();
//     occupationController.text = profile.occupation;

//     selectedCurrency = profile.currency;

//     setState(() {});
//   }

//   Future<void> saveProfile() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     // final profile = UserProfileModel(
//     //   name: nameController.text.trim(),
//     //   email: emailController.text.trim(),
//     //   phone: phoneController.text.trim(),
//     //   address: addressController.text.trim(),
//     //   monthlyIncome: double.tryParse(incomeController.text) ?? 0,
//     //   occupation: occupationController.text.trim(),
//     // );
//     final profile = UserProfileModel(
//       name: nameController.text.trim(),
//       email: emailController.text.trim(),
//       phone: phoneController.text.trim(),
//       address: addressController.text.trim(),
//       monthlyIncome: double.tryParse(incomeController.text) ?? 0,
//       occupation: occupationController.text.trim(),
//       currency: selectedCurrency.isEmpty ? "PKR" : selectedCurrency,
//     );

//     await ProfileService.saveProfile(profile);

//     setState(() {
//       isLoading = false;
//     });

//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text("Profile Saved")));
//   }

//   Widget buildField({
//     required String label,
//     required TextEditingController controller,
//     TextInputType? keyboardType,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return "Required";
//           }
//           return null;
//         },
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Profile",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: RefreshIndicator(
//         onRefresh: loadProfile,
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const CircleAvatar(
//                   radius: 45,
//                   child: Icon(Icons.person, size: 50),
//                 ),

//                 const SizedBox(height: 10),

//                 buildField(label: "Full Name", controller: nameController),
//                 buildField(label: "Email", controller: emailController),
//                 buildField(label: "Phone Number", controller: phoneController),
//                 buildField(label: "Address", controller: addressController),
//                 buildField(
//                   label: "Occupation",
//                   controller: occupationController,
//                 ),
//                 buildField(
//                   label: "Monthly Income",
//                   controller: incomeController,
//                   keyboardType: TextInputType.number,
//                 ),

//                 DropdownButtonFormField<String>(
//                   value: selectedCurrency.isEmpty ? null : selectedCurrency,
//                   items: currencies.map((currency) {
//                     return DropdownMenuItem(
//                       value: currency,
//                       child: Text(currency),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedCurrency = value ?? "PKR";
//                     });
//                   },
//                   decoration: InputDecoration(
//                     labelText: "Currency",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 55,
//                   child: ElevatedButton(
//                     onPressed: isLoading ? null : saveProfile,
//                     child: isLoading
//                         ? const CircularProgressIndicator()
//                         : const Text("Save Profile"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:expense_tracker/models/user_profile_model.dart';
import 'package:expense_tracker/providers/profile_service.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final incomeController = TextEditingController();
  final occupationController = TextEditingController();

  bool isLoading = false;

  String selectedCurrency = "PKR";

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final profile = await ProfileService.getProfile();

    if (profile == null) {
      return;
    }

    nameController.text = profile.name;
    phoneController.text = profile.phone;
    addressController.text = profile.address;
    incomeController.text = profile.monthlyIncome.toString();
    occupationController.text = profile.occupation;

    selectedCurrency = profile.currency;

    setState(() {});
  }

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final profile = UserProfileModel(
      name: nameController.text.trim(),
      // email: "", // still saved but NOT shown
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      monthlyIncome: double.tryParse(incomeController.text) ?? 0,
      occupation: occupationController.text.trim(),
      currency: selectedCurrency,
    );

    await ProfileService.saveProfile(profile);

    setState(() => isLoading = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profile Saved")));
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) =>
            (value == null || value.isEmpty) ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: loadProfile,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  child: Icon(Icons.person, size: 50),
                ),

                const SizedBox(height: 20),

                buildField(label: "Full Name", controller: nameController),
                buildField(label: "Phone Number", controller: phoneController),
                buildField(label: "Address", controller: addressController),
                buildField(
                  label: "Occupation",
                  controller: occupationController,
                ),
                buildField(
                  label: "Monthly Income",
                  controller: incomeController,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 10),

                // 🔒 READ ONLY CURRENCY FIELD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Currency", style: TextStyle(fontSize: 16)),
                      Text(
                        selectedCurrency,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : saveProfile,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Save Profile"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
