import 'Item.dart';

class ManufacturedItem extends Item {
    late double _itemTax;

    ManufacturedItem(String name, double price) : super(name, price){
        _itemTax = 12.5 / 100 * price; // 12.5 % of price
        _itemTax += 2.0 / 100 * (price + _itemTax);  //  12.5 % of price plus 2% of ( price plus 12.5% of price)
    }

    @override
    double getTax() {
        return _itemTax;
    }
}