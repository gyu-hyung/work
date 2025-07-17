import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice01/src/ui/pages/detail_page3.dart';
import 'package:practice01/src/ui/pages/home/home_page.dart';
import 'package:practice01/src/ui/pages/teen_now/teen_now_page.dart';
import 'package:practice01/src/ui/pages/teen_story/teen_story_page.dart';
import 'package:practice01/src/ui/pages/teen_story/teen_story_time_line_page.dart';

List<RouteBase> routes(GlobalKey<NavigatorState> navigatorKey) {
  return [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/teen_now',
      builder: (context, state) => const TeenNowPage(),
    ),
    GoRoute(
      path: '/teen_story',
      builder: (context, state) => const TeenStoryPage(),
      routes: [
        GoRoute(
          path: ':userId',
          builder: (context, state) {
            final userId = state.pathParameters['userId']!;
            return TeenStoryTimeLinePage(userId: userId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/detail3',
      builder: (context, state) => const DetailPage3(),
    ),
    // 여기서 계속 라우트 확장 가능!
  ];
}
