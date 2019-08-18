import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:qr_utils/qr_utils.dart';
import 'package:tiancell/models/auth.dart';
import 'package:tiancell/models/item.dart';
import 'package:tiancell/models/sale.dart';
import 'package:http/http.dart' as http;

class CartModel extends ChangeNotifier {
  final List<Sale> _sales = [];

  List<Sale> get sales => _sales;

  double get totalPrice =>
      _sales.fold(0.0, (total, current) => total + current.subtotal);

  void add(Item item, int qty) {
    _sales.add(Sale.input(item, qty));
    notifyListeners();
  }

  void postAll() {
    _sales.forEach((sale) {
      post(sale).then((response) {
        if (response == 201) {
          _sales.remove(sale);
          notifyListeners();
        }
      });
    });
  }

  Future<int> post(Sale sale) async {
    var response = await http.post('http://192.168.1.6/api/stocks/sales/',
        headers: {'Authorization': basicAuth}, body: sale.toJson());
    return response.statusCode;
  }

  void remove(Sale sale) {
    _sales.remove(sale);
    notifyListeners();
  }
}

class ItemModel extends ChangeNotifier {
  Item item;
  String url = 'http://192.168.1.6/api/stocks/items/';

  Future<List<Item>> items() async {
    var response = await http.get('$url', headers: {'Authorization': basicAuth});
    if (response.statusCode == 200) {
      List<dynamic> items = json.decode(response.body);
      return items.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  void itemById(String id) async {
    var response = await http.get('$url$id', headers: {'Authorization': basicAuth});
    if (response.statusCode == 200) {
      item = Item.fromJson(json.decode(response.body));
      notifyListeners();
    } else {
      remove();
    }
  }

  void scan() async {
    var id = await QrUtils.scanQR;
    itemById(id);
  }

  void remove() {
    item = null;
    notifyListeners();
  }
}
