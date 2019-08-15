import 'package:flutter_money_formatter/flutter_money_formatter.dart';

FlutterMoneyFormatter rupiah(double price) {
  return FlutterMoneyFormatter(amount: price)
        ..symbol = 'Rp'
        ..thousandSeparator = '.'
        ..decimalSeparator = ','
        ..fractionDigits = 0
        ..spaceBetweenSymbolAndNumber = false;
}