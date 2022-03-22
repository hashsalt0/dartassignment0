import 'dart:convert';
import 'dart:io';

import 'package:tax_app/parser/command_line_parser.dart';
import 'package:tax_app/utils/logger.dart';

class TaxAppManager {
  bool _promptForNewItemUntilExit(List<String> args) {
    Log.info("Do you want to enter details of any other item (y/n): ");
    String? choice = stdin.readLineSync(encoding: utf8)?.toLowerCase();
    if (choice == null) return false;
    if (choice == "yes" || choice == "y") {
      Log.info("\nEnter arguments: ");
      String? input = stdin.readLineSync(encoding: utf8)?.toLowerCase();
      if (input == null) return false;
      args.clear();
      args.insertAll(0, input.split(" ").where((element) => element.isNotEmpty));
      return true;
    } else if (choice == "no" || choice == "n") {
      Log.info("Exiting...");
    } else {
      Log.error("Invalid choice $choice");
    }
    return false;
  }

  /// Application Loop
  void run(List<String> initalArgs) {
    List<String> currentArgs = initalArgs.toList();
    try {
      do {
        CommandLineParser cliParser = CommandLineParser();
        cliParser.parseArguments(currentArgs);
        cliParser.process();
      } while (_promptForNewItemUntilExit(currentArgs));
    } catch (e) {
      Log.error(e.toString());
    }
  }
}
