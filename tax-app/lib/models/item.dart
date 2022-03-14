
class Item {
  static final tag = "Item";

  final String _name;

  final double _price;

  int quantity = 0;
  
  Item(this._name, this._price);

  /// returns the description of the item.
  @override
  String toString(){
    StringBuffer sb = StringBuffer();
    sb.writeln("Item Name: $name");
    sb.writeln("Item Type: ${runtimeType}");
    sb.writeln("Item Price: $price");
    sb.writeln("Quantity: $quantity");
    sb.writeln("Sales Tax liability per item: ${getTax()}");
    sb.write("Final Price: ${_price + getTax()}");
    return sb.toString();
  }


  double getTax() => 0;

  get price => _price;

  get name => _name;
}