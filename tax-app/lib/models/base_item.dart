

abstract class BaseItem {
  static final tag = "Item";

  final String _name;

  final double _price;

  late int quantity;
  
  BaseItem(this._name, this._price);

  @override
  String toString(){
    StringBuffer sb = StringBuffer();
    sb.writeln("Item Name: $name");
    sb.writeln("Item Price: $price");
    sb.writeln("Quantity: $quantity");
    sb.writeln("Sales Tax liability per item: ${calculateTax()}");
    sb.write("Final Price: ${_price + calculateTax()}");
    return sb.toString();
  }


  double calculateTax();

  get price => _price;

  get name => _name;
}