import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiancell/models/cart.dart';
import 'package:tiancell/models/sale.dart';

import 'format.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Keranjang'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Expanded(child: _CartList()),
            Divider(height: 4, color: Colors.grey),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    List<Sale> sales = cart.sales;

    if (sales.isNotEmpty) {
      return Center();
      // return ListView.builder(
      //   itemCount: cart.sales.length,
      //   itemBuilder: (context, index) => Card(
      //     child: Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: <Widget>[
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               Text(
      //                 sales[index].item.name,
      //                 style:
      //                     TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //               ),
      //               Text(
      //                 '${rupiah(sales[index].item.price).formattedLeftSymbol} x ${sales[index].qty}',
      //                 style: TextStyle(
      //                     fontSize: 12,
      //                     fontWeight: FontWeight.bold,
      //                     color: Colors.orange),
      //               ),
      //             ],
      //           ),
      //           IconButton(
      //             icon: Icon(Icons.delete),
      //             onPressed: () => cart.remove(sales[index]),
      //             color: Colors.blueGrey,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('empty.png', fit: BoxFit.cover, width: double.infinity),
        ],
      );
    }
  }
}

class _CartTotal extends StatefulWidget {
  @override
  __CartTotalState createState() => __CartTotalState();
}

class __CartTotalState extends State<_CartTotal> {
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
              onPressed: () {
                if (cart.sales.isNotEmpty) {
                  // cart.postAll();
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
