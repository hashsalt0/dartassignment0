import 'package:tax_app/exceptions/invalid_item_type_exception.dart';
import 'package:tax_app/exceptions/option_missing_exception.dart';
import 'package:tax_app/exceptions/parse_exception.dart';
import 'package:tax_app/models/base_item.dart';
import 'package:tax_app/models/item_factory.dart';
import 'package:tax_app/models/item_type.dart';
import 'package:tax_app/parser/config.dart';
import 'package:tax_app/parser/option.dart';
import 'package:tax_app/parser/values.dart';
import 'package:tax_app/utils/logger.dart';

class CommandLineParser {
  // Option and its value
  Map<Option, String> _options = {};

  Map<Option, String> get options => this._options;

  Map<Option, List<Arg>> optionsArgs = {};

  void parseArguments(List<String> args) {
    Iterator<String> iter = args.iterator;

    while (iter.moveNext()) {
      String currentToken = iter.current;
      // the token value starts with the double-dash
      if (currentToken.startsWith('--')) {
        _parseToken(currentToken.substring(2, currentToken.length), iter);
      }
      // the token value starts with the single-dash
      else if (currentToken.startsWith('-')) {
        _parseToken(currentToken.substring(1, currentToken.length), iter);
      } else {
        throw ParseException("Read an Invalid Token $currentToken");
      }
    }
  }

  void process() {
    /// Processing each option argument first
    optionsArgs.forEach((Option option, List<Arg> args) {
      args.forEach((arg) {
        arg.process(option);
      });
    });

    // Print help message if exists and then return
    if (options.containsKey(Builder.getHelpOption())) {
      Builder.allOptions().forEach((x) => {Log.info(x.description)});
      return;
    }

    // Throws Option missing if type not found
    if (!options.containsKey(Builder.getTypeOption())) {
      throw OptionMissingException("Type Option is required");
    }

    String? itemType = options[Builder.getTypeOption()]?.toUpperCase();
    /// Finding the Item type from String
    ItemType type = ItemType.values.firstWhere(
        (e) => e.toString() == "${ItemType}.${itemType}", orElse: () => throw InvalidItemTypeException("$itemType"));

    BaseItem item = ItemFactory.getItem(
        type,
        options[Builder.getNameOption()],
        double.tryParse(options[Builder.getPriceOption()] ?? ""),
        int.tryParse(options[Builder.getQuantityOption()] ?? ""));
    String message = item.toString();
    Log.info("-----------------------------------");
    Log.info(message);
    Log.info("-----------------------------------");
  }

  /// Transform a string token literal to an option
  void _parseToken(String currentToken, Iterator<String> iter) {
    switch (currentToken) {
      case name:
      case nameShort:
        Option option = Builder.getNameOption();
        _processOption(option, iter);
        break;
      case price:
      case priceShort:
        Option option = Builder.getPriceOption();
        _processOption(option, iter);
        break;
      case quantity:
      case quantityShort:
        Option option = Builder.getQuantityOption();
        _processOption(option, iter);
        break;
      case type:
      case typeShort:
        Option option = Builder.getTypeOption();
        _processOption(option, iter);
        break;
      case help:
      case helpShort:
        Option option = Builder.getHelpOption();
        _processOption(option, iter);
        break;
    }
  }

  /// -option ((-arg | value) | (value | -arg)) ... repeat
  /// breaks on reciving a value
  void _processOption(Option option, Iterator<String> iter) {
    // thow exception when duplicate options are provided when enforcing is enabled
    if (isEnforcing && options.containsKey(option)) {
      throw ParseException(duplicateOptionErrorMessage);
    }
    // read from iterator till all the arguments are exhausted.
    int tokensToRead = option.optionArgsLength + (option.hasValue ? 1 : 0);
    String value = unknownValue;

    // will read all argument and value
    while (tokensToRead-- > 0 && iter.moveNext()) {
      String currentToken = iter.current;
      // the token starts with the double-dash for the option argument
      if (currentToken.startsWith('--')) {
        currentToken = currentToken.substring(2, currentToken.length);
      }
      // the token starts with the single-dash for the option argument
      else if (currentToken.startsWith('-')) {
        currentToken = currentToken.substring(1, currentToken.length);
      }
      // the token the value of option
      else {
        value = currentToken;
        break;
      }
      // Checking if the arguments have options
      Arg arg = option.getArgument(currentToken) ??
          (throw ParseException("Read Invalid Argument :: $currentToken"));
      optionsArgs.putIfAbsent(option, () => []);
      optionsArgs[option]?.add(arg);
    }
    if (option.hasValue == true && value == unknownValue) {
      if (iter.moveNext()) {
        value = iter.current;
      } else if(optionsArgs[option]?.isEmpty == true){
        throw ParseException("Expected a value for ${option.longOption}");
      }
    }
    options[option] = value;
  }
}
