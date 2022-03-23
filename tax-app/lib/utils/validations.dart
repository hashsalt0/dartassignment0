import 'package:tax_app/models/item_type.dart';

class Validations {
  static bool validateName(String? name) {
    if (name?.isEmpty == true) return true;
    if (name == null) return false;
    // start with capital letter afterwards it can be both
    return RegExp(r'^[A-Z][A-Za-z]+$').hasMatch(name);
  }

  static bool validateType(String? type) {
    if (type == null) return false;
    int? val = int.tryParse(type);
    return val != null && val >= 0 && val < ItemType.values.length;
  }

  static bool validatePrice(String? price) {
    if (price == null) return false;
    // return null on invalid double
    double? val = double.tryParse(price);
    // price should be greater than zero
    return val != null && val > 0;
  }

  static bool validateQuantity(String? quantity) {
    if (quantity == null) return false;
    // return null on invalid double
    int? val = int.tryParse(quantity);
    // price should be a natural number (ie 1 to +inf)
    return val != null && val > 0;
  }
}