import 'package:flutter/material.dart';

class BillingRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? color;
  const BillingRow({
    required this.title,
    required this.value,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: color ?? Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: color ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
