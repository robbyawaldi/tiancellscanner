import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;

import 'auth.dart';
import 'item.dart';

part 'sale.g.dart';

class SaleModel {
  var _url = 'http://192.168.1.6/api/stocks/sales/';

  Future<int> post(Sale sale) async {
    var response = await http.post(_url,
        headers: {'Authorization': basicAuth}, body: sale.toJson());
    return response.statusCode;
  }

  List<Sale> postAll(List<Sale> _sales) {
    _sales.forEach((sale) {
      post(sale).then((response) {
        if (response == 201) {
          _sales.remove(sale);
        }
      });
    });
    return _sales;
  }
}

@JsonSerializable()
class Sale {
  Sale();

  num idItem;
  num purchase;
  num price;
  num qty;

  get subtotal => this.price * this.qty;

  @override
  int get hashCode => idItem;

  @override
  bool operator ==(Object other) => other is Item && other.id == idItem;

  Map<String, dynamic> toJson() => _$SaleToJson(this);
}
