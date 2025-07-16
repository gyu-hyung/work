import 'package:flutter/material.dart';
import 'package:practice01/src/ui/pages/teen_story/widgets/feed_item.dart';
import 'package:practice01/src/ui/widgets/hiteen_bottom_banner.dart';
import 'package:practice01/src/ui/widgets/hiteen_logo_app_bar.dart';

class TeenStoryPage extends StatelessWidget {
  const TeenStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HiteenLogoAppBar(),
                  _buildStoryList(),
                  const FeedItem(),
                  const FeedItem(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HiteenBottomBanner(),
    );
  }
}

Widget _buildStoryList() {
  final storyUsers = [
    {'name': '윤서', 'avatar': 'assets/icons/ic_marker1.png'},
    {'name': '민지', 'avatar': 'assets/icons/ic_marker2.png'},
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: storyUsers.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final user = storyUsers[index];
          return Column(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(user['avatar']!),
              ),
            ],
          );
        },
      ),
    ),
  );
}
