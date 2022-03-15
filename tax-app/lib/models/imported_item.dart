import 'package:tax_app/models/const.dart';

import 'base_item.dart';

class ImportedItem extends BaseItem {
  late double _itemTax;

  ImportedItem(String name, double price) : super(name, price) {
    _itemTax = importDuty * price;
    if (_itemTax <= lowerLimitOnImportCharge) {
      _itemTax += extraChargesUnderLimit;
    } else if (_itemTax >= lowerLimitOnImportCharge && _itemTax <= upperLimitOnImportCharge) {
      _itemTax += extraChargesInLimit;
    } else {
      _itemTax += extraImportDutyOverLimit * (_itemTax + price); 
    } 
  }

  @override
  double getTax() {
    return _itemTax;
  }
}
