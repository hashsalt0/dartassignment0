
import 'base_item.dart';
import 'const.dart';

class RawItem extends BaseItem {
    static const String tag = "RawItem";
    late double _itemTax;

    RawItem(String name, double price) : super(name, price){
        _itemTax = rawItemTaxCharges * price;
    }
    
    @override
    double getTax() {
        return _itemTax;
    }
}