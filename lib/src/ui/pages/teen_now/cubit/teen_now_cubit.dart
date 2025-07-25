import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:practice01/src/data/repositories/auth_repository.dart';
import 'package:practice01/src/ui/pages/teen_now/cubit/teen_now_state.dart';

class TeenNowCubit extends Cubit<TeenNowState> {
  TeenNowCubit({
    required this.authRepository,
  }) : super(
          const TeenNowState(
            profileImageUrl: '',
            userId: '',
            nickname: '',
            uid: '',
            mood: '',
            address: '',
            location: NLatLng(0.0, 0.0),
            friendList: [],
          ),
        );

  final AuthRepository authRepository;

  void onStarted() async {
    print('TeenNowCubit.onStarted');
    const Duration(seconds: 2);
    final friendList = await authRepository.fetchFriendsSample();
    emit(
      TeenNowState(
        profileImageUrl: 'assets/images/ic_darcy_avartar1.png',
        userId: 'kkyh123',
        nickname: '눈물의달력',
        uid: 'uid_001',
        mood: '오늘도 맑음',
        address: '광주 북구 오룡동',
        location: const NLatLng(35.1796, 126.9027),
        friendList: friendList,
      ),
    );
  }
}
