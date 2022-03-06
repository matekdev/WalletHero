import 'package:flutter/material.dart';
import 'package:wallet_hero/ExpenseScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet_hero/SummaryScreen.dart';

void main() {
  runApp(const WalletHero());
}

class WalletHero extends StatelessWidget {
  const WalletHero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet Hero',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: const MainPage(
        title: 'Wallet Hero',
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  late var appScreens = [
    const Center(
      child: Text("Home"),
    ),
    ExpenseScreen(
      onAdd: (amount, desc) => {
        setState(() {
          currentIndex = 0;
        })
      },
    ),
    SummaryScreen(
      data: currentIndex,
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
                label: "Summary",
              )
            ],
          )),
    );
  }
}
