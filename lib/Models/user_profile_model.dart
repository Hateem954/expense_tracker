// class UserProfileModel {
//   final String name;
//   final String email;
//   final String phone;
//   final String address;
//   final double monthlyIncome;
//   final String occupation;
//   final String currency;

//   UserProfileModel({
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.address,
//     required this.monthlyIncome,
//     required this.occupation,
//     required this.currency,
//   });

//   factory UserProfileModel.fromMap(Map<String, dynamic> map) {
//     return UserProfileModel(
//       name: map["name"] ?? "",
//       email: map["email"] ?? "",
//       phone: map["phone"] ?? "",
//       address: map["address"] ?? "",
//       monthlyIncome: (map["monthlyIncome"] ?? 0).toDouble(),
//       occupation: map["occupation"] ?? "",
//       currency: map["currency"] ?? "",
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       "name": name,
//       "email": email,
//       "phone": phone,
//       "address": address,
//       "monthlyIncome": monthlyIncome,
//       "occupation": occupation,
//       "currency": currency,
//     };
//   }
// }

class UserProfileModel {
  final String name;
  final String phone;
  final String address;
  final double monthlyIncome;
  final String occupation;
  final String currency;

  UserProfileModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.monthlyIncome,
    required this.occupation,
    required this.currency,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      name: map["name"] ?? "",
      phone: map["phone"] ?? "",
      address: map["address"] ?? "",
      monthlyIncome: (map["monthlyIncome"] is int)
          ? (map["monthlyIncome"] as int).toDouble()
          : (map["monthlyIncome"] is double)
          ? map["monthlyIncome"]
          : double.tryParse(map["monthlyIncome"].toString()) ?? 0,
      occupation: map["occupation"] ?? "",
      currency: map["currency"] ?? "PKR",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phone": phone,
      "address": address,
      "monthlyIncome": monthlyIncome,
      "occupation": occupation,
      "currency": currency,
    };
  }
}
