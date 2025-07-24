import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//GRJeOmDfcX78MWfp379R03ZGiOOQfwWjqOPvQUFF
  await FlutterNaverMap().init(
      clientId: 'rk91kmtpea',
      onAuthFailed: (ex) {
        switch (ex) {
          case NQuotaExceededException(:final message):
            print("사용량 초과 (message: $message)");
            break;
          case NUnauthorizedClientException() ||
                NClientUnspecifiedException() ||
                NAnotherAuthFailedException():
            print("인증 실패: $ex");
            break;
        }
      });

  final navigatorKey = GlobalKey<NavigatorState>();
  runApp(HiteenApp(navigatorKey: navigatorKey));
}
