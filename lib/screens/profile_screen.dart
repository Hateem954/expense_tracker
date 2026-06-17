// import 'package:expense_tracker/models/user_profile_model.dart';
// import 'package:expense_tracker/providers/profile_service.dart';
// import 'package:expense_tracker/screens/home_screen.dart';
// import 'package:flutter/material.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final addressController = TextEditingController();
//   final incomeController = TextEditingController();
//   final occupationController = TextEditingController();

//   bool isLoading = false;

//   String selectedCurrency = "PKR";

//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//   }

//   Future<void> loadProfile() async {
//     final profile = await ProfileService.getProfile();

//     if (profile == null) {
//       return;
//     }

//     nameController.text = profile.name;
//     phoneController.text = profile.phone;
//     addressController.text = profile.address;
//     incomeController.text = profile.monthlyIncome.toString();
//     occupationController.text = profile.occupation;

//     selectedCurrency = profile.currency;

//     setState(() {});
//   }

//   Future<void> saveProfile() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => isLoading = true);

//     final profile = UserProfileModel(
//       name: nameController.text.trim(),
//       // email: "", // still saved but NOT shown
//       phone: phoneController.text.trim(),
//       address: addressController.text.trim(),
//       monthlyIncome: double.tryParse(incomeController.text) ?? 0,
//       occupation: occupationController.text.trim(),
//       currency: selectedCurrency,
//     );

//     await ProfileService.saveProfile(profile);

//     setState(() => isLoading = false);

//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text("Profile Saved")));
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => HomeScreen()),
//     );
//   }

//   Widget buildField({
//     required String label,
//     required TextEditingController controller,
//     TextInputType? keyboardType,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         validator: (value) =>
//             (value == null || value.isEmpty) ? "Required" : null,
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

//                 const SizedBox(height: 20),

//                 buildField(label: "Full Name", controller: nameController),
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

//                 const SizedBox(height: 10),

//                 // 🔒 READ ONLY CURRENCY FIELD
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 16,
//                   ),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text("Currency", style: TextStyle(fontSize: 16)),
//                       Text(
//                         selectedCurrency,
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
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
// import 'package:expense_tracker/providers/income_service.dart';
// import 'package:expense_tracker/screens/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:expense_tracker/models/user_profile_model.dart';
// import 'package:expense_tracker/providers/profile_service.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final addressController = TextEditingController();
//   final incomeController = TextEditingController();
//   final occupationController = TextEditingController();

//   bool isLoading = false;
//   bool isEditing = false;

//   String selectedCurrency = "PKR";

//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//   }

//   Future<void> loadProfile() async {
//     final profile = await ProfileService.getProfile();

//     if (profile == null) return;

//     setState(() {
//       nameController.text = profile.name;
//       phoneController.text = profile.phone;
//       addressController.text = profile.address;
//       incomeController.text = profile.monthlyIncome.toString();
//       occupationController.text = profile.occupation;
//       selectedCurrency = profile.currency;
//     });
//   }

//   // Future<void> saveProfile() async {
//   //   setState(() => isLoading = true);

//   //   final profile = UserProfileModel(
//   //     name: nameController.text.trim(),
//   //     phone: phoneController.text.trim(),
//   //     address: addressController.text.trim(),
//   //     monthlyIncome: double.tryParse(incomeController.text) ?? 0,
//   //     occupation: occupationController.text.trim(),
//   //     currency: selectedCurrency,
//   //   );

//   //   await ProfileService.saveProfile(profile);

//   //   await IncomeService().addIncome(
//   //     double.tryParse(incomeController.text) ?? 0,
//   //   );
//   //   setState(() {
//   //     isLoading = false;
//   //     isEditing = false;
//   //   });

//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     const SnackBar(content: Text("Profile Updated Successfully")),
//   //   );
//   // }

//   Future<void> saveProfile() async {
//     setState(() => isLoading = true);

//     final income = double.tryParse(incomeController.text) ?? 0;

//     final profile = UserProfileModel(
//       name: nameController.text.trim(),
//       phone: phoneController.text.trim(),
//       address: addressController.text.trim(),
//       monthlyIncome: income,
//       occupation: occupationController.text.trim(),
//       currency: selectedCurrency,
//     );

//     await ProfileService.saveProfile(profile);

//     // Save income history record
//     await IncomeService().addIncome(income);

//     setState(() {
//       isLoading = false;
//       isEditing = false;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Profile Updated Successfully")),
//     );
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => HomeScreen()),
//     );
//   }

