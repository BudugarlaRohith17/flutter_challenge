import 'package:flutter/material.dart';

import '../api_client/network.dart';
import '../response/response.dart';

class InstantRatesScreen extends StatefulWidget {
  const InstantRatesScreen({Key? key}) : super(key: key);

  @override
  State<InstantRatesScreen> createState() => _InstantRatesScreenState();
}

class _InstantRatesScreenState extends State<InstantRatesScreen> {
  late Future<Inquires> postUsers;
  @override
  void initState() {
    super.initState();
    postUsers = ApiClient().fetchUsers();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Instant_Rates'),

      ),
      body: FutureBuilder(
        future: postUsers,
        builder: (context,snapshot){
          return ListView.builder(
            itemCount: snapshot.data!.inquiries!.length,
            itemBuilder: (context,index){
              return Card(
                child: Text(snapshot.data!.inquiries![index].salesUser!.email!.toString()),
              );
            }
          );
        }

      ),

    );
  }
}

