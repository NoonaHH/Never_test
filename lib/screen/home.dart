import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:never_test/screen/detail.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> _bpiData = {};
  double _btcAmount = 0.0;
  String _selectedCurrency = 'USD';
  Timer? timer;
  Map<String, dynamic> pastPrices = {};

  @override
  void initState() {
    super.initState();
    fetchBTCData();
    timer = Timer.periodic(const Duration(minutes: 1), (_) => fetchBTCData());
  }

  Future<void> fetchBTCData() async {
    try {
      final response = await http
          .get(Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _bpiData = data['bpi'];
        });
      } else {
        setState(() {
          throw Exception('Failed to fetch Data');
        });
      }
    } catch (e) {
      setState(() {
        _bpiData = {};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _cardConvert(total: '\$23,456', totalCrypto: '6.54321'),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 225,
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _bpiData.length,
                  itemBuilder: (context, index) {
                    final currency = _bpiData.keys.elementAt(index);
                    final code = _bpiData[currency]['code'];
                    final rate = _bpiData[currency]['rate'];
                    final description = _bpiData[currency]['description'];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailScreen(title: "$code")));
                      },
                      child: _listDataItem(
                        code: "$code",
                        rate: "$rate",
                        description: "$description",
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> buildCurrencyDropdownItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String currency in _bpiData.keys) {
      items.add(DropdownMenuItem(
        value: currency,
        child: Text(currency),
      ));
    }
    return items;
  }

  Widget _cardConvert({required String total, totalCrypto}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _btcAmount = double.tryParse(value) ?? 0.0;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCurrency,
                      items: buildCurrencyDropdownItems(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCurrency = value as String;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Convert to BTC :", style: TextStyle(fontSize: 18)),
                buildConverterResult(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildConverterResult() {
    if (_bpiData.containsKey(_selectedCurrency)) {
      final rate = _bpiData[_selectedCurrency]['rate'];
      String convertedBtc = "0.0";
      if (_btcAmount != 0.0) {
        double convertedAmount =
            _btcAmount / double.parse(rate.replaceAll(',', ''));
        convertedBtc = convertedAmount.toString();
      }
      return Text(
        convertedBtc,
        style: const TextStyle(fontSize: 20),
      );
    } else {
      return const Text(
        '',
        style: TextStyle(fontSize: 20),
      );
    }
  }

  double convertToBTC(double amount) {
    return amount / 2;
  }

  Widget _listDataItem({required String code, rate, description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(height: 5),
                Text(
                  code,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$rate",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "$description",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black45),
                  ),
                ],
              ),
            ),
            const Column(
              children: [
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black45,
                  size: 25,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
