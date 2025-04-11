import 'package:flutter/material.dart';
import 'package:mobile/view/screen/sucess_pay_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/view/widgets/custom_button.dart';

class ErrorPay extends StatelessWidget {
  const ErrorPay({super.key});

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
                      'assets/images/error.png',
                      height: 200,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Oh no!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Something Went Wrong',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Please try again later or contact our\nsupport team for assistance below.',
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
                      const Text(
                        "Need Help?",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Contact Us",
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Retry Payment',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SucessPay()),
                      );
                    },
                    size: Size(MediaQuery.of(context).size.width, 50),
                    color: AppColors.primaryBlue,
                    borderColor: Colors.blue,
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
