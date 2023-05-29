import 'package:flutter/material.dart';

class BonusScreen extends StatefulWidget {
  const BonusScreen({super.key});

  @override
  State<BonusScreen> createState() => _BonusScreenState();
}

class _BonusScreenState extends State<BonusScreen> {
  List<int> fibonacci = [0, 1];

  void generateFibonacci(int count) {
    if (count < 2) return;

    int a = fibonacci[fibonacci.length - 2];
    int b = fibonacci[fibonacci.length - 1];

    while (count > 0) {
      int next = a + b;
      fibonacci.add(next);
      a = b;
      b = next;
      count--;
    }
  }

  @override
  void initState() {
    super.initState();
    generateFibonacci(10); // first 10  numbers
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: fibonacci.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(fibonacci[index].toString()),
        );
      },
    );
  }
}
