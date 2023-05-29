import 'package:flutter/material.dart';
import 'package:never_test/components/appBar.dart';
import 'package:never_test/screen/bonussecond.dart';
import 'package:never_test/screen/home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'screen/bonus.dart';
import 'screen/logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BTC Currency',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _page = 0;

  final screens = const [
    HomeScreen(),
    BonusScreen(),
    BonussecondScreen(),
    LogicScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: SafeArea(
          child: appBar(menu: const Text(""), title: 'Never Test'),
        ),
      ),
      // body: HomeScreen(),
      // body: ConvertScreen(),
      bottomNavigationBar: GNav(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(25),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: "Currency",
          ),
          GButton(
            icon: Icons.star,
            text: "Bonus1",
          ),
          GButton(
            icon: Icons.star,
            text: "Bonus2",
          ),
          GButton(
            icon: Icons.numbers,
            text: "Logic",
          ),
        ],
        selectedIndex: _page,
        onTabChange: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: Center(child: screens[_page]),
    );
  }
}
