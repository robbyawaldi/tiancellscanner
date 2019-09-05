import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:tiancell/models/auth.dart';

import 'cart.dart';

part 'transaction.g.dart';

class TransactionModel {
  var _url = 'http://192.168.1.6/api/pulsa/transactions/';

  Future<int> post(Transaction transaction) async {
    var response = await http.post(_url,
        headers: {'Authorization': basicAuth}, body: transaction.toJson());
    return response.statusCode;
  }

  Future<List<Transaction>> postAll(List<Transaction> _transactions) async {
    List<int> indexs = [];
    for (Transaction transaction in _transactions) {
      indexs.add(await post(transaction));
    }

    for (var i = 0; i < indexs.length; i++) {
      if (indexs[i] == 201) {
        _transactions.removeAt(i);
      }
    }
    return _transactions;
  }
}

@JsonSerializable()
class Transaction implements CartList {
  Transaction();

  String name;
  num cost;
  num price;
  num nominal;

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