//   // Widget _infoTile({
//   //   required String title,
//   //   required TextEditingController controller,
//   //   TextInputType? keyboardType,
//   // }) {
//   //   return Container(
//   //     margin: const EdgeInsets.only(bottom: 10),
//   //     padding: const EdgeInsets.all(12),
//   //     decoration: BoxDecoration(
//   //       color: Colors.grey.shade100,
//   //       borderRadius: BorderRadius.circular(12),
//   //     ),
//   //     child: isEditing
//   //         ? TextFormField(
//   //             controller: controller,
//   //             keyboardType: keyboardType,
//   //             decoration: InputDecoration(
//   //               labelText: title,
//   //               border: InputBorder.none,
//   //             ),
//   //           )
//   //         : Row(
//   //             children: [
//   //               Expanded(
//   //                 child: Text(
//   //                   title,
//   //                   style: const TextStyle(fontWeight: FontWeight.w500),
//   //                 ),
//   //               ),
//   //               Flexible(
//   //                 child: Text(
//   //                   controller.text.isEmpty ? "Not Set" : controller.text,
//   //                   textAlign: TextAlign.end,
//   //                   style: const TextStyle(fontWeight: FontWeight.bold),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //   );
//   // }

//   Widget _infoTile({
//     required String title,
//     required TextEditingController controller,
//     required IconData icon,
//     TextInputType? keyboardType,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF5F6F8),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: isEditing
//           ? TextFormField(
//               controller: controller,
//               keyboardType: keyboardType,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(icon),
//                 labelText: title,
//                 border: InputBorder.none,
//               ),
//             )
//           : Row(
//               children: [
//                 Icon(icon, color: Colors.grey.shade700, size: 24),
//                 const SizedBox(width: 12),

//                 Expanded(
//                   flex: 3,
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey.shade700,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),

//                 Expanded(
//                   flex: 4,
//                   child: Text(
//                     controller.text.isEmpty ? "Not Set" : controller.text,
//                     textAlign: TextAlign.end,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Profile"),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),

//       body: RefreshIndicator(
//         onRefresh: loadProfile,
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               /// PROFILE IMAGE
//               const CircleAvatar(
//                 radius: 55,
//                 backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
//               ),

//               const SizedBox(height: 12),

//               /// NAME
//               Text(
//                 nameController.text.isEmpty ? "User Name" : nameController.text,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 5),

//               // /// STATS
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               //   children: const [
//               //     _StatBox(title: "Followers", value: "115"),
//               //     _StatBox(title: "Following", value: "120"),
//               //     _StatBox(title: "Posts", value: "3"),
//               //   ],
//               // ),
//               const SizedBox(height: 30),

//               /// INFORMATION HEADER
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Information",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),

//                   IconButton(
//                     icon: Icon(isEditing ? Icons.close : Icons.edit),
//                     onPressed: () async {
//                       if (isEditing) {
//                         await loadProfile();
//                       }

//                       setState(() {
//                         isEditing = !isEditing;
//                       });
//                     },
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 15),

//               // _infoTile(title: "Full Name", controller: nameController),

//               // _infoTile(title: "Phone Number", controller: phoneController),

//               // _infoTile(title: "Address", controller: addressController),

//               // _infoTile(title: "Occupation", controller: occupationController),

//               // _infoTile(
//               //   title: "Monthly Income",
//               //   controller: incomeController,
//               //   keyboardType: TextInputType.number,
//               // ),
//               _infoTile(
//                 title: "Full Name",
//                 controller: nameController,
//                 icon: Icons.person_outline,
//               ),

//               _infoTile(
//                 title: "Phone",
//                 controller: phoneController,
//                 icon: Icons.phone_outlined,
//               ),

//               _infoTile(
//                 title: "Address",
//                 controller: addressController,
//                 icon: Icons.location_on_outlined,
//               ),

//               _infoTile(
//                 title: "Occupation",
//                 controller: occupationController,
//                 icon: Icons.work_outline,
//               ),

//               _infoTile(
//                 title: "Monthly Income",
//                 controller: incomeController,
//                 icon: Icons.attach_money,
//                 keyboardType: TextInputType.number,
//               ),

