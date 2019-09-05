import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';
import 'item.dart';
import 'cart.dart';

part 'sale.g.dart';

class SaleModel {
  var _url = 'http://192.168.1.6/api/stocks/sales/';

  Future<int> post(Sale sale) async {
    var response = await http.post(_url,
        headers: {'Authorization': basicAuth}, body: sale.toJson());
    return response.statusCode;
  }

  Future<List<Sale>> postAll(List<Sale> _sales) async {
    List<int> indexs = [];
    for (Sale sale in _sales) {
      indexs.add(await post(sale));
    }
    
    for (var i = 0; i < indexs.length; i++) {
      if (indexs[i] == 201) {
        _sales.removeAt(i);
      }
    }
    return _sales;
  }
}

@JsonSerializable()
class Sale implements CartList {
  Sale();

  Item item;
  num qty;

  get subtotal => this.item.price * this.qty;

  @override
  int get hashCode => this.item.id;

  @override
  bool operator ==(Object other) => other is Item && other.id == this.item.id;

  Map<String, dynamic> toJson() => _$SaleToJson(this);
}
