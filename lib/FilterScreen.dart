import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wallet_hero/ExpenseData.dart';
import 'package:wallet_hero/Utils.dart';

class FilterScreen extends StatefulWidget {
  final List<ExpenseData> data;
  const FilterScreen({Key? key, required this.data}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var isButtonEnabled = false;
  PickerDateRange? dateRange;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Utils.createCard(
                  const Text(
                    "Filter Expenses",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Utils.createCard(
                  const Text(
                    "Select a date range to filter your previous expenses",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Utils.createCard(
                  SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.range,
                    onSelectionChanged: _onSelectionChanged,
                  ),
                ),
                Utils.createCard(
                  ElevatedButton.icon(
                    onPressed: isButtonEnabled
                        ? () {
                            List<ExpenseData> filteredData = [];
                            // Don't judge, I have an assignment deadline.
                            for (var expense in widget.data) {
                              var isSameDay = (dateRange!.startDate!.year ==
                                          expense.date.year &&
                                      dateRange!.startDate!.month ==
                                          expense.date.month &&
                                      dateRange!.startDate!.day ==
                                          expense.date.day) ||
                                  (dateRange!.endDate!.year ==
                                          expense.date.year &&
                                      dateRange!.endDate!.month ==
                                          expense.date.month &&
                                      dateRange!.endDate!.day ==
                                          expense.date.day);

                              if (isSameDay ||
                                  (expense.date
                                          .isAfter(dateRange!.startDate!) &&
                                      expense.date
                                          .isBefore(dateRange!.endDate!))) {
                                filteredData.add(expense);
                              }
                            }

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExpenseFilteredScreen(
                                    filteredData: filteredData,
                                  ),
                                ));
                          }
                        : null,
                    icon: const Icon(
                      Icons.filter_alt,
                      size: 30,
                    ),
                    label: const Text(
                      "Filter expenses",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 75),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      var dates = args.value as PickerDateRange;
      isButtonEnabled = dates.startDate != null && dates.endDate != null;
      if (isButtonEnabled) {
        dateRange = dates;
      }
    });
  }
}

class ExpenseFilteredScreen extends StatelessWidget {
  final List<ExpenseData> filteredData;
  const ExpenseFilteredScreen({Key? key, required this.filteredData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    const Text(
                      "Expenses",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                    )
                  ],
                ),
              ),
              if (filteredData.isEmpty)
                Center(
                  child: Utils.createCard(
                    const Text(
                      "No expenses found for this date range.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              else
                ...Utils.createExpenses(context, filteredData),
            ],
          ),
        ),
      ),
    );
  }
}
