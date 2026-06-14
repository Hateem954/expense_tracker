class ExpenseModel {
  String id;
  double amount;
  String category;
  String paymentMethod;
  String description;
  DateTime date;

  ExpenseModel({
    required this.id,
    required this.amount,
    required this.category,
    required this.paymentMethod,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'paymentMethod': paymentMethod,
      'description': description,
      'date': date,
    };
  }

  factory ExpenseModel.fromMap(String id, Map<String, dynamic> map) {
    return ExpenseModel(
      id: id,
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      description: map['description'] ?? '',
      date: (map['date'] as dynamic).toDate(),
    );
  }
}
