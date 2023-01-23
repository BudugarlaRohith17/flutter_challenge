import 'package:flutter/material.dart';

class ShipmentsScreen extends StatefulWidget {
  const ShipmentsScreen({Key? key}) : super(key: key);

  @override
  State<ShipmentsScreen> createState() => _ShipmentsScreenState();
}

class _ShipmentsScreenState extends State<ShipmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipments'),
      ),
    );
  }
}
