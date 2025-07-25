import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get_it/get_it.dart';
import 'package:practice01/src/data/repositories/auth_repository.dart';
import 'package:practice01/src/data/repositories/impl/auth_repository_impl.dart';
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

  final AuthRepository authRepository = AuthRepositoryImpl();

  GetIt.instance.registerSingleton(authRepository);

  final navigatorKey = GlobalKey<NavigatorState>();
  runApp(HiteenApp(navigatorKey: navigatorKey));
}
