import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:tiancell/models/auth.dart';

import 'cart.dart';
import 'nominal.dart';

part 'transaction.g.dart';

class TransactionModel {
  var _url = 'http://192.168.1.6/api/pulsa/transactions/';

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

  String name;
  Nominal nominal;

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
