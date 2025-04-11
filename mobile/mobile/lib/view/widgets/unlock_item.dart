import 'package:flutter/material.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/view/widgets/custom_button.dart';

class UnlockItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String price;
  final String discountPrice;
  final VoidCallback btn;
  final Widget? action;
  final bool checkisAdd;
  const UnlockItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.discountPrice,
    required this.checkisAdd,
    required this.btn,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.network(
          imageUrl,
          width: 50,
          height: 50,
        ),
        Column(
          children: [
            Text(
              title,
            ),
            // widget
            action ?? const SizedBox.shrink(),
          ],
        ),
        CustomButton(
          text: "Add",
          onPressed: btn,
          size: Size(80, 40),
          color: checkisAdd ? AppColors.primaryBlue : Colors.grey.shade400,
          borderColor: checkisAdd ? Colors.blue : Colors.grey,
        ),
        Column(
          children: [
            Text(
              discountPrice,
              style: TextStyle(
                fontSize: 26,
                color: Colors.black,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        )
      ],
    );
  }
}
