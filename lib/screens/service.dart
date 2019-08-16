import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Service extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Form Service'),
      ),
      body: SingleChildScrollView(child: ServiceForm()),
    );
  }
}

class ServiceForm extends StatefulWidget {
  ServiceForm({Key key}) : super(key: key);

  _ServiceFormState createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  final _formKey = GlobalKey<FormState>();
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
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
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
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Processing Data ${modalField.numberValue}')));
                    }
                  },
                  child: Text('Kirim'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
