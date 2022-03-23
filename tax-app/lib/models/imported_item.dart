import 'package:tax_app/models/constraints.dart';

import 'base_item.dart';

class ImportedItem extends BaseItem {
  ImportedItem(String name, double price) : super(name, price);

  @override
  double calculateTax() {
    double _itemTax = Constraints.importDuty * price;
    if (_itemTax <= Constraints.lowerLimitOnImportCharge) {
      _itemTax += Constraints.extraChargesUnderLimit;
    } else if (_itemTax >= Constraints.lowerLimitOnImportCharge &&
        _itemTax <= Constraints.upperLimitOnImportCharge) {
      _itemTax += Constraints.extraChargesInLimit;
    } else {
      _itemTax += Constraints.extraImportDutyOverLimit * (_itemTax + price);
    }
    return _itemTax;
  }
}
