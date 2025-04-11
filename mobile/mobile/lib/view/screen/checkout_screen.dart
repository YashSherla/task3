import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:mobile/model/product_model.dart';
import 'package:mobile/provider/cart_provider.dart';
import 'package:mobile/provider/product_provider.dart';
import 'package:mobile/view/widgets/empty_cart.dart';
import 'package:mobile/view/screen/error_pay_screen.dart';
import 'package:mobile/utils/colors.dart';
import 'package:mobile/view/widgets/billing_widget.dart';
import 'package:mobile/view/widgets/toat_message.dart';
import 'package:mobile/view/widgets/unlock_item.dart';
import 'package:mobile/view/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({
    super.key,
  });
  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool isadd = false;
  late List cartData;
  late List<ProductModel> productmodel;
  int totalPrice = 0;
  bool clickCoupon = false;
  bool _isInit = true;
  int additionalCost = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      retrieveData();
      _isInit = false;
    }
  }

  void retrieveData() {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false).product;
    cartData = cartProvider.cartItems;
    productmodel = [];
    for (var item in cartData) {
      final productId = item['productId'];
      final product = productProvider.firstWhere(
        (value) => value.id == productId,
        orElse: () => ProductModel(
          id: 0,
          name: "Unknown",
          price: 0,
          imageUrl: "",
          discount: 0,
        ),
      );
      if (product.id != 0) {
        productmodel.add(product);
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<CartProvider>(context, listen: false)
            .calculateTotalPrice(productmodel);
      });
    }
  }

  void toggleAddState() {
    setState(() {
      isadd = !isadd;
      additionalCost = isadd ? 800 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    int totalPrice = cartProvider.totalPrice;
    return Scaffold(
      body: SafeArea(
        child: quantityList.isEmpty
            ? EmptyCart()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 32,
                            ),
                          ),
                          Text(
                            "Checkout",
                            style: TextStyle(
                              fontFamily: 'Fredoka',
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primaryBlue,
                            ),
                            onPressed: () {},
                            label: Text(
                              "Share",
                              style: TextStyle(
                                fontFamily: 'Fredoka',
                                fontSize: 20,
                              ),
                            ),
                            icon: Icon(
                              CupertinoIcons.cart,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.shade50,
                          border: Border.all(
                            color: AppColors.primaryBlue,
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            "Your Total Savings",
                            style: TextStyle(
                              fontFamily: 'Fredoka',
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Hurray! You Get ₹50 Worth Clue Coins',
                            style: TextStyle(
                              fontFamily: 'Fredoka',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          trailing: Text(
                            '₹ 1000',
                            style: TextStyle(
                              fontFamily: 'Fredoka',
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: productmodel.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var product = productmodel[index];
                          var quantityItem = quantityList.firstWhere(
                            (item) => item['id'] == product.id,
                            orElse: () => {'quantity': 0},
                          );
                          int quantity = quantityItem['quantity'];
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 2,
                                  ),
                                ),
                                child: ListTile(
                                  leading: Image.network(product.imageUrl,
                                      width: 50, height: 50),
                                  title: Text(product.name),
                                  subtitle: Text(
                                    "Quantity: $quantity\nPrice: ₹${product.discount}",
                                  ),
                                  trailing: Text(
                                    "₹ ${product.discount * quantity}",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -14,
                                right: -14,
                                child: IconButton(
                                  icon: Icon(Icons.cancel, color: Colors.red),
                                  onPressed: () async {
                                    final cartProvider =
                                        Provider.of<CartProvider>(context,
                                            listen: false);
                                    final result = await cartProvider
                                        .removeFromCart(product.id.toString());
                                    if (result) {
                                      setState(() {
                                        retrieveData();
                                      });
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        cartProvider
                                            .calculateTotalPrice(productmodel);
                                      });
                                      showToast(
                                          context,
                                          'Item removed from cart',
                                          Colors.green,
                                          Icons.check);
                                    } else {
                                      showToast(
                                          context,
                                          'Failed to remove item',
                                          Colors.green,
                                          Icons.check);
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.grey.shade300,
                              child: ListTile(
                                title: Text("Unlock New Offer"),
                                leading: Icon(
                                  CupertinoIcons.star_circle,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        isadd ? Icons.check : Icons.lock,
                                        color: isadd
                                            ? Colors.green
                                            : Color(0XFF235A9F),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        isadd
                                            ? "Yay! Get 80% off on each Product"
                                            : "Shop for 4000 more to unlock special price",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: isadd
                                              ? Colors.green
                                              : Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  LinearProgressBar(
                                    maxSteps: 4,
                                    progressType:
                                        LinearProgressBar.progressTypeLinear,
                                    currentStep: isadd ? 4 : 1,
                                    progressColor: isadd
                                        ? Colors.green
                                        : Color(0XFF235A9F),
                                    backgroundColor: Colors.grey,
                                    borderRadius: BorderRadius.circular(2),
                                    minHeight: 4,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  UnlockItem(
                                    title: "Physics Notes",
                                    imageUrl:
                                        "https://s3-alpha-sig.figma.com/img/635d/f161/1f7bd1ccc976fc14f9b064c676303d74?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=lXeCtsvbPWqrX7Rgeb6pTxyapxdxyH4ssqdubDj2nkJlq0GliApLG~2xyWgccx~S3fBAU7TVUMMsMKdA5ZztfF6KuaOf52KAEPDv4XHw9nJPF3hVNREY6J1e0vdmmrhyjz2dU4UEbIyKIcwnmETCvNnhl3bsdlRY8PXDIIcEEutIhOZMG14AW1aRY1y6pNWFtGF32ozw17UaEMhQGXt-7fiHTq4NKveFi5EoNPBiDkMAErNctGq-~v5eKRqDvUfpFxq34Sb3rGlu1VmyRcA-c54zkk5D60Ct0CPxmsI9053Qbh6NofuKVJi2UTM2~L6malOVemwUU8JxK8A-FRSJIA__",
                                    price: "₹1000",
                                    discountPrice: "₹300",
                                    action: Chip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: EdgeInsets.all(0),
                                      backgroundColor: Colors.transparent,
                                      label: Text(
                                        'Till Need 2024',
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 10,
                                        ),
                                      ),
                                      side: BorderSide(
                                          color: AppColors.primaryBlue),
                                    ),
                                    btn: () => toggleAddState(),
                                    checkisAdd: isadd,
                                  ),
                                  SizedBox(height: 10),
                                  UnlockItem(
                                    title: "Memo Coins",
                                    imageUrl:
                                        "https://s3-alpha-sig.figma.com/img/635d/f161/1f7bd1ccc976fc14f9b064c676303d74?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=lXeCtsvbPWqrX7Rgeb6pTxyapxdxyH4ssqdubDj2nkJlq0GliApLG~2xyWgccx~S3fBAU7TVUMMsMKdA5ZztfF6KuaOf52KAEPDv4XHw9nJPF3hVNREY6J1e0vdmmrhyjz2dU4UEbIyKIcwnmETCvNnhl3bsdlRY8PXDIIcEEutIhOZMG14AW1aRY1y6pNWFtGF32ozw17UaEMhQGXt-7fiHTq4NKveFi5EoNPBiDkMAErNctGq-~v5eKRqDvUfpFxq34Sb3rGlu1VmyRcA-c54zkk5D60Ct0CPxmsI9053Qbh6NofuKVJi2UTM2~L6malOVemwUU8JxK8A-FRSJIA__",
                                    price: "₹2000",
                                    discountPrice: "₹500",
                                    action: Text("5000 coins"),
                                    btn: () => toggleAddState(),
                                    checkisAdd: isadd,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.grey.shade300,
                              child: ListTile(
                                title: Text("Use Coupons"),
                                leading: Icon(
                                  CupertinoIcons.star_circle,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            totalPrice >= 1800
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Extra 200% OFF",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Rs. 300 off on minimum purchase of Rs.1800",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              clickCoupon = true;
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  insetPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 20),
                                                  content: Stack(
                                                    clipBehavior: Clip.none,
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        height: 180,
                                                        width: 300,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          vertical: 20,
                                                          horizontal: 15,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "MemoNeetAchiever Applied",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              "₹300 off",
                                                              style: TextStyle(
                                                                fontSize: 26,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Saved! That feels amazing, right?",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: -50,
                                                        child: Image.asset(
                                                          'assets/images/offer.png',
                                                          height: 100,
                                                          width: 100,
                                                        ),
                                                      ),
                                                      Positioned(
                                                        bottom: -40,
                                                        child: IconButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          icon: Icon(
                                                            Icons.cancel,
                                                            size: 30,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: DottedBorder(
                                            color: Colors.green,
                                            dashPattern: [4, 3],
                                            strokeWidth: 5,
                                            padding: EdgeInsets.zero,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.green.shade100,
                                              ),
                                              child: Text(
                                                "MemoNeetAchiever",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        TextField(
                                          style: TextStyle(fontSize: 12),
                                          decoration: InputDecoration(
                                            hintText:
                                                'Enter Coupon Code ( Optional )',
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.all(16),
                                    child: Text(
                                      "No Offers Available",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 2,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.grey.shade300,
                              child: ListTile(
                                title: Text("Bill Details"),
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BillingRow(
                                    title: "Item total",
                                    value: '₹ $totalPrice',
                                  ),
                                  SizedBox(height: 10),
                                  BillingRow(
                                    title: "Discounts",
                                    value: (!clickCoupon || totalPrice == 0)
                                        ? "₹ 0"
                                        : "₹ 300.00",
                                    color: Colors.green,
                                  ),
                                  SizedBox(height: 10),
                                  BillingRow(
                                      title: "Igst (5%)",
                                      value: "₹ ${(5 / 100) * totalPrice}"),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                            Divider(thickness: 2),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: BillingRow(
                                title: "Item total",
                                value: (clickCoupon && totalPrice > 1800)
                                    ? "₹ ${(totalPrice - (5 / 100) * totalPrice) - 300}"
                                    : "₹ ${totalPrice - (5 / 100) * totalPrice}",
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      CustomButton(
                        text: "Pay",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ErrorPay(),
                            ),
                          );
                        },
                        size: Size(MediaQuery.of(context).size.width, 50),
                        color: AppColors.primaryBlue,
                        borderColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
