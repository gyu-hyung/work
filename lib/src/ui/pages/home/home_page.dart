import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      {'title': '틴 나우', 'route': '/teen_now'},
      {'title': '틴 나우_bak', 'route': '/teen_now_back'},
      {'title': '틴 스토리', 'route': '/teen_story'},
      {'title': '틴 픽', 'route': '/teen_pick'},
      {'title': '틴 플레이', 'route': '/teen_play'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('UI')),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return ListTile(
            title: Text(page['title'] as String),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              context.push(page['route'] as String);
            },
          );
        },
      ),
    );
  }
}
