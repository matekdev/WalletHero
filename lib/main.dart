import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_hero/ExpenseData.dart';
import 'package:wallet_hero/ExpenseScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_hero/HomeScreen.dart';
import 'package:wallet_hero/FilterScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final expenseString = prefs.getString('expense_key');
  List<ExpenseData> expenseData = [];
  if (expenseString != null) {
    expenseData = ExpenseData.decode(expenseString);
  }

  expenseData.sort(((a, b) => b.date.compareTo(a.date)));
  runApp(WalletHero(
    data: expenseData,
  ));
}

class WalletHero extends StatelessWidget {
  final List<ExpenseData> data;
  const WalletHero({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet Hero',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: MainPage(
        title: 'Wallet Hero',
        data: data,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title, required this.data})
      : super(key: key);
  final String title;
  final List<ExpenseData> data;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  late var appScreens = [
    HomeScreen(
      data: widget.data,
      addNewExpense: () => {
        setState(() {
          currentIndex = 1;
        })
      },
    ),
    ExpenseScreen(
      onAdd: (amount, note) => {
        setState(() {
          widget.data.add(ExpenseData(DateTime.now(), amount, note));
          saveToPrefs(widget.data);

          widget.data.sort(((a, b) => b.date.compareTo(a.date)));
          appScreens[0] = HomeScreen(
              data: widget.data, addNewExpense: () => currentIndex = 1);
          appScreens[2] = FilterScreen(data: widget.data);
          currentIndex = 0;
        })
      },
    ),
    FilterScreen(
      data: widget.data,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: appScreens,
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Expense",
        child: const Text(
          "\$",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          setState(
            () {
              currentIndex = 1;
            },
          );
        },
      ),
      bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => setState(() {
              if (index == 1) return;
              currentIndex = index;
            }),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Add Expense",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "Filter",
              )
            ],
          )),
    );
  }

  void saveToPrefs(List<ExpenseData> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = ExpenseData.encode(data);
    await prefs.setString('expense_key', encodedData);
  }
}
