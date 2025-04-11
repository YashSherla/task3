import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:mobile/model/product_model.dart';
import 'package:mobile/utils/url/url.dart';
import 'package:http/http.dart' as https;

List quantityList = [];

class CartProvider extends ChangeNotifier {
  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  List<dynamic> _cartItems = [];
  List<dynamic> get cartItems => _cartItems;

  void calculateTotalPrice(List<ProductModel> productModelList) {
    int sum = 0;
    log(productModelList.length.toString());
    for (var item in _cartItems) {
      final product = productModelList.firstWhere(
        (prod) => prod.id == item['productId'],
        orElse: () =>
            ProductModel(id: 0, name: '', price: 0, imageUrl: '', discount: 0),
      );
      int quantity = item['quantity'];
      Map<String, dynamic> productMap = {
        'id': product.id,
        'quantity': quantity,
      };
      quantityList.add(productMap);
      sum += product.discount * quantity;
    }
    _totalPrice = sum;
    log("This is total: $totalPrice");
    notifyListeners();
  }

  Future<bool> addCart(
    int productId,
    int quantity,
  ) async {
    final endPoint = "cart/addcart";
    final url = Uri.parse(BASE_URL + endPoint);

    try {
      final res = await https.post(
        url,
        body: {
          "productId": productId.toString(),
          "quantity": quantity.toString(),
        },
      );
      if (res.statusCode == 200) {
        await getCart();
        return true;
      }
    } catch (e, stackTrace) {
      log(stackTrace.toString());
    }
    return false;
  }

  Future<Map?> getCart() async {
    final endPoint = "cart/getcart";
    final url = Uri.parse(BASE_URL + endPoint);
    try {
      final res = await https.get(url);
      if (res.statusCode == 200) {
        final decoded = jsonDecode(res.body);
        _cartItems = decoded['data'];
        quantityList.clear();
        for (var item in _cartItems) {
          quantityList.add({
            'id': item['productId'],
            'quantity': item['quantity'],
          });
        }
        notifyListeners();
        return decoded;
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      log(stackTrace.toString());
    }
    return null;
  }

  Future<bool> removeFromCart(String id) async {
    final endPoint = "cart/removecart/$id";
    final url = Uri.parse(BASE_URL + endPoint);
    log(url.toString());
    try {
      final res = await https.post(
        url,
      );
      if (res.statusCode == 200) {
        await getCart();
        return true;
      }
    } catch (e, stackTrace) {
      log(stackTrace.toString());
    }
    return false;
  }
}
