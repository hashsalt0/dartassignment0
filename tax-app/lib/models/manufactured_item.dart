import 'package:tax_app/models/constraints.dart';

import 'base_item.dart';

class ManufacturedItem extends BaseItem {
  ManufacturedItem(String name, double price) : super(name, price);

  @override
  double calculateTax() {
    double _itemTax = Constraints.rawItemTaxCharges * price;
    _itemTax += Constraints.manufacturedItemSurcharge * (price + _itemTax);
    return _itemTax;
  }
}
