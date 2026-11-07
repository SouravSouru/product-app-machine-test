import 'dart:convert';

import 'package:product_app/features/products/data/models/product_details_model/product_details_model.dart';
import 'package:product_app/features/products/data/models/product_list_model/product_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsLocalSource {
  ProductsLocalSource(this._preferences);

  final SharedPreferences _preferences;

  static String pageKey(int skip) => 'products_page_$skip';

  static String productKey(int id) => 'product_$id';

  Future<void> savePage(int skip, ProductListModel page) {
    return _preferences.setString(pageKey(skip), jsonEncode(page.toJson()));
  }

  ProductListModel? readPage(int skip) {
    final raw = _preferences.getString(pageKey(skip));
    if (raw == null) return null;

    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return ProductListModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveProduct(ProductDetailsModel product) {
    final id = product.id;
    if (id == null) return Future.value();
    return _preferences.setString(productKey(id), jsonEncode(product.toJson()));
  }

  ProductDetailsModel? readProduct(int id) {
    final raw = _preferences.getString(productKey(id));
    if (raw == null) return null;

    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return ProductDetailsModel.fromJson(json);
    } catch (_) {
      return null;
    }
  }
}
