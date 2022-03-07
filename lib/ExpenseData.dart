import 'dart:convert';

class ExpenseData {
  DateTime date;
  String total;
  String note;

  ExpenseData(this.date, this.total, this.note);

  factory ExpenseData.fromJson(Map<String, dynamic> jsonData) {
    return ExpenseData(
      DateTime.parse(jsonData['date']),
      jsonData['total'],
      jsonData['note'],
    );
  }

  static Map<String, dynamic> toMap(ExpenseData expense) => {
        'date': expense.date.toIso8601String(),
        'total': expense.total,
        'note': expense.note,
      };

  static String encode(List<ExpenseData> expenses) => json.encode(
        expenses
            .map<Map<String, dynamic>>((expense) => ExpenseData.toMap(expense))
            .toList(),
      );

  static List<ExpenseData> decode(String expenses) =>
      (json.decode(expenses) as List<dynamic>)
          .map<ExpenseData>((item) => ExpenseData.fromJson(item))
          .toList();
}
