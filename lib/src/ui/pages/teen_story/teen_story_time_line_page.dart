import 'package:flutter/material.dart';

class TeenStoryTimeLinePage extends StatelessWidget {
  final String userId;

  const TeenStoryTimeLinePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // userId 활용!
    return Scaffold(
      appBar: AppBar(title: Text('$userId의 타임라인')),
      body: Center(child: Text('유저 $userId 타임라인 페이지')),
    );
  }
}
