import 'package:flutter/material.dart';

class DetailPage2 extends StatelessWidget {
  const DetailPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('상세 페이지 1')),
      body: Center(
        child: Text(
          '여기에 지도 및 캐릭터 UI 구성 예정',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
