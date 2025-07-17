import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

class HiteenApp extends StatefulWidget {
  const HiteenApp({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<HiteenApp> createState() => _HiteenAppState();
}

class _HiteenAppState extends State<HiteenApp> {
  late final GoRouter _router;

  @override
  void initState() {
    _router = GoRouter(
      routes: routes(widget.navigatorKey),
      navigatorKey: widget.navigatorKey,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo UI',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
        ),
      ),
    );
  }
}
