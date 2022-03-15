import 'package:tax_app/models/const.dart';

import 'base_item.dart';

class ManufacturedItem extends BaseItem {
    late double _itemTax;

    ManufacturedItem(String name, double price) : super(name, price){
        _itemTax = rawItemTaxCharges * price; // 12.5 % of price
        _itemTax += manufacturedItemCharges * (price + _itemTax);  //  12.5 % of price plus 2% of ( price plus 12.5% of price)
    }

    @override
    double getTax() {
        return _itemTax;
    }
}