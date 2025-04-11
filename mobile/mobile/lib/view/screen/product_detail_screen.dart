import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/provider/cart_provider.dart';
import 'package:mobile/provider/product_provider.dart';
import 'package:mobile/view/screen/checkout_screen.dart';
import 'package:mobile/view/widgets/toat_message.dart';
import 'package:mobile/view/widgets/custom_button.dart';
import 'package:mobile/utils/colors.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final String id;
  final String name;
  final String price;
  final String image;
  final String discountPrice;

  const ProductDetail({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.discountPrice,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isExpanded = false;
  bool _isExpanded2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.image),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -9,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      label: Text(
                        'Till Need 2024',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,
                        ),
                      ),
                      side: BorderSide(color: AppColors.primaryBlue),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.share)
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '₹${widget.discountPrice}',
                      style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      '₹${widget.price}',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontFamily: 'Fredoka',
                        fontSize: 24,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      '(50% off)',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    final cartProvider =
                        Provider.of<CartProvider>(context, listen: false);
                    bool checkAdded = await cartProvider.addCart(
                      int.parse(widget.id),
                      1,
                    );
                    if (checkAdded) {
                      showToast(context, 'Item added to cart successfully',
                          Colors.green, Icons.check);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Checkout(),
                        ),
                      );
                    } else {
                      showToast(context, 'Failed to add item to cart',
                          Colors.red, Icons.cancel_sharp);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color: AppColors.primaryBlue,
                      width: 2,
                    ),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  ),
                  child: Text('Add Cart'),
                ),
                SizedBox(height: 10),
                CustomButton(
                  text: 'Buy Now',
                  onPressed: () {},
                  size: Size(MediaQuery.of(context).size.width, 50),
                  color: AppColors.primaryBlue,
                  borderColor: Colors.blue,
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Image.network(
                      'https://s3-alpha-sig.figma.com/img/0d39/c7e6/25123bbff981686ab78b5171a54ed808?Expires=1745193600&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=YN7QJ~DLoPEuRAjAGcWeioXGNpjFmNg5aXEsjXG63eKwWaFQ1F7JzO1zCz2m0Un6qQs47GKyspXgI4mY6ozh3eCeA4SZ-h6lDlKBk22RFrNga9JhPqhSbJQ0IIEVR2z8I0NFtCRGP05TfKDtJmfmPwgfluYM~uAbKvFuSS3Ax27-KosBosjVWYKmayEpf3SshPBGTKq1yMQ4GTLnoZmefApxw0XMwqMnB01AvgVeUieWAQAn8hOMBiS9Pq4JRQSqpogYGhwveAAaae9PJzrS-btEFS75otFaDbjYg6Y75p21sgHUYvdT8aEWbCm-icsf67KXFbPwPcrE5ir5tGKU1w__',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Limited Time Offers for you',
                          style: TextStyle(
                            fontFamily: 'Fredoka',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Add Two Or More Books To Cart, Get 8% Discount',
                          style: TextStyle(
                            fontFamily: 'Fredoka',
                            fontSize: 11,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Icon(
                        _isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                AnimatedSize(
                  duration: Duration(microseconds: 200),
                  curve: Curves.easeInOut,
                  child: ConstrainedBox(
                    constraints: _isExpanded
                        ? BoxConstraints()
                        : BoxConstraints(maxHeight: 0),
                    child: Consumer<ProductProvider>(
                      builder: (context, provider, child) {
                        if (provider.product.isEmpty) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 18.0,
                            mainAxisSpacing: 18.0,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: 2,
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
                                      discountPrice:
                                          product.discount.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.time,
                                          color: Colors.red.shade800,
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '23 : 53 : 00',
                                          style: TextStyle(
                                            color: Colors.red.shade800,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    ClipRRect(
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
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 18,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          side: BorderSide(
                                            color: AppColors.primaryBlue,
                                          ),
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          minimumSize: Size(
                                              MediaQuery.of(context).size.width,
                                              40),
                                        ),
                                        onPressed: () {},
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
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product details",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isExpanded2 = !_isExpanded2;
                        });
                      },
                      child: Icon(
                        _isExpanded2
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                AnimatedSize(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: ConstrainedBox(
                    constraints: _isExpanded2
                        ? BoxConstraints()
                        : BoxConstraints(maxHeight: 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28),
                      child: Text(
                        "Colorful Mindmaps: Visualize intricate concepts and formulas effortlessly through mind maps, enhancing your comprehension and retention.\n\n"
                        "Complete Coverage: Covering every chapter of Physics, Chemistry, and Biology, this book ensures you have a solid grasp of all topics required for the NEET exam.\n\n"
                        "Emphasized Important Topics: Focused on the most crucial areas for NEET, the book highlights the topics that carry the highest relevance and weightage.",
                        style: TextStyle(fontSize: 16),
                        softWrap: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recommendation",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Text(
                            "View all",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
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
                      itemCount: 2,
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Item added to cart successfully')));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Failed to add item to cart'),
                                          ),
                                        );
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
