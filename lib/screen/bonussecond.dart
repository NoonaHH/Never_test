import 'package:flutter/material.dart';

class BonussecondScreen extends StatefulWidget {
  const BonussecondScreen({super.key});

  @override
  State<BonussecondScreen> createState() => _BonussecondScreenState();
}

class _BonussecondScreenState extends State<BonussecondScreen> {
  List<int> primeNumbers = [];

  void generatePrimeNumbers(int count) {
    int number = 2;

    while (count > 0) {
      if (isPrime(number)) {
        primeNumbers.add(number);
        count--;
      }
      number++;
    }
  }

  bool isPrime(int number) {
    if (number <= 1) {
      return false;
    }

    for (int i = 2; i <= number / 2; i++) {
      if (number % i == 0) {
        return false;
      }
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    generatePrimeNumbers(10); // first 10 numbers
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: primeNumbers.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(primeNumbers[index].toString()),
        );
      },
    );
  }
}
