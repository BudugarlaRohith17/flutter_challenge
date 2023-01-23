import 'package:flutter/material.dart';

class InstantRatesScreen extends StatefulWidget {
  const InstantRatesScreen({Key? key}) : super(key: key);

  @override
  State<InstantRatesScreen> createState() => _InstantRatesScreenState();
}

class _InstantRatesScreenState extends State<InstantRatesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
      ),
    );
  }
}