//               /// READ ONLY CURRENCY
//               // Container(
//               //   margin: const EdgeInsets.only(top: 10),
//               //   padding: const EdgeInsets.all(14),
//               //   decoration: BoxDecoration(
//               //     color: Colors.grey.shade100,
//               //     borderRadius: BorderRadius.circular(12),
//               //   ),
//               //   child: Row(
//               //     children: [
//               //       const Text(
//               //         "Currency",
//               //         style: TextStyle(fontWeight: FontWeight.w500),
//               //       ),
//               //       const Spacer(),
//               //       Text(
//               //         selectedCurrency,
//               //         style: const TextStyle(fontWeight: FontWeight.bold),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               Container(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 14,
//                 ),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF5F6F8),
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.currency_exchange, color: Colors.grey.shade700),
//                     const SizedBox(width: 12),

//                     Expanded(
//                       child: Text(
//                         "Currency",
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.grey.shade700,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),

//                     Text(
//                       selectedCurrency,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               /// SAVE BUTTON
//               if (isEditing) ...[
//                 const SizedBox(height: 25),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 52,
//                   child: ElevatedButton(
//                     onPressed: isLoading ? null : saveProfile,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text("Save Changes"),
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _StatBox extends StatelessWidget {
//   final String title;
//   final String value;

//   const _StatBox({required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 5),
//         Text(title, style: const TextStyle(color: Colors.grey)),
//       ],
//     );
//   }
// }
//5454454544545445445454545454545444545445544454454545454545454545454545454545445445
// import 'package:expense_tracker/providers/currency_services.dart';
// import 'package:expense_tracker/providers/income_service.dart';
// import 'package:expense_tracker/screens/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:expense_tracker/models/user_profile_model.dart';
// import 'package:expense_tracker/providers/profile_service.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final addressController = TextEditingController();
//   final incomeController = TextEditingController();
//   final occupationController = TextEditingController();

//   bool isLoading = false;
//   bool isEditing = false;

//   @override
//   void initState() {
//     super.initState();
//     loadProfile();
//     // CurrencyService.loadCurrency(); // 🔥 important
//   }

//   Future<void> loadProfile() async {
//     final profile = await ProfileService.getProfile();

//     if (profile == null) return;

//     setState(() {
//       nameController.text = profile.name;
//       phoneController.text = profile.phone;
//       addressController.text = profile.address;
//       incomeController.text = profile.monthlyIncome.toString();
//       occupationController.text = profile.occupation;
//     });
//   }

//   Future<void> saveProfile(String currency) async {
//     setState(() => isLoading = true);

//     final income = double.tryParse(incomeController.text) ?? 0;

//     final profile = UserProfileModel(
//       name: nameController.text.trim(),
//       phone: phoneController.text.trim(),
//       address: addressController.text.trim(),
//       monthlyIncome: income,
//       occupation: occupationController.text.trim(),
//       currency: currency,
//     );

//     await ProfileService.saveProfile(profile);

//     await IncomeService().addIncome(income);

//     await CurrencyService.setCurrency(currency); // 🔥 sync globally

//     setState(() {
//       isLoading = false;
//       isEditing = false;
//     });

//     if (!mounted) return;

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Profile Updated Successfully")),
//     );

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const HomeScreen()),
//     );
//   }

//   Widget _infoTile({
//     required String title,
//     required TextEditingController controller,
//     required IconData icon,
//     TextInputType? keyboardType,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF5F6F8),
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: isEditing
//           ? TextFormField(
//               controller: controller,
//               keyboardType: keyboardType,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(icon),
//                 labelText: title,
//                 border: InputBorder.none,
//               ),
//             )
//           : Row(
//               children: [
//                 Icon(icon, color: Colors.grey.shade700, size: 24),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   flex: 3,
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey.shade700,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 4,
//                   child: Text(
//                     controller.text.isEmpty ? "Not Set" : controller.text,
//                     textAlign: TextAlign.end,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.white,
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,

//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         // backgroundColor: Colors.white,
//         // foregroundColor: Colors.black,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         // foregroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0,
//       ),

//       body: ValueListenableBuilder<String>(
//         valueListenable: CurrencyService.currencyNotifier,
//         builder: (context, selectedCurrency, child) {
//           return RefreshIndicator(
//             onRefresh: loadProfile,
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   const CircleAvatar(
//                     radius: 55,
//                     backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
//                   ),

//                   const SizedBox(height: 12),

//                   Text(
//                     nameController.text.isEmpty
//                         ? "User Name"
//                         : nameController.text,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Information",
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(isEditing ? Icons.close : Icons.edit),
//                         onPressed: () {
//                           setState(() {
//                             isEditing = !isEditing;
//                           });
//                         },
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 15),

