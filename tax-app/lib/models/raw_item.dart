import 'base_item.dart';
import 'constraints.dart';

class RawItem extends BaseItem {
  RawItem(String name, double price) : super(name, price);

  @override
  double calculateTax() {
    double _itemTax = Constraints.rawItemTaxCharges * price;
    return _itemTax;
  }
}
