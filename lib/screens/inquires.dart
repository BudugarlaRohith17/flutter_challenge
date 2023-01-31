import 'package:flutter/material.dart';
import 'package:inquiry/screens/shipments_screen.dart';
import '../api_client/network.dart';
import '../response/response.dart';

class Inquries extends StatefulWidget {
  const Inquries({Key? key}) : super(key: key);

  @override
  State<Inquries> createState() => _InquriesState();
}

class _InquriesState extends State<Inquries> {
  final TextEditingController _controller = TextEditingController();

  void openDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Search Inquiry'),
            content: TextField(
              controller: _controller,
              decoration:
                  const InputDecoration(hintText: 'Enter Inquiry Number'),
            ),
            actions: [
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        var tempList = _searchList!
                            .where((inquiry) =>
                                inquiry.inquiryNumber == _controller.text)
                            .toList();
                        print(tempList.length);
                      },
                      child: const Text('submit'))),
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

  List<Inquiries>? _searchList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inquiry'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                openDialog();
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.filter_alt_rounded)),
          PopupMenuButton(itemBuilder: (context) {
            return [
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
      body: Center(
        child: FutureBuilder(
          future: postUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _searchList = snapshot.data?.inquiries;
              return ListView.builder(
                itemCount: snapshot.data?.inquiries?.length,
                itemBuilder: (context, index) {
                  String inquiryResult =
                      snapshot.data!.inquiries![index].inquiryNumber.toString();
                  String originResult = snapshot
                      .data!.inquiries![index].searchData!.originPort!.portCode
                      .toString();
                  String destinationResult = snapshot.data!.inquiries![index]
                      .searchData!.destinationPort!.portCode
                      .toString();
                  String createdAtResult = snapshot
                      .data!.inquiries![index].salesUser!.createdAt
                      .toString()
                      .split(' ')
                      .first;
                  String salesPersonResult = snapshot
                      .data!.inquiries![index].salesUser!.userLastName!
                      .toString();
                  var colorCode = snapshot
                      .data!.inquiries![index].currentStatus!.colorCode!
                      .replaceAll("#", "0xff");

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(

                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black,)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(inquiryResult,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    )),
                                Container(
                                  width: 75.0,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(colorCode)),
                                    borderRadius: const BorderRadius.horizontal(
                                        left: Radius.circular(50)),
                                  ),
                                  child: Text(
                                    snapshot.data!.inquiries![index]
                                        .currentStatus!.status!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      originResult,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: const [
                                    Icon(Icons.directions_boat),
                                    Text(
                                        '-------------------------------------'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(destinationResult,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),

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
