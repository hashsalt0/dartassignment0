import 'dart:io';

import 'package:tax_app/parser/values.dart';
import 'package:tax_app/utils/logger.dart';

class Option {
  /// The name of the option.
  final String optionName;

  /// The long representation of the option.
  final String? longOption;

  /// Description of the option.
  final String? description;

  /// Specifies whether this option is required to be present.
  final bool required;
  
  /// Specifies the additional arguments for the option
  final List<Arg> optionArgsList;
  get optionArgsLength => this.optionArgsList.length;

  
  final bool hasValue;

  Option._builder(this.optionName, this.longOption, this.description, this.required, this.optionArgsList, this.hasValue);

  Arg? getArgument(String token){
    Arg? toFind = null;
    for(var arg in optionArgsList){
      if(arg._name == token || arg._shortName == token) {
        toFind = arg;
        break;
      }
    }
    return toFind;
  }

  @override
  bool operator ==(Object other) {
    return other is Option && (other.optionName == optionName);
  }
  @override
  int get hashCode => Object.hash(optionName, longOption);
}

/// This class represents the additional argument for the option
class Arg{
  /// Argument name
  final String _name;
  get name => this._name;
  /// Argument short name
  final String? _shortName;
  get shortName => this._shortName;


  late void Function(Option option) process;
  

  Arg(this._name, this._shortName);
}

class Builder {

  String? _option;

  String? _longOption;

  String? _description;

  /// Every option is not required by default
  bool? _required;

  
  /// Every option must have value by default
  bool? _hasValue;

  List<Arg>? _optionArgsList;

  Builder._(){}

  Option _build() {
    return Option._builder(_option ?? "", _longOption, _description, _required ?? false, _optionArgsList ?? [], _hasValue ?? true);
  }

  static List<Arg> commonArgList = [Arg(help, helpShort)..process = (option) {
    Log.info(option.description);
    /// Normally exits the application
    exit(0);
  }];

  static Option getNameOption(){
    Builder nameOption = Builder._()
    .._option = nameShort
    .._description = nameDescription
    .._longOption = name
    .._required = false
    .._optionArgsList = [...commonArgList];
    return nameOption._build();
  }

  static Option getPriceOption(){
    Builder nameOption = Builder._()
    .._option = priceShort
    .._description = priceDescription
    .._longOption = price
    .._optionArgsList = [...commonArgList];
    return nameOption._build();
  }

  static Option getQuantityOption(){
    Builder nameOption = Builder._()
    .._option = quantityShort
    .._description = quantityDescription
    .._longOption = quantity
    .._optionArgsList = [...commonArgList];
    return nameOption._build();
  }

  static Option getTypeOption(){
    Builder nameOption = Builder._()
    .._option = typeShort
    .._description = typeDescription
    .._longOption = type
    .._required = true
    .._optionArgsList = [...commonArgList];
    return nameOption._build();
  }

  static Option getHelpOption(){
    Builder helpOption = Builder._()
    .._option = helpShort
    .._description = helpDescription
    .._longOption = help
    .._hasValue = false
    .._optionArgsList = [];
    return helpOption._build();
  }

  static List<Option> allOptions() {
    return [getHelpOption(), getNameOption(), getPriceOption(), getQuantityOption(), getTypeOption()];
  }
}


