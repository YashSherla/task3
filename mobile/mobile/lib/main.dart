import 'package:flutter/material.dart';
import 'package:mobile/provider/cart_provider.dart';
import 'package:mobile/provider/product_provider.dart';
import 'package:mobile/view/screen/product_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
        fontFamily: 'Fredoka',
      ),
      home: ProductScreen(),
    );
  }
}
