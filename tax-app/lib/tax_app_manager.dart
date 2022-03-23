import 'dart:convert';
import 'dart:io';

import 'package:tax_app/models/constraints.dart';
import 'package:tax_app/models/item_factory.dart';
import 'package:tax_app/models/item_type.dart';
import 'package:tax_app/utils/logger.dart';
import 'package:tax_app/utils/validations.dart';

import 'exceptions/base_exception.dart';
import 'exceptions/invalid_item_name_exception.dart';
import 'exceptions/invalid_item_price_exception.dart';
import 'exceptions/invalid_item_quantity_exception.dart';
import 'exceptions/invalid_item_type_exception.dart';
import 'models/base_item.dart';

class TaxAppManager {
  
  /// Read from command line while printing the message
  String? _read(String message) {
    Log.info(message);
    return stdin.readLineSync(encoding: utf8);
  }

  /// Read from command line while printing the message with validation
  /// @param message - text to be displayed in command line
  /// @param validation - the validation function that has a String?  as parameter and return a boolean value
  /// @param error - the function that is called when the input is invalid
  String _readWithValidation(String message, String defaultValue,
      bool validation(String? val), void error(String)) {
    String? input = null;
    while (validation(input) == false) {
      input = _read(message);
      if (validation(input) == false) {
        error(input);
      }
    }
    return input ?? defaultValue;
  }

  ItemType _getItemType(String input) {
    int index = int.tryParse(input) ?? 0;
    return ItemType.values[index];
  }

  /// Application Loop
  void run() {
    String? input = null;
    String name;
    double price;
    int quantity;
    ItemType itemType;
    do {
      try {
        name = _readWithValidation(
            "Enter Item Name :: ", Constraints.defaultName, Validations.validateName, (input) {
          throw InvalidItemNameException(
              "Invalid Name, Name should start with a capital letter and must contain alphaberts");
        });
        price = double.parse(_readWithValidation(
            "Enter Item Price :: ", Constraints.defaultPrice.toString(), Validations.validatePrice, (input) {
          throw InvalidItemPriceException(
              "Price should be any real value form 1 to inf");
        }));
        quantity = int.parse(_readWithValidation(
            "Enter Item Quantity :: ", Constraints.defaultQuantity.toString(), Validations.validateQuantity,
            (input) {
          throw InvalidItemQuantityException(
              "Quantity should be any integer value form 1 to inf");
        }));
        itemType = _getItemType(_readWithValidation(
            "Enter Item Type :: \n ${ItemType.values.asMap()}", Constraints.defaultItemType.toString(), Validations.validateType, (input) {
          throw InvalidItemTypeException("Enter a value less than ${ItemType.values.length}");
        }));
        BaseItem item = ItemFactory.getItem(itemType, name, price, quantity);
        Log.out("--------------------------------");
        Log.out(item.toString());
        Log.out("--------------------------------");
        input = _read("Do you want to enter details of any other item (y/n): ");
      } on BaseException catch (exception) {
        Log.error(exception.toString());
      } on Exception catch (exception, stackTrace) {
        Log.error(exception.toString());
        print(stackTrace);
      }
    } while (input == null ||
        input.toLowerCase() == "yes" ||
        input.toLowerCase() == "y");
  }
}
