import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart';

class HomeScreen extends StatefulWidget {
  final List<ExpenseData> data;
  final Function addNewExpense;
  const HomeScreen({Key? key, required this.data, required this.addNewExpense})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: widget.data.isEmpty
              ? Column(
                  children: [
                    createCard(
                      const Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: createCard(
                        const Text(
                          "No expense data found.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    createCard(
                      ElevatedButton.icon(
                        onPressed: () {
                          widget.addNewExpense();
                        },
                        icon: const Icon(
                          Icons.check,
                          size: 30,
                        ),
                        label: const Text(
                          "Add a new expense",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 75),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                )
              : ListView(
                  children: [
                    createCard(
                      const Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...createExpenses(widget.data),
                  ],
                ),
        ),
      ),
    );
  }

  String getMonth(DateTime date) {
    return DateFormat.MMMM().format(date);
  }

  List<Widget> createExpenses(List<ExpenseData> data) {
    List<Widget> expenses = [];

    for (var element in data) {
      expenses.add(
        createCard(createExpense(element)),
      );
    }

    return expenses;
  }

  Widget createExpense(ExpenseData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(data.date.toString()),
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

  Widget createCard(Widget content) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: content,
      ),
    );
  }
}
