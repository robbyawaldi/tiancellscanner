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
      leftSymbol: 'Harga Modal: Rp',
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);
  var jualField = MoneyMaskedTextController(
      leftSymbol: 'Harga Jual: Rp',
      thousandSeparator: '.',
      decimalSeparator: '',
      precision: 0);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return SizedBox(
      height: 550,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: merkField,
                  decoration: InputDecoration(
                      hintText: 'Merk',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.indigo))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Tolong masukkan form merk';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: tipeField,
                  decoration: InputDecoration(
                      hintText: 'Tipe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.indigo))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Tolong masukkan form tipe';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: deskField,
                  decoration: InputDecoration(
                      hintText: 'Keterangan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.indigo))),
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
                      hintText: 'Harga Modal',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.indigo))),
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
                      hintText: 'Harga Jual',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.indigo))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Tolong masukkan form harga jual';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
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
                          modalField.clear();
                          jualField.clear();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Data service berhasil ditambahkan ke keranjang'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      child: Text('Tambah ke keranjang'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