//                   _infoTile(
//                     title: "Full Name",
//                     controller: nameController,
//                     icon: Icons.person_outline,
//                   ),
//                   _infoTile(
//                     title: "Phone",
//                     controller: phoneController,
//                     icon: Icons.phone_outlined,
//                   ),
//                   _infoTile(
//                     title: "Address",
//                     controller: addressController,
//                     icon: Icons.location_on_outlined,
//                   ),
//                   _infoTile(
//                     title: "Occupation",
//                     controller: occupationController,
//                     icon: Icons.work_outline,
//                   ),
//                   _infoTile(
//                     title: "Monthly Income",
//                     controller: incomeController,
//                     icon: Icons.attach_money,
//                     keyboardType: TextInputType.number,
//                   ),

//                   Container(
//                     margin: const EdgeInsets.only(bottom: 12),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 14,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF5F6F8),
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.currency_exchange,
//                           color: Colors.grey.shade700,
//                         ),
//                         const SizedBox(width: 12),
//                         const Expanded(
//                           child: Text(
//                             "Currency",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           selectedCurrency,
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   if (isEditing) ...[
//                     const SizedBox(height: 25),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 52,
//                       child: ElevatedButton(
//                         onPressed: isLoading
//                             ? null
//                             : () => saveProfile(selectedCurrency),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.black,
//                           foregroundColor: Colors.white,
//                         ),
//                         child: isLoading
//                             ? const CircularProgressIndicator(
//                                 color: Colors.white,
//                               )
//                             : const Text("Save Changes"),
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:expense_tracker/providers/currency_services.dart';
import 'package:expense_tracker/providers/income_service.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/user_profile_model.dart';
import 'package:expense_tracker/providers/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final incomeController = TextEditingController();
  final occupationController = TextEditingController();

  bool isLoading = false;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final profile = await ProfileService.getProfile();
    if (profile == null) return;

    setState(() {
      nameController.text = profile.name;
      phoneController.text = profile.phone;
      addressController.text = profile.address;
      incomeController.text = profile.monthlyIncome.toString();
      occupationController.text = profile.occupation;
    });
  }

  Future<void> saveProfile(String currency) async {
    setState(() => isLoading = true);

    final income = double.tryParse(incomeController.text) ?? 0;

    final profile = UserProfileModel(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      address: addressController.text.trim(),
      monthlyIncome: income,
      occupation: occupationController.text.trim(),
      currency: currency,
    );

    await ProfileService.saveProfile(profile);
    await IncomeService().addIncome(income);
    await CurrencyService.setCurrency(currency);

    setState(() {
      isLoading = false;
      isEditing = false;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile Updated Successfully")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Widget _infoTile({
    required String title,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: isEditing
          ? TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: TextStyle(color: theme.colorScheme.onSurface),
              decoration: InputDecoration(
                prefixIcon: Icon(icon),
                labelText: title,
                labelStyle: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                border: InputBorder.none,
              ),
            )
          : Row(
              children: [
                Icon(
                  icon,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    controller.text.isEmpty ? "Not Set" : controller.text,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        foregroundColor: theme.colorScheme.onBackground,
        elevation: 0,
      ),

      body: ValueListenableBuilder<String>(
        valueListenable: CurrencyService.currencyNotifier,
        builder: (context, selectedCurrency, child) {
          return RefreshIndicator(
            onRefresh: loadProfile,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    nameController.text.isEmpty
                        ? "User Name"
                        : nameController.text,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Information",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                      IconButton(
                        icon: Icon(isEditing ? Icons.close : Icons.edit),
                        color: theme.colorScheme.onBackground,
                        onPressed: () {
                          setState(() {
                            isEditing = !isEditing;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  _infoTile(
                    title: "Full Name",
                    controller: nameController,
                    icon: Icons.person_outline,
                  ),
                  _infoTile(
                    title: "Phone",
                    controller: phoneController,
                    icon: Icons.phone_outlined,
                  ),
                  _infoTile(
                    title: "Address",
                    controller: addressController,
                    icon: Icons.location_on_outlined,
                  ),
                  _infoTile(
                    title: "Occupation",
                    controller: occupationController,
                    icon: Icons.work_outline,
                  ),
                  _infoTile(
                    title: "Monthly Income",
                    controller: incomeController,
                    icon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.currency_exchange,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "Currency",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          selectedCurrency,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (isEditing) ...[
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () => saveProfile(selectedCurrency),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Save Changes"),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
