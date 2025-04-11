import 'package:flutter/material.dart';
import 'package:mobile/view/screen/product_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/view/widgets/custom_button.dart';

class SucessPay extends StatelessWidget {
  const SucessPay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/sucess.png',
                      height: 200,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Payment Successful!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'All Aboard! Your Payment Has Been Done. \n You Receive A Confirmation Mail Shortly',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                                color: AppColors.primaryBlue, width: 3),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Home",
                            style: TextStyle(color: AppColors.primaryBlue),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomButton(
                        text: 'Explore Shop',
                        onPressed: () {},
                        size: Size(220, 50),
                        color: AppColors.primaryBlue,
                        borderColor: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
