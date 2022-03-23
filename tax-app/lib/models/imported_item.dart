import 'package:tax_app/models/constraints.dart';

import 'base_item.dart';

class ImportedItem extends BaseItem {
  ImportedItem(String name, double price) : super(name, price);

  double _calculateSurcharge(double amount) {
    if (amount <= Constraints.lowerLimitOnImportCharge) {
      return Constraints.extraChargesUnderLimit;
    } else if (amount > Constraints.lowerLimitOnImportCharge &&  amount <= Constraints.upperLimitOnImportCharge) {
      return  Constraints.extraChargesInLimit;
    } else {
      return  Constraints.extraImportDutyOverLimit * (amount + price); /// 5% of final cost ie  tax + price
    }
  }

  @override
  double calculateTax() {
    double _itemTax = Constraints.importDuty * price;
    _itemTax += _calculateSurcharge(_itemTax);
    return _itemTax;
  }
}
