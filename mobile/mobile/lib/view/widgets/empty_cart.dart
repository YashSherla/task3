import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/view/screen/product_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/view/widgets/custom_button.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.cart,
              size: 120,
            ),
            SizedBox(height: 10),
            Text(
              "Empty Cart!",
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 36,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Looks Like You Haven’t \n Made Your Choice Yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            CustomButton(
              text: "Browse Store",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductScreen(),
                  ),
                );
              },
              size: Size(MediaQuery.of(context).size.width, 50),
              color: AppColors.primaryBlue,
              borderColor: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
