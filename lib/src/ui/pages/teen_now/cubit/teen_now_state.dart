import 'package:equatable/equatable.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:practice01/src/data/models/teen_friend.dart';

final class TeenNowState extends Equatable {
  const TeenNowState({
    this.profileImageUrl = '',
    this.userId = '',
    this.nickname = '',
    this.uid = '',
    this.mood = '',
    this.address = '',
    this.location = const NLatLng(35.1796, 126.9027),
    this.friendList = const [],
  });

  final String profileImageUrl;
  final String userId;
  final String nickname;
  final String uid;
  final String mood;
  final String address;
  final NLatLng location;
  final List<TeenNowFriend> friendList;

  @override
  List<Object?> get props => [
        profileImageUrl,
        userId,
        nickname,
        uid,
        mood,
        address,
        location,
        friendList,
      ];
}
