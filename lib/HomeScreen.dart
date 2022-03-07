import 'package:flutter/material.dart';
import 'package:wallet_hero/ExpenseData.dart';
import 'package:wallet_hero/Utils.dart';

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
                    Utils.createCard(
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
                      child: Utils.createCard(
                        const Text(
                          "No expense data found for this month",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    Utils.createCard(
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
                    Utils.createCard(
                      const Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...Utils.createExpenses(context, widget.data),
                  ],
                ),
        ),
      ),
    );
  }
}
