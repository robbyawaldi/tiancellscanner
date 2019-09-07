import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:provider/provider.dart';
import 'package:tiancell/models/cart.dart';

class ServiceCard extends StatefulWidget {
  ServiceCard({Key key}) : super(key: key);

  _ServiceCardState createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  final _formKey = GlobalKey<FormState>();
  var merkField = TextEditingController();
  var tipeField = TextEditingController();
  var deskField = TextEditingController();
  var modalField = MoneyMaskedTextController(
      thousandSeparator: '.', decimalSeparator: '', precision: 0);
  var jualField = MoneyMaskedTextController(
      thousandSeparator: '.', decimalSeparator: '', precision: 0);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Service', style: Theme.of(context).textTheme.headline),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: merkField,
                    decoration: InputDecoration(
                        labelText: 'Merk',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Tolong masukkan form merk';
                      } else if (value.length > 10) {
                        return 'Panjang merk melebihi 10 karakter';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: tipeField,
                    decoration: InputDecoration(
                        labelText: 'Tipe',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Tolong masukkan form tipe';
                      } else if (value.length > 10) {
                        return 'Panjang tipe melebihi 10 karakter';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: deskField,
                    decoration: InputDecoration(
                      labelText: 'Keterangan',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Tolong masukkan form keterangan';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: modalField,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Harga Modal',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Tolong masukkan form harga modal';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: jualField,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Harga Jual',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Tolong masukkan form harga jual';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton.icon(
                      icon: Icon(Icons.add),
                      color: Colors.orange[600],
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          cart.addService(
                              merkField.text,
                              tipeField.text,
                              deskField.text,
                              modalField.numberValue,
                              jualField.numberValue);

                          merkField.clear();
                          tipeField.clear();
                          deskField.clear();
                          modalField.updateValue(0);
                          jualField.updateValue(0);
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Data service berhasil ditambahkan ke keranjang'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      label: Text('Tambah ke keranjang'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
