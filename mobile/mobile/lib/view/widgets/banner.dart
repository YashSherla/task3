import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/utils/colors.dart';

class CustomBanner extends StatelessWidget {
  final String title;
  final Color left;
  final Color right;
  final String imgerurl;
  const CustomBanner({
    super.key,
    required this.title,
    required this.left,
    required this.right,
    required this.imgerurl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            left,
            right,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border(
          bottom: BorderSide(color: Colors.blueAccent, width: 3),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.gift,
                            color: AppColors.primaryBlue,
                            size: 28,
                          ),
                          SizedBox(height: 5),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imgerurl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.money_dollar_circle,
                          color: Colors.black,
                        ),
                        Text(
                          "1000 Memo Coins",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                      child: VerticalDivider(
                        color: Colors.grey.shade50,
                        thickness: 2,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.headphones,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Priority Support",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(
                  "Get Combo Now",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
