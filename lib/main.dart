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
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  var text = "None";
  List<dynamic> usersList = [];

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> future = getData();
    future.then((data) {
      debugPrint("Данные получены");
      usersList = data;
      //setState(() {});
    });

    return Scaffold(
      appBar: AppBar(
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
        title: Text(data["username"]),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Name: ${data["name"]}"),
            Text("Email: ${data["email"]}"),
            Text("Phone: ${data["phone"]}"),
            Text("WebSite: ${data["website"]}"),
            Text("Work company: ${data["company"]["name"]}"),
            Text("BS: ${data["company"]["bs"]}"),
            Text("Catch phrase: ${data["company"]["catchPhrase"]}", style: const TextStyle(fontStyle: FontStyle.italic)),
            Text("Phone: ${data["phone"]}"),
            Text("Address: ${data["address"]["city"]} ${data["address"]["suite"]} ${data["address"]["street"]}"),
          ],
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