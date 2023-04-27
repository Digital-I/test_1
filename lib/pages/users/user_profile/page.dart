import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:auto_route/auto_route.dart';
import 'package:test_1/router/app_router.gr.dart';

import '../../../models/user.dart';
import '../../../models/post.dart';

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

  @override
  void initState() {
    _future = getData();
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
                          Text(
                            'Address: ${data.address.city} ${data.address.suite} ${data.address.street}',
                          ),
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
                  Text(
                    'Name: ${data.company.name}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'BS: ${data.company.bs}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    data.company.catchPhrase,
                    style: const TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                    child: Text(
                      'Posts',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  ListPosts(id: widget.id),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ListPosts extends StatefulWidget {
  final String id;
  const ListPosts({
    super.key,
    required this.id,
  });

  @override
  State<ListPosts> createState() => _ListPosts();
}

class _ListPosts extends State<ListPosts> {
  late Future<List<Post>> _posts;
  Future<List<Post>> getPostsOfUser() async {
    final response = await http.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts/',
        {'userId': widget.id},
      ),
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>)
          .map((e) => Post.fromJson(e))
          .toList();
    } else {
      throw Exception(response.statusCode.toString());
    }
  }

  @override
  void initState() {
    _posts = getPostsOfUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: _posts,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done ||
              snap.data == null ||
              snap.data!.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          final posts = snap.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title ?? ''),
                subtitle: Text(
                  post.body ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                onTap: () {
                  AutoRouter.of(context)
                      .navigate(UserPostRoute(id: post.id.toString()));
                },
              );
            },
          );
        },
      ),
    );
  }
}
