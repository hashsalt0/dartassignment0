import 'package:tax_app/exceptions/parse_exception.dart';
import 'package:tax_app/parser/command_line_parser.dart';
import 'package:tax_app/parser/option.dart';
import 'package:tax_app/parser/values.dart';
import 'package:test/test.dart';

void main() {
  test("single help", () {
    String testString = "-$help";
    List<String> testArgs = testString.split(" ");
    var commandline = CommandLineParser();
    commandline.parseArguments(testArgs);
    expect(commandline.options, {Builder.getHelpOption(): unknownValue});
  });

  test("-help -help -name john; No error", () {
    String nameValue = "john";
    String testString = "-$help -$help -$name $nameValue";
    List<String> testArgs = testString.split(" ");
    var commandline = CommandLineParser();
    commandline.parseArguments(testArgs);
    expect(commandline.options, {
      Builder.getHelpOption(): unknownValue,
      Builder.getNameOption(): nameValue
    });
  });

  test("-help -help -name; missing value; throws ParseException", () {
    String testString = "-$help -$help -$name";
    List<String> testArgs = testString.split(" ");
    var commandline = CommandLineParser();
    expect(() {
      commandline.parseArguments(testArgs);
    }, throwsA(TypeMatcher<ParseException>()));
  });

  test(
      "-help -help -name -type -price -quantity; missing value; throws ParseException",
      () {
    String testString = "-$help -$help -$name -$type -$price -$quantity";
    List<String> testArgs = testString.split(" ");
    var commandline = CommandLineParser();
    expect(() {
      commandline.parseArguments(testArgs);
    }, throwsA(TypeMatcher<ParseException>()));
  });

  test("-help -help -name -type -price -quantity; no error", () {
    String nameValue = "john";
    String typeValue = "IMPORTED";
    String priceValue = "10.23";
    String quantityalue = "3";

    String testString =
        "-$name $nameValue -$type $typeValue -$price $priceValue -$quantity $quantityalue";
    List<String> testArgs = testString.split(" ");
    var commandline = CommandLineParser();
    commandline.parseArguments(testArgs);
    expect(commandline.options, {
      Builder.getNameOption(): nameValue,
      Builder.getPriceOption(): priceValue,
      Builder.getQuantityOption(): quantityalue,
      Builder.getTypeOption(): typeValue,
    });
    commandline.process();
  });


}
