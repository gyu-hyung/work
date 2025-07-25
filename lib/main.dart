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
          case NQuotaExceededException():
            break;
          case NUnauthorizedClientException() ||
                NClientUnspecifiedException() ||
                NAnotherAuthFailedException():
            break;
        }
      });

  final navigatorKey = GlobalKey<NavigatorState>();
  runApp(HiteenApp(navigatorKey: navigatorKey));
}
