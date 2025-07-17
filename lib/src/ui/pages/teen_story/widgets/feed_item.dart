import 'package:flutter/material.dart';
import 'package:practice01/src/data/models/feed.dart';

class FeedItem extends StatefulWidget {
  final Feed feed;
  // const FeedItem({super.key, required this.feed});
  const FeedItem({super.key, required this.feed});

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  int _currentPage = 0;
  late final PageController _pageController;

  final List<String> reactionAvatars = [
    'assets/icons/ic_marker1.png',
    'assets/icons/ic_marker2.png',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feed = widget.feed;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(feed),
        const SizedBox(height: 12),
        _buildImageSlider(feed),
        const SizedBox(height: 12),
        _buildPageIndicator(feed),
        const SizedBox(height: 12),
        _buildStatsRow(feed),
        const SizedBox(height: 8),
        _buildReactionsRow(),
        const SizedBox(height: 8),
        _buildFeedText(feed),
        const SizedBox(height: 4),
        _buildTimestamp(feed),
        const SizedBox(height: 32),
      ],
    );
  }

  // 1. 프로필 헤더
  Widget _buildHeader(Feed feed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(feed.userAvatar),
          ),
          const SizedBox(width: 8),
          Text(
            feed.userName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Ink(
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  // 2. 슬라이더(이미지 + 3/5)
  Widget _buildImageSlider(Feed feed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          height: MediaQuery.of(context).size.width * 1.25,
          color: const Color(0XFF5709FF),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: feed.images.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return Image.asset(
                    feed.images[index],
                    fit: BoxFit.contain,
                    width: double.infinity,
                  );
                },
              ),
              // 3/5 표시
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: const BoxDecoration(
                    color: Color(0XFF212121),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Text(
                    '${_currentPage + 1} / ${feed.images.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 3. 도트 페이지 인디케이터
  Widget _buildPageIndicator(Feed feed) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(feed.images.length, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color:
                  _currentPage == index ? Colors.grey[800] : Colors.grey[300],
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }

  // 4. 좋아요/댓글/조회수
  Widget _buildStatsRow(Feed feed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.thumb_up_alt_outlined, size: 20),
          const SizedBox(width: 4),
          Text(feed.likes.toString()),
          const SizedBox(width: 16),
          const Icon(Icons.chat_bubble_outline, size: 20),
          const SizedBox(width: 4),
          Text(feed.comments.toString()),
          const SizedBox(width: 16),
          const Icon(Icons.remove_red_eye_outlined, size: 20),
          const SizedBox(width: 4),
          Text(feed.views.toString()),
        ],
      ),
    );
  }

  // 5. 리액션 원형 아바타
  Widget _buildReactionsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 36,
        child: Stack(
          children: [
            for (int i = 0; i < reactionAvatars.length; i++)
              Positioned(
                left: i * 24,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage(reactionAvatars[i]),
                  ),
                ),
              ),
            Positioned(
              left: reactionAvatars.length * 24,
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.black,
                child: Icon(Icons.chevron_right, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 6. 피드 텍스트
  Widget _buildFeedText(Feed feed) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '길 거리 버스킹하고 있어요 길 거리 버스킹하고 있어요 길 거리 버스킹하고 있어요 길 거리 버스킹...',
              style: TextStyle(fontSize: 14),
            ),
            TextSpan(
              text: ' [더보기]',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // 7. 시간
  Widget _buildTimestamp(Feed feed) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        '9시간 전',
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}
