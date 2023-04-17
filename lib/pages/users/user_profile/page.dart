import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/user.dart';
import '../../../models/posts.dart';

@RoutePage()
class UserProfilePage extends StatefulWidget {
  final String id;
  const UserProfilePage({
    super.key,
    @PathParam() required this.id,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Future<User> _future;
  Future<User> getData() async {
    var response = await http
        .get(Uri.https('jsonplaceholder.typicode.com', '/users/${widget.id}'));
    if (response.statusCode == 200) {
      return User.fromJson(response.body);
    } else {
      throw Exception('No data');
    }
  }

  late Future<List<Posts>> _posts;
  Future<List<Posts>> getPostsOfUser() async {
    var response = await http
        .get(Uri.https('jsonplaceholder.typicode.com', '/posts?userId=${widget.id}'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>)
        .map((e) => Posts.fromJson(e))
        .toList();
    } else {
      throw Exception('No data');
    }
  }


  @override
  void initState() {
    _future = getData();
    _posts = getPostsOfUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        final posts = _posts as List<Posts>;
        final data = snap.data!;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(data.username),
          ),
          body: Center(
            child: SizedBox(
              width: 600,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(fontSize: 35),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email: ${data.email}'),
                          Text('Phone: ${data.phone}'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('WebSite: ${data.website}'),
                          Text('Address: ${data.address.city} ${data.address.suite} ${data.address.street}'),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Text(
                      'Company',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Text('Name: ${data.company.name}',
                      style: const TextStyle(
                        fontSize: 20,
                      )),
                  Text('BS: ${data.company.bs}',
                      style: const TextStyle(
                        fontSize: 20,
                      )),
                  Text(data.company.catchPhrase,
                      style: const TextStyle(
                          fontSize: 20, fontStyle: FontStyle.italic)),
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                      child: Text(
                        'Posts',
                        style: TextStyle(fontSize: 30),
                      ),
                  ),
                  ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index){
                      final post = posts[index];
                      return ListTile(
                        title: Text(post.title ?? 'Fuck'),
                        subtitle: Text(post.body ?? 'Fuck 2'),
                        onTap: (){},
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
