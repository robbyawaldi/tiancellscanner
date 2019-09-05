import 'package:flutter/material.dart';
import 'package:tiancell/models/index.dart';
import 'package:tiancell/models/sale.dart';
import 'package:tiancell/models/service.dart';

abstract class CartList {}

class CartModel extends ChangeNotifier {
  var list = <CartList>[];

  void addSale(Item item, int qty) {
    Sale sale = Sale()
      ..item = item
      ..qty = qty;
    list.add(sale);
    notifyListeners();
  }

  void addTransaction(Provider provider, Nominal nominal) {
    Transaction transaction = Transaction()
      ..name = '${provider.name} ${nominal.name}'
      ..cost = nominal.cost
      ..price = nominal.price
      ..nominal = nominal.id;
    list.add(transaction);
    notifyListeners();
  }

  void addService(String brand, String type, String desc, num cost, num price) {
    Service service = Service()
      ..brand = brand
      ..type = type
      ..desc = desc
      ..cost = cost
      ..price = price;
    list.add(service);
    notifyListeners();
  }

  void remove(int index) {
    list.removeAt(index);
    notifyListeners();
  }

  void addQtyItem(int index) {
    Sale sale = list[index];
    if (sale.qty < sale.item?.stock ?? 0) sale.qty++;
    notifyListeners();
  }

  void minusQtyItem(int index) {
    Sale sale = list[index];
    if (sale.qty != 1) sale.qty--;
    notifyListeners();
  }

  Future<bool> posts() async {
    List<Sale> _sales = [];
    List<Transaction> _transactions = [];
    List<Service> _services = [];

    list.forEach((item) {
      if (item is Sale) {
        _sales.add(item);
      } else if (item is Transaction) {
        _transactions.add(item);
      } else if (item is Service) {
        _services.add(item);
      }
    });

    if (_sales.isNotEmpty) {
      await SaleModel().postAll(_sales).then((sales) => _sales = sales);
    }
    if (_transactions.isNotEmpty) {
      await TransactionModel()
          .postAll(_transactions)
          .then((transactions) => _transactions = transactions);
    }
    if (_services.isNotEmpty) {
      await ServiceModel()
          .postAll(_services)
          .then((services) => _services = services);
    }

    list.clear();
    list.addAll(_sales);
    list.addAll(_transactions);
    list.addAll(_services);

    notifyListeners();
    return list.isEmpty;
  }

  double get totalPrice => list.fold(0.0, (total, current) {
        if (current is Sale) {
          return total + current.subtotal;
        } else if (current is Transaction) {
          return total + current.price;
        } else if (current is Service) {
          return total + current.price;
        } else {
          return 0.0;
        }
      });
}
