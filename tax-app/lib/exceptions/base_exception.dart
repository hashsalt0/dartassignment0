// Basic Exception class on which other exception will inherit
abstract class BaseException implements Exception{

  final String errorMessage;

  BaseException(this.errorMessage);

  @override
  String toString() {
    return "${this.runtimeType}; $errorMessage";
  }
}
