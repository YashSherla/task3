import 'dart:developer';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/provider/cart_provider.dart';
import 'package:mobile/provider/product_provider.dart';
import 'package:mobile/view/screen/checkout_screen.dart';
import 'package:mobile/view/screen/product_detail_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/view/widgets/banner.dart';
import 'package:mobile/view/widgets/toat_message.dart';
import 'package:mobile/view/widgets/image_carousel.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Widget> item = [
    const CustomBanner(
      title: "Get Bonus Gift on\nPurchase of Physics Combo",
      left: Color(0xFF7190FF),
      right: Color(0xFFFF7171),
      imgerurl: 'assets/images/physics.png',
    ),
    const CustomBanner(
      title: "Get Bonus Gift on\nPurchase of Chemistry Combo",
      left: Color(0xFF7190FF),
      right: Color(0xFFFFD771),
      imgerurl: 'assets/images/physics.png',
    ),
    const CustomBanner(
      title: "Get Bonus Gift on\nPurchase of Biology Combo",
      left: Color(0xFF7190FF),
      right: Color(0xFF85FF71),
      imgerurl: 'assets/images/physics.png',
    ),
  ];
  List<String> sub = [
    "Biology",
    "Chemistry",
    "Physics",
    "Notes",
  ];
  int clickIndex = 0;
  int btcurrentIndex = 0;
  bool isSwitched = false;
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).productFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 2),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: btcurrentIndex,
          selectedItemColor: AppColors.primaryBlue,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              btcurrentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                size: 32,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.cart,
                size: 32,
              ),
              label: "Store",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.doc_checkmark,
                size: 32,
              ),
              label: "Test",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.settings,
                size: 32,
              ),
              label: "Settings",
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Book Store",
          style: TextStyle(
            fontFamily: 'Fredoka',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Checkout(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  size: 32,
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AnimatedToggleSwitch<bool>.size(
                  height: 40,
                  current: isSwitched,
                  values: [false, true],
                  iconOpacity: 1,
                  indicatorSize: const Size.fromWidth(100),
                  customIconBuilder: (context, local, global) => Text(
                    local.value ? 'NEET 2025' : 'NEET 2024',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color.lerp(
                        Colors.white,
                        Colors.black,
                        local.animationValue,
                      ),
                      fontWeight: local.value == global.current
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  iconAnimationType: AnimationType.onHover,
                  style: ToggleStyle(
                    indicatorColor: Colors.white,
                    borderColor: Colors.transparent,
                    backgroundColor: AppColors.primaryBlue,
                  ),
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                ImageCarousel(
                  items: item,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search products',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.filter_list,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sub.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            clickIndex = index;
                            log(clickIndex.toString());
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Chip(
                            label: Text(
                              sub[index],
                              style: TextStyle(fontSize: 20),
                            ),
                            side: BorderSide(color: AppColors.primaryBlue),
                            backgroundColor: clickIndex == index
                                ? Colors.blue.shade50
                                : Colors.transparent,
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                Consumer<ProductProvider>(
                  builder: (context, provider, child) {
                    if (provider.product.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 18.0,
                        mainAxisSpacing: 18.0,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: provider.product.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            var product = provider.product[index];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                  id: product.id.toString(),
                                  name: product.name,
                                  price: product.price.toString(),
                                  image: product.imageUrl,
                                  discountPrice: product.discount.toString(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: Center(
                                      child: Image.network(
                                        provider.product[index].imageUrl,
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    provider.product[index].name,
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "₹${provider.product[index].discount}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '(50% off)',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    "₹${provider.product[index].price.toString()}",
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                        color: AppColors.primaryBlue,
                                      ),
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width,
                                          40),
                                    ),
                                    onPressed: () async {
                                      final cartProvider =
                                          Provider.of<CartProvider>(context,
                                              listen: false);
                                      bool checkAdded =
                                          await cartProvider.addCart(
                                        int.parse(provider.product[index].id
                                            .toString()),
                                        1,
                                      );
                                      if (checkAdded) {
                                        showToast(
                                            context,
                                            'Item added to cart successfully',
                                            Colors.green,
                                            Icons.check);
                                      } else {
                                        showToast(
                                            context,
                                            'Failed to add item to cart',
                                            Colors.red,
                                            Icons.cancel_sharp);
                                      }
                                    },
                                    child: Text(
                                      "Add Cart",
                                      style: TextStyle(
                                          color: AppColors.primaryBlue),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
