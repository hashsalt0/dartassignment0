class OptionMissingException implements Exception {
  String cause;
  OptionMissingException(this.cause);

  @override
  String toString(){
    return "${this.runtimeType} :: $cause";
  }
}