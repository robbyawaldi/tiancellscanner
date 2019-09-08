import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';
import 'item.dart';
import 'cart.dart';

part 'sale.g.dart';

class SaleModel {
  var _url = 'http://192.168.1.6/api/stocks/sales/';

  Future<int> post(Sale sale) async => await http
          .post(_url,
              headers: {'Authorization': basicAuth}, body: sale.toJson())
          .timeout(const Duration(seconds: 3))
          .then((response) {
        return response.statusCode;
      }).catchError((onError) {
        return 408;
      });

  Future<List<Sale>> postAll(List<Sale> _sales) async {
    List<Sale> failedPost = [];
    for (Sale sale in _sales) {
      var response = await post(sale);
      if (response != 201) {
        failedPost.add(sale);
      }
    }
    return failedPost;
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

  factory Sale.fromJson(Map<String,dynamic> json) => _$SaleFromJson(json);
    Map<String, dynamic> toJson() => _$SaleToJson(this);
}
