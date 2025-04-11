import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:mobile/model/product_model.dart';
import 'package:mobile/utils/url/url.dart';

class ProductProvider extends ChangeNotifier {
  final List<ProductModel> _product = [];
  List<ProductModel> get product => _product;
  void productFetch() async {
    try {
      final endPoint = "product/get";
      final url = Uri.parse(BASE_URL + endPoint);
      final res = await https.get(url);
      if (res.statusCode == 200) {
        List productJson = json.decode(res.body)['data'];
        log(productJson.toString());
        _product.clear();
        _product.addAll(
          productJson.map((value) => ProductModel.fromMap(value)).toList(),
        );
        notifyListeners();
      }
    } catch (e, stackTrace) {
      log("Error occurred: $e", error: e, stackTrace: stackTrace);
      throw Exception('Failed to load news');
    }
  }
}
