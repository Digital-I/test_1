import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class UserPostPage extends StatefulWidget {
  final String id;
  const UserPostPage({
    super.key,
    @PathParam() required this.id,
  });

  @override
  State<UserPostPage> createState() => _UserPostPageState();
}

class _UserPostPageState extends State<UserPostPage> {

  late Future<Map<String, dynamic>> _post;
  Future<Map<String, dynamic>> getPostOfUser() async {
    var response = await http
        .get(Uri.https('jsonplaceholder.typicode.com', '/posts/${widget.id}', ));
    if (response.statusCode == 200) {
      //result.map((e) => e as Map<String, dynamic>).toList();
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(response.statusCode.toString());
    }
  }

  @override
  void initState() {
    _post = getPostOfUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your post'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _post,
          builder: (context, snap){
            if (snap.connectionState != ConnectionState.done || snap.data == null || snap.data!.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            final post = snap.data!;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(post['title'] ?? '', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                ),
                Text(post['body'] ?? '', style: const TextStyle(fontSize: 20),),
              ],
            );
          },
        )
      ),
    );
  }
}