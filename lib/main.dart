import 'package:flutter/material.dart';
import 'package:inquiry/response/response.dart';
import 'package:inquiry/screens/inquires.dart';
import 'package:inquiry/screens/instant_rates_screen.dart';
import 'package:inquiry/screens/more.dart';
import 'package:inquiry/screens/shipments_screen.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  late Future<Inquires> postUsers;
  int _currentIndex = 0;
  final tabs = [
    const Center(child: Inquries()),
    const Center(child: InstantRatesScreen()),
    const Center(child: ShipmentsScreen()),
    const Center(child: MoreScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              label: 'Inquires', icon: Icon(Icons.message_outlined)),
          BottomNavigationBarItem(
            label: 'Instant Rates',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
              label: 'Shipments', icon: Icon(Icons.directions_boat_sharp)),
          BottomNavigationBarItem(label: 'more', icon: Icon(Icons.more_vert))
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: tabs[_currentIndex],
    );
  }
}
