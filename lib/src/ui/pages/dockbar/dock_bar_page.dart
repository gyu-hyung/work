import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class DockBarPage extends StatefulWidget {
  const DockBarPage({super.key});

  @override
  State<DockBarPage> createState() => _DockBarPageState();
}

class _DockBarPageState extends State<DockBarPage> {
  @override
  Widget build(BuildContext context) {
    return const DockBarPageView();
  }
}

class DockBarPageView extends StatelessWidget {
  const DockBarPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeOutCubic,
        backgroundColor: Colors.blueAccent,
        items: const <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
      body: Container(color: Colors.blueAccent),
    );
  }
}
