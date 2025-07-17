import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice01/src/ui/pages/teen_story/cubit/teen_story_cubit.dart';
import 'package:practice01/src/ui/pages/teen_story/widgets/feed_item.dart';
import 'package:practice01/src/ui/widgets/hiteen_bottom_banner.dart';
import 'package:practice01/src/ui/widgets/hiteen_logo_app_bar.dart';

class TeenStoryPage extends StatelessWidget {
  const TeenStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TeenStoryCubit()
        ..fetchFeeds()
        ..fetchStories(),
      child: const TeenStoryPageView(),
    );
  }
}

class TeenStoryPageView extends StatelessWidget {
  const TeenStoryPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHiteenLogoAppBar(),
                _buildStoryList(),
                _buildFeedList(),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: _buildBottomBanner(),
    );
  }

  Widget _buildHiteenLogoAppBar() {
    return const HiteenLogoAppBar();
  }

  Widget _buildStoryList() {
    return BlocBuilder<TeenStoryCubit, TeenStoryState>(
      builder: (context, state) {
        if (state.isStoryLoading) {
          // 스켈레톤 보여줌
          return buildStoryListSkeleton();
        }
        final storyUsers = state.stories;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            height: 100,
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
                      backgroundImage: AssetImage(user.avatar),
                    ),
                    const SizedBox(height: 6),
                    Text(user.name, style: const TextStyle(fontSize: 13)),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  //스토리 스켈러톤
  Widget buildStoryListSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 12,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 32,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeedList() {
    return BlocBuilder<TeenStoryCubit, TeenStoryState>(
      builder: (context, state) {
        if (state.isFeedLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Column(
          children: state.feeds.map((feed) => FeedItem(feed: feed)).toList(),
        );
      },
    );
  }

  Widget _buildBottomBanner() {
    return const HiteenBottomBanner();
  }
}
