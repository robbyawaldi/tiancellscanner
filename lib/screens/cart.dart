import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiancell/models/cart.dart';
import 'package:tiancell/models/sale.dart';
import 'package:tiancell/models/service.dart';
import 'package:tiancell/models/transaction.dart';

import 'format.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Expanded(
              child: cart.list.isNotEmpty
                  ? _CartList()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('empty.png',
                            fit: BoxFit.cover, width: double.infinity),
                      ],
                    )),
          Divider(height: 4, color: Colors.grey),
          _CartTotal()
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  const _CartList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return ListView.builder(
        itemCount: cart.list.length,
        itemBuilder: (context, index) {
          final item = cart.list[index];

          Widget _nameItem() {
            if (item is Sale)
              return Text(
                '${item.item.name.toUpperCase()}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              );
            else if (item is Transaction)
              return Text(
                '${item.name.toUpperCase()}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              );
            else if (item is Service)
              return Text('SERVICE ${item.brand.toUpperCase()} ${item.type.toUpperCase()}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
            else
              return null;
          }

          Widget _priceItem() {
            if (item is Sale)
              return Text(
                '${rupiah(item.item.price).formattedLeftSymbol}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              );
            else if (item is Transaction)
              return Text(
                '${rupiah(item.price).formattedLeftSymbol}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              );
            else if (item is Service)
              return Text(
                '${rupiah(item.price).formattedLeftSymbol}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              );
            else
              return null;
          }

          Widget _selectQuantity() {
            if (item is Sale)
              return Column(
                children: <Widget>[
                  SizedBox(height: 15),
                  Row(
                    children: <Widget>[
                      Text(
                        'Jumlah',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Colors.black,
                        onPressed: () => cart.minusQtyItem(index),
                        splashColor: Colors.white,
                      ),
                      Text('${item.qty}', style: new TextStyle(fontSize: 14.0)),
                      IconButton(
                        onPressed: () => cart.addQtyItem(index),
                        icon: Icon(Icons.add),
                        color: Colors.black,
                        splashColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              );
            else
              return SizedBox();
          }

          return SizedBox(
            height: item is Sale ? 150 : 100,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              _nameItem(),
                              _priceItem(),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => cart.remove(index),
                            color: Colors.blueGrey,
                          ),
                        ],
                      ),
                    ),
                    _selectQuantity()
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return Container(
      padding: const EdgeInsets.all(10),
      height: 65,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Bayar',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${rupiah(cart.totalPrice).formattedLeftSymbol}',
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: 100.0,
            height: double.infinity,
            child: FlatButton(
              color: Colors.orange[600],
              textColor: Colors.white,
              child: Text('Bayar', style: TextStyle(fontSize: 17)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              onPressed: cart.list.isEmpty
                  ? null
                  : () async {
                      await cart.posts().then((success) {
                        if (success) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Transaksi Berhasil"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Tutup"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      });
                    },
            ),
          ),
        ],
      ),
    );
  }
}
