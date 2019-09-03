import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:tiancell/models/auth.dart';

part 'transaction.g.dart';

class TransactionModel {
  var _url = 'http://192.168.1.6/api/pulsa/transactions/';

  Future<int> post(Transaction transaction) async {
    var response = await http.post(_url,
        headers: {'Authorization': basicAuth}, body: transaction.toJson());
    return response.statusCode;
  }

  List<Transaction> postAll(List<Transaction> _transactions) {
    _transactions.forEach((transaction) {
      post(transaction).then((response) {
        if (response == 201) {
          _transactions.remove(transaction);
        }
      });
    });
    return _transactions;
  }
}

@JsonSerializable()
class Transaction {
    Transaction();

    String name;
    num cost;
    num price;
    num nominal;
    
    Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
