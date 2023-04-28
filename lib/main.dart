import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_1/bloc/mod_theme_bloc.dart';
import 'package:test_1/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppRouter _router;
  @override
  void initState() {
    _router = AppRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModThemeBloc(),
      child: BlocBuilder<ModThemeBloc, ModThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: _router.config(),
            debugShowCheckedModeBanner: false,
            title: 'Flutter App',
            theme: ThemeData(
              colorScheme: state.colorScheme,
              useMaterial3: false,
            ),
          );
        },
      ),
    );
  }
}
