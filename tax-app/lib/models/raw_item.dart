
import 'item.dart';

class RawItem extends Item {
    static const String tag = "RawItem";
    late double _itemTax;

    RawItem(String name, double price) : super(name, price){
        _itemTax = 12.5 / 100 * price;
    }
    
    @override
    double getTax() {
        return _itemTax;
    }
}