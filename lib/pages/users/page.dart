import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:test_1/states/mod_theme.dart';

import '../../models/user.dart';
import '../../router/app_router.gr.dart';

@RoutePage()
class AllUsersPage extends StatefulWidget {
  const AllUsersPage({super.key});
  @override
  State<AllUsersPage> createState() => _AllUsersPage();
}

class _AllUsersPage extends State<AllUsersPage> {
  late Future<List<User>> _future;

  @override
  void initState() {
    super.initState();
    _future = getData();
  }

  Future<List<User>> getData() async {
    var response =
        await get(Uri.https('jsonplaceholder.typicode.com', '/users'));
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>)
          .map((e) => User.fromJson(jsonEncode(e)))
          .toList();
    } else {
      throw Exception('No data');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool colorMod = true;
    return BlocProvider(
      create: (context) => ModTheme(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('List of users'),
          actions: [
            IconButton(
                icon: Icon(Icons.sunny),
                onPressed: (){
                  BlocProvider.of<ModTheme>(context).add( colorMod ? LightModEvent() : DarkModEvent());
                  colorMod = !colorMod;
                })
          ],
        ),
        body: FutureBuilder<List<User>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final user = data[index];
                return ListTile(
                  title: Text(user.username),
                  subtitle: Text(user.name),
                  onTap: () {
                    AutoRouter.of(context)
                        .navigate(UserProfileRoute(id: user.id.toString()));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
