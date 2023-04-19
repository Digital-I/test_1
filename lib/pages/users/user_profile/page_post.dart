import 'dart:convert';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:test_1/models/post.dart';
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

  late Future<Map<String, String>> _post;
  Future<Map<String, String>> getPostOfUser() async {
    var response = await http
        .get(Uri.https('jsonplaceholder.typicode.com', '/posts/${widget.id}', ));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
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
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            final post = snap.data!;
            return Column(
              children: [
                Text(post['title'] ?? ''),
                Text(post['body'] ?? ''),
              ],
            );
          },
        )
      ),
    );
  }
}