class Validations {
  static bool validateName(String? name) {
    if (name == null) return false;
    // start with capital letter afterwards it can be both
    return RegExp(r'^[A-Z][A-Za-z]+$').hasMatch(name);
  }

  static bool validateType(String? type) {
    if (type == null) return false;
    return RegExp(r'^(IMPORTED|MANUFACUTRED|RAW)$', caseSensitive: false)
        .hasMatch(type);
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