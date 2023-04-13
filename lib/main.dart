import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter First App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _CardsUsers();
}

class _CardsUsers extends State<MyHomePage> {
  List<dynamic> usersList = [];

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> future = getData();
    future.then((data) => usersList = data );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("List of users"),
      ),
      body: ListView(
        children: [
          for (var user in usersList)
            ListTile(
              title: Text(user["username"]),
              subtitle: Text(user["name"]),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfile(data: user))
                );
              },
            )
        ],
      ),
    );
  }
}


class UserProfile extends StatelessWidget {
  const UserProfile({super.key, required this.data});
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(data["username"]),
      ),
      body: Center(
        child: Container(
          width: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${data["name"]}", style: const TextStyle(fontSize: 35),),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email: ${data["email"]}"),
                        Text("Phone: ${data["phone"]}"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("WebSite: ${data["website"]}"),
                        Text("Address: ${data["address"]["city"]} ${data["address"]["suite"]} ${data["address"]["street"]}"),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text("Company", style: TextStyle(fontSize: 30),),
              ),
              Text("Name: ${data["company"]["name"]}", style: const TextStyle(fontSize: 20,)),
              Text("BS: ${data["company"]["bs"]}", style: const TextStyle(fontSize: 20,)),
              Text("${data["company"]["catchPhrase"]}", style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<dynamic>> getData() async {
  var response = await http.get(Uri.https('jsonplaceholder.typicode.com', '/users'));
  if (response.statusCode == 200) {
    return convert.jsonDecode(response.body) as List<dynamic>;
  } else {
    throw Exception("No data");
  }
}