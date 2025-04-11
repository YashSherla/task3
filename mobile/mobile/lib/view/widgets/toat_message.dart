import 'package:flutter/material.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';

const Duration kToastDuration = Duration(milliseconds: 3000);
void showToast(
    BuildContext context, String message, Color color, IconData icon) {
  DelightToastBar(
    builder: (context) => ToastCard(
      leading: Icon(
        icon,
        size: 30,
        color: color,
      ),
      title: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          color: color,
        ),
      ),
    ),
  ).show(context);
  Future.delayed(kToastDuration, () {
    DelightToastBar.removeAll();
  });
}
