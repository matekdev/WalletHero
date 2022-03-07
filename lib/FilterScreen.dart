import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FilterScreen extends StatefulWidget {
  var data;
  FilterScreen({Key? key, this.data}) : super(key: key);

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
                createCard(
                  const Text(
                    "Filter Expenses",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                createCard(
                  const Text(
                    "Select a date range to filter your previous expenses",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                createCard(
                  SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.range,
                    onSelectionChanged: _onSelectionChanged,
                  ),
                ),
                createCard(
                  ElevatedButton.icon(
                    onPressed: isButtonEnabled
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ExpenseFilteredScreen(),
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

  Widget createCard(Widget content) {
    return SizedBox(
      width: 500,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: content,
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
  const ExpenseFilteredScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('test'),
      ),
    );
  }
}
