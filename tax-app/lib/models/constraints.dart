import 'package:tax_app/models/item_type.dart';

class Constraints {
  static const int defaultQuantity = 1;
  static const String defaultName = "UNKNOWN ITEM";
  static const double defaultPrice = 1.0;
  static const ItemType defaultItemType = ItemType.RAW;

  static const double rawItemTaxCharges = 0.125;
  static const double manufacturedItemSurcharge = 0.02;

// Imported Items static constraints
  static const double importDuty = 0.1;
  static const double extraImportDutyOverLimit = 0.05;

  static const double extraChargesInLimit = 10;
  static const double extraChargesUnderLimit = 5;

  static const double upperLimitOnImportCharge = 200;
  static const double lowerLimitOnImportCharge = 100;
}
