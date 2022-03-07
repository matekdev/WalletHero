import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wallet_hero/ExpenseData.dart';

class Utils {
  static Widget createCard(Widget content) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: content,
      ),
    );
  }

  static String getMonth(DateTime date) {
    return DateFormat.MMMM().format(date);
  }

  static String getMonthDay(DateTime date) {
    return DateFormat('EEEE, dd').format(date);
  }

  static Widget createExpense(ExpenseData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getMonthDay(data.date),
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            Text(data.note),
            const Spacer(),
            Text(data.total),
          ],
        )
      ],
    );
  }

  static List<Widget> createExpenses(
      BuildContext context, List<ExpenseData> data) {
    List<Widget> expenses = [];

    for (var element in data) {
      expenses.add(
        createCardButton(context, element),
      );
    }

    return expenses;
  }

  static Widget createCardButton(BuildContext context, ExpenseData data) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onLongPress: () {
        Clipboard.setData(ClipboardData(
                text: '${getMonthDay(data.date)} - ${data.note} ${data.total}'))
            .then((_) {
          Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            title: "",
            titleSize: 0,
            message: "Expense copied",
            duration: const Duration(seconds: 1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ).show(context);
        });
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getMonthDay(data.date),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(data.note),
                  const Spacer(),
                  Text(data.total),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
