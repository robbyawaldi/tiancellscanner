import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:tiancell/models/cart.dart';
import 'package:http/http.dart' as http;
import 'package:tiancell/models/provider.dart';
import 'auth.dart';
import "nominal.dart";
part 'transaction.g.dart';

class TransactionModel {
  var _url = 'http://192.168.1.6/api/pulsa/transactions/';

  Future<Transaction> latestTransaction() async {
    var response = await http.get('${_url.substring(0, 41)}-latest/',
        headers: {'Authorization': basicAuth});
    if (response.statusCode == 200) {
      List<dynamic> transactions = json.decode(response.body);
      List<Transaction> trxList =
          transactions.map((item) => Transaction.fromJson(item)).toList();
      if (trxList.isEmpty)
        return null;
      else
        return trxList[0];
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<int> post(Transaction transaction) async => await http
          .post(_url,
              headers: {'Authorization': basicAuth}, body: transaction.toJson())
          .timeout(const Duration(seconds: 3))
          .then((response) {
        return response.statusCode;
      }).catchError((onError) {
        return 408;
      });

  Future<List<Transaction>> postAll(List<Transaction> _transactions) async {
    List<Transaction> failedPost = [];
    for (Transaction transaction in _transactions) {
      var response = await post(transaction);
      print(response);
      if (response != 201) {
        failedPost.add(transaction);
      }
    }
    return failedPost;
  }
}

@JsonSerializable()
class Transaction implements CartList {
  Transaction();

  String number;
  Provider provider;
  Nominal nominal;

  get name => '${provider.name} ${nominal.name}';

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
