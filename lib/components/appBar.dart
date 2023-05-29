import 'package:flutter/material.dart';

Widget appBar({required Widget menu, required String title}) {
// Widget appBar({Widget menu, String title}) {
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          menu,
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    ),
  );
}
