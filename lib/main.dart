import 'package:flutter/material.dart';
import 'package:inquiry/response/response.dart';
import 'package:inquiry/screens/inquires.dart';
import 'package:inquiry/screens/instant_rates_screen.dart';
import 'package:inquiry/screens/more.dart';
import 'package:inquiry/screens/shipments_screen.dart';

import 'api_client/network.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void openDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Search Inquiry'),
            content: TextField(
              onChanged: (value) {},
              decoration:
              const InputDecoration(hintText: 'Enter Inquiry Number'),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Submit')),
            ],
          );
        });
  }

  late Future<Inquires> postUsers;
  @override
  void initState() {
    super.initState();
    postUsers = ApiClient().fetchUsers();
  }

  late List<Inquiries>? res;

  int _currentIndex=0;
  final tabs =[
    const Center(child: Inquries()),
    const Center(child: InstantRatesScreen()),
    const Center(child: ShipmentsScreen()),
    const Center(child: MoreScreen()),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inquiry'),
        centerTitle: true,
        backgroundColor: Colors.black12,
        actions: [
          IconButton(
              onPressed: () {
                openDialog();
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.filter_alt_rounded)),
          PopupMenuButton(itemBuilder: (context) {
            return  [
              const PopupMenuItem(
                value: 0,
                child: Text('Settings'),
              ),
              PopupMenuItem(
                value: 1,
                child: const Text('Shipments'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShipmentsScreen()));
                },
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('Inquiries'),
              ),
            ];
          }),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items:  const [

          BottomNavigationBarItem(
              label: 'Inquires', icon: Icon(Icons.message_outlined)),
          BottomNavigationBarItem(
            label: 'Instant Rates', icon: Icon(Icons.search),),
          BottomNavigationBarItem(
              label: 'Shipments', icon: Icon(Icons.directions_boat_sharp)),

          BottomNavigationBarItem(label: 'more', icon: Icon(Icons.more_vert))
        ],
        onTap: (index){
          setState(() {
            _currentIndex=index;
          });
        },
      ),
      body: tabs[_currentIndex],
    );
  }
}
