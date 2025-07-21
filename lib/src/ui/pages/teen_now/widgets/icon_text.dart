import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool primary;

  const IconText(
      {super.key,
      required this.icon,
      required this.label,
      required this.primary});

  @override
  Widget build(BuildContext context) {
    final Color color =
        primary ? const Color(0xFF784FFF) : const Color(0xFF212121);

    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: color),
        ),
      ],
    );
  }
}
