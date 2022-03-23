import 'package:tax_app/models/base_item.dart';
import 'package:tax_app/models/constraints.dart';
import 'package:tax_app/models/imported_item.dart';
import 'package:tax_app/models/item_type.dart';
import 'package:tax_app/models/manufactured_item.dart';
import 'package:tax_app/models/raw_item.dart';

class ItemFactory {
  /// returns a base item class depending upon item type
  /// @param type  - the type of the item which is IMPORTED, MANUFACUTRED or RAW
  /// @param name  - name of the item
  /// @param price - price of the item
  /// @param quantity - quantity of the item
  static BaseItem getItem(
      ItemType type, String? name, double? price, int? quantity) {
    return _getItem(type, name, price)
      ..quantity = quantity ?? Constraints.defaultQuantity;
  }

  static BaseItem _getItem(ItemType type, String? name, double? price) {
    switch (type) {
      case ItemType.IMPORTED:
        return ImportedItem(
            name ?? Constraints.defaultName, price ?? Constraints.defaultPrice);
      case ItemType.MANUFACUTRED:
        return ManufacturedItem(
            name ?? Constraints.defaultName, price ?? Constraints.defaultPrice);
      case ItemType.RAW:
        return RawItem(
            name ?? Constraints.defaultName, price ?? Constraints.defaultPrice);
    }
  }
}
