import 'package:flutter/material.dart';

class LogicScreen extends StatefulWidget {
  const LogicScreen({super.key});

  @override
  State<LogicScreen> createState() => _LogicScreenState();
}

class _LogicScreenState extends State<LogicScreen> {
  late String _pinCheck = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _pinCheck = convertToBTC(value);
              });
            },
            decoration: const InputDecoration(
              labelText: 'Input PIN Code',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _pinCheck,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}

String convertToBTC(String pincode) {
  // ตรวจสอบความยาวของ pincode มากกว่าหรือเท่ากับ 6
  if (pincode.length < 6) {
    return "จำนวนตัวเลขจะต้องมากกว่าหรือเท่ากับ 6";
  }

  // ตรวจสอบไม่ให้มีเลขซ้ำติดกันเกิน 2 ตัว
  for (int i = 0; i < pincode.length - 2; i++) {
    if (pincode[i] == pincode[i + 1] && pincode[i + 1] == pincode[i + 2]) {
      return "ไม่สามารถเพิ่มเลขซ้ำติดกันเกิน 2 ตัว";
    }
  }

  // ตรวจสอบไม่ให้มีเลขเรียงกันเกิน 2 ตัว
  for (int i = 0; i < pincode.length - 2; i++) {
    int currentDigit = int.parse(pincode[i]);
    int nextDigit = int.parse(pincode[i + 1]);
    int secondNextDigit = int.parse(pincode[i + 2]);

    if (currentDigit + 1 == nextDigit && nextDigit + 1 == secondNextDigit) {
      return "ไม่สามารถเพิ่มเลขเรียงกันเกิน 2 ตัว";
    }
  }

  // ตรวจสอบไม่ให้มีเลขซ้ำชุดกันเกิน 2 ชุด
  Map<String, int> digitCount = {};
  int numset = 0;
  for (int i = 0; i < pincode.length; i++) {
    String digit = pincode[i];
    digitCount[digit] = digitCount[digit] != null ? digitCount[digit]! + 1 : 1;
    if (digitCount[digit]! == 2) {
      numset = numset + 1;
      if (numset > 2) {
        return "ไม่สามารถเพิ่มเลขเลขซ้ำชุดกันเกิน 2 ชุด";
      }
    }
  }

  return "รหัสถูกต้อง";
}
