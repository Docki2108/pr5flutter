import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Screen extends StatelessWidget {
  const Screen({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Text(
          text.toString(),
          style: TextStyle(fontSize: 40),
        )),
      ),
    );
  }
}
