import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'main.dart';

class HomeScreen extends StatefulWidget {
  final List<ExpenseData> data;
  const HomeScreen({Key? key, required this.data}) : super(key: key);

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
                          "No expense data found",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                          ),
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

    data.forEach((element) {
      // expenses.add(
      //   createCard(),
      // );
    });

    return expenses;
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
