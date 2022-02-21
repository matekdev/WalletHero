import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  var total = "\$";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: Colors.lightBlue,
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 130,
              child: FittedBox(
                child: Text(
                  getFormattedTotal(total),
                  style: const TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: createKeyboard(),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child:
                      const Icon(Icons.note_add_rounded, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.check, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }

  String getFormattedTotal(String total) {
    if (total.length == 1) return total;
    return total;
  }

  createKeyboard() {
    List<Widget> keyboard = [];

    List.generate(
      9,
      (index) => {
        keyboard.add(numberedButton("${index + 1}")),
      },
    );

    keyboard.add(Text(""));
    keyboard.add(numberedButton("0"));
    keyboard.add(deleteButton());

    return keyboard;
  }

  Widget deleteButton() {
    return TextButton(
      onPressed: () {
        if (total.length > 1) {
          setState(() {
            total = total.substring(0, total.length - 1);
          });
        }
      },
      child: const Text(
        "<",
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24),
      ),
    );
  }

  Widget numberedButton(String num) {
    return TextButton(
      onPressed: () {
        setState(() {
          total += num;
        });
      },
      child: Text(
        num,
        style: const TextStyle(
          fontSize: 40,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24),
      ),
    );
  }
}
