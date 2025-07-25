import 'package:equatable/equatable.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class TeenNowFriend extends Equatable {
  const TeenNowFriend({
    required this.nickname,
    required this.mood,
    required this.address,
    required this.profileImageUrl,
    this.location = const NLatLng(35.1796, 126.9027),
  });

  final String nickname;
  final String mood;
  final String address;
  final String profileImageUrl;
  final NLatLng location;

  static List<TeenNowFriend> sampleList = [
    const TeenNowFriend(
      nickname: '눈물의달력1',
      mood: '😍 오늘도 맑음1',
      address: '광주 북구 오룡동1',
      profileImageUrl: 'assets/images/ic_darcy_avartar1.png',
      location: NLatLng(35.1896, 126.9027),
    ),
    const TeenNowFriend(
      nickname: '눈물의달력2',
      mood: '😍 오늘도 맑음2',
      address: '광주 북구 오룡동2',
      profileImageUrl: 'assets/images/ic_darcy_avartar1.png',
      location: NLatLng(35.1796, 126.9027),
    ),
    const TeenNowFriend(
      nickname: '눈물의달력3',
      mood: '😍 오늘도 맑음3',
      address: '광주 북구 오룡동3',
      profileImageUrl: 'assets/images/ic_darcy_avartar1.png',
      location: NLatLng(35.1696, 126.9027),
    ),
  ];

  @override
  List<Object?> get props => [nickname, mood, address, profileImageUrl];
}
