import 'package:flutter/material.dart';
import 'package:inquiry/response/response.dart';
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
            return const [
              PopupMenuItem(
                value: 0,
                child: Text('Settings'),
              ),
              PopupMenuItem(
                value: 1,
                child: Text('Shipments'),
              ),
              PopupMenuItem(
                value: 2,
                child: Text('Inquiries'),
              ),
            ];
          }),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Colors.black12,
            labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontWeight: FontWeight.w300, fontSize: 12))),
        child: NavigationBar(
          onDestinationSelected: (index) {

          },
          height: 60,
          selectedIndex: 1,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.search_rounded), label: 'Instant Rates'),
            NavigationDestination(
                icon: Icon(Icons.mail_sharp), label: 'Inquires'),
            NavigationDestination(
                icon: Icon(Icons.directions_boat_filled), label: 'Shipments'),
            NavigationDestination(icon: Icon(Icons.more_vert), label: 'More'),
          ],
        ),
      ),
      body: //screens[index],

          Center(
        child: FutureBuilder(
          future: postUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              res = snapshot.data?.inquiries;
              return ListView.builder(
                itemCount: snapshot.data?.inquiries?.length,
                itemBuilder: (context, index) {
                  String inquiryResult =
                      snapshot.data!.inquiries![index].inquiryNumber.toString();
                  String originResult = snapshot
                      .data!.inquiries![index].searchData!.originPort!.portname!
                      .toString();
                  String destinationResult = snapshot.data!.inquiries![index]
                      .searchData!.destinationPort!.portname!
                      .toString();
                  String createdAtResult = snapshot
                      .data!.inquiries![index].salesUser!.createdAt
                      .toString()
                      .split(' ')
                      .first;
                  String salesPersonResult = snapshot
                      .data!.inquiries![index].salesUser!.userLastName!
                      .toString();
                  var colorCode = snapshot.data!.inquiries![index]
                      .currentStatus!.colorCode!.hashCode;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(inquiryResult,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    )),
                                Card(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(),
                                  ),
                                  //color: Colors.black12,
                                  child: Text(
                                    snapshot.data!.inquiries![index]
                                        .currentStatus!.status
                                        .toString(),
                                    style: TextStyle(
                                        color:
                                            Color(colorCode).withOpacity(1.0)),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      originResult,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                        Icons.directions_boat_filled_outlined),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(destinationResult,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const Icon(
                                      Icons.directions_boat_filled_rounded,
                                      color: Colors.blueGrey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const Text('Created By'),
                                    Text(
                                      snapshot.data!.inquiries![index].user!
                                              .userFirstName
                                              .toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        const Text('Created On'),
                                        Text(
                                          createdAtResult,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: const [
                                        Text('Company'),
                                        Text('Freightify')
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        const Text('Sales Person'),
                                        Text(salesPersonResult)
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error})');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
