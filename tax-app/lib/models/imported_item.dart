import 'Item.dart';

class ImportedItem extends Item {
  late double _itemTax;

  ImportedItem(String name, double price) : super(name, price) {
    _itemTax = 10.0 / 100 * price;
    if (_itemTax <= 100) {
      _itemTax += 5;
    } else if (_itemTax >= 100 && _itemTax <= 200) {
      _itemTax += 10;
    } else {
      _itemTax += 5.0 / 100 * (_itemTax + price); 
    } 
  }

  @override
  double getTax() {
    return _itemTax;
  }
}
