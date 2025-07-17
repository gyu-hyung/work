// cubit/teen_story_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice01/src/data/models/feed.dart';
import 'package:practice01/src/data/models/story.dart';

class TeenStoryState {
  final List<Feed> feeds;
  final List<Story> stories;
  final bool isFeedLoading;
  final bool isStoryLoading;

  TeenStoryState({
    required this.feeds,
    required this.stories,
    this.isFeedLoading = false,
    this.isStoryLoading = false,
  });

  TeenStoryState copyWith({
    List<Story>? stories,
    bool? isStoryLoading,
    List<Feed>? feeds,
    bool? isFeedLoading,
  }) {
    return TeenStoryState(
      stories: stories ?? this.stories,
      isStoryLoading: isStoryLoading ?? this.isStoryLoading,
      feeds: feeds ?? this.feeds,
      isFeedLoading: isFeedLoading ?? this.isFeedLoading,
    );
  }
}

class TeenStoryCubit extends Cubit<TeenStoryState> {
  TeenStoryCubit()
      : super(
          TeenStoryState(
            feeds: [],
            isFeedLoading: true,
            stories: [],
            isStoryLoading: true,
          ),
        );

  Future<void> fetchFeeds() async {
    emit(state.copyWith(isFeedLoading: true));
    // 더미 데이터
    await Future.delayed(const Duration(milliseconds: 300));
    final dummyFeeds = [
      Feed(
        userId: '12345',
        userName: "최윤서",
        userAvatar: "assets/images/ic_darcy_avartar1.png",
        images: [
          "assets/images/ic_darcy_avartar1.png",
          "assets/images/ic_darcy_avartar2.png",
        ],
        text: "길 거리 버스킹하고 있어요...",
        timeAgo: "9시간 전",
        likes: 85421796,
        comments: 58932,
        views: 747865,
      ),
      Feed(
        userId: '67890',
        userName: "이민지",
        userAvatar: "assets/images/ic_darcy_avartar2.png",
        images: [
          "assets/images/ic_darcy_avartar2.png",
          "assets/images/ic_darcy_avartar1.png",
        ],
        text: "오늘은 공연이 재미있었어요!",
        timeAgo: "3시간 전",
        likes: 1,
        comments: 1,
        views: 1,
      ),
    ];
    if (isClosed) return;
    emit(state.copyWith(feeds: dummyFeeds, isFeedLoading: false));
  }

  Future<void> fetchStories() async {
    emit(state.copyWith(isStoryLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));
    final dummyStories = [
      Story(name: "윤서1", avatar: "assets/icons/ic_marker1.png"),
      Story(name: "윤서2", avatar: "assets/icons/ic_marker2.png"),
      Story(name: "윤서3", avatar: "assets/icons/ic_marker3.png"),
      Story(name: "윤서4", avatar: "assets/icons/ic_marker4.png"),
      Story(name: "윤서5", avatar: "assets/icons/ic_marker5.png"),
      Story(name: "윤서6", avatar: "assets/icons/ic_marker6.png"),
      Story(name: "윤서7", avatar: "assets/icons/ic_marker1.png"),
      Story(name: "윤서8", avatar: "assets/icons/ic_marker2.png"),
      Story(name: "윤서9", avatar: "assets/icons/ic_marker3.png"),
    ];
    if (isClosed) return;
    emit(state.copyWith(stories: dummyStories, isStoryLoading: false));
  }
}
