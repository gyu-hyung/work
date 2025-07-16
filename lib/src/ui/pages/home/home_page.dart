import 'package:flutter/material.dart';
import '../teen_now/teen_now_page.dart';
import '../teen_story/teen_story_page.dart';
import '../detail_page3.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      {'title': '캐릭터 상세 화면 1', 'widget': const TeenNowPage()},
      {'title': '캐릭터 상세 화면 2', 'widget': const TeenStoryPage()},
      {'title': '캐릭터 상세 화면 3', 'widget': const DetailPage3()},
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => page['widget'] as Widget),
              );
            },
          );
        },
      ),
    );
  }
}
