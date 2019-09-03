import 'package:flutter/material.dart';
import 'package:tiancell/models/index.dart';
import 'package:tiancell/models/sale.dart';
import 'package:tiancell/models/service.dart';

class CartModel extends ChangeNotifier {
  var sales = <Sale>[];
  var services = <Service>[];
  var transactions = <Transaction>[];

  void addSale(Item item, int qty) {
    Sale sale = Sale()
      ..idItem = item.id
      ..purchase = item.currentpurchase
      ..price = item.price
      ..qty = qty;
    sales.add(sale);
    notifyListeners();
  }

  void addTransaction(Provider provider, Nominal nominal) {
    Transaction transaction = Transaction()
      ..name = provider.name
      ..cost = nominal.cost
      ..price = nominal.price
      ..nominal = nominal.id;
    transactions.add(transaction);
    notifyListeners();
  }

  void addService(String brand, String type, String desc, num cost, num price) {
    Service service = Service()
      ..brand = brand
      ..type = type
      ..desc = desc
      ..cost = cost
      ..price = price;
    services.add(service);
    notifyListeners();
  }

  void removeSale(Sale sale) {
    sales.remove(sale);
    notifyListeners();
  }
  void removeTransaction(Transaction transaction) {
    transactions.remove(transaction);
    notifyListeners();
  }
  void removeService(Service service) {
    services.remove(service);
    notifyListeners();
  }

  bool posts() {
    sales = SaleModel().postAll(sales);
    transactions = TransactionModel().postAll(transactions);
    services = ServiceModel().postAll(services);
    notifyListeners();
    return sales.isEmpty && transactions.isEmpty && services.isEmpty;
  }

  double get totalPrice => 
    sales.fold(0.0, (total, current) => total + current.subtotal) +
    transactions.fold(0.0, (total, current) => total + current.price) +
    services.fold(0.0, (total, current) => total + current.price);
}
