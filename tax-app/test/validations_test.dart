import 'package:tax_app/utils/validations.dart';
import 'package:test/test.dart';

void main() {
  test("Name validation with invalid characters",
      testNameValidationWithInvalidCharacters);
  test("Name validation with lower first case and valid characters",
      testNameValidationWithLowerFirstCaseAndValidCharacters);
  test("Name Validation With Firs Upper Case And ValidCharacters",
      testNameValidationWithFirstUpperCaseAndValidCharacters);
  test("Price Validation Invalid Numbers", testPriceValidationInvalidNumbers);
  test("Price Validation Valid Numbers", testPriceValidationValidNumbers);
  test("Quantity Validation Invalid Numbers",
      testQuantityValidationInvalidNumbers);
  test(
      "Item Type Validation Invalid Types", testItemTypeValidationInvalidTypes);
  test("Item Type Validation Valid Types", testItemTypeValidationValidTypes);
}

void testNameValidationWithInvalidCharacters() {
  String toTest = "932nj@#";
  expect(false, Validations.validateName(toTest));
  toTest = "Aman23";
  expect(false, Validations.validateName(toTest));
  toTest = "aman@d";
  expect(false, Validations.validateName(toTest));
  toTest = "AmanD@";
  expect(false, Validations.validateName(toTest));
}

void testNameValidationWithLowerFirstCaseAndValidCharacters() {
  String toTest = "ajfdsfiehsj";
  expect(false, Validations.validateName(toTest));
  toTest = "ajfdsfieHsj";
  expect(false, Validations.validateName(toTest));
}

void testNameValidationWithFirstUpperCaseAndValidCharacters() {
  String toTest = "AmanLO";
  expect(true, Validations.validateName(toTest));
  toTest = "Amanlo";
  expect(true, Validations.validateName(toTest));
}

void testPriceValidationInvalidNumbers() {
  String toTest = "jeqw224";
  expect(false, Validations.validatePrice(toTest));
  toTest = "je@qw224";
  expect(false, Validations.validatePrice(toTest));
}

void testPriceValidationValidNumbers() {
  String toTest = "0.0";
  // less than or equal 0 -> invalid
  expect(false, Validations.validatePrice(toTest));
  toTest = "1.0";
  expect(true, Validations.validatePrice(toTest));
}

void testQuantityValidationInvalidNumbers() {
  String toTest = "jeqw224";
  // less than or equal 0 -> invalid
  expect(false, Validations.validateQuantity(toTest));
  toTest = "je@qw224";
  expect(false, Validations.validateQuantity(toTest));
}

void testQuantityValidationValidNumbers() {
  String toTest = "0";
  // less than or equal 0 -> invalid
  expect(false, Validations.validateQuantity(toTest));
  toTest = "1";
  expect(true, Validations.validateQuantity(toTest));
}

void testItemTypeValidationInvalidTypes() {
  String toTest = "3";
  expect(false, Validations.validateType(toTest));
  toTest = "djafi";
  expect(false, Validations.validateType(toTest));
}

void testItemTypeValidationValidTypes() {
  String toTest = "0";
  expect(true, Validations.validateType(toTest));
  toTest = "1";
  expect(true, Validations.validateType(toTest));
  toTest = "2";
  expect(true, Validations.validateType(toTest));
}
