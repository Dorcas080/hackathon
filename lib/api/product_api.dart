import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_app/model/product.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  String api = "https://fakestoreapi.in/api";

  Future<List<Product?>> getProduct() async {
    try {
      final uri = Uri.parse("$api/products");

      final response = await http.get(uri);

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final dataProduct = data["products"] as List;

        List<Product?> products =
            dataProduct.map((product) {
              var prod = Product.fromMap(product);
              return prod;
            }).toList();

        return products;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
