
// ignore_for_file: unused_element

import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String text;

  const LabelText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        color: Color.fromARGB(255, 157, 206, 249),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}