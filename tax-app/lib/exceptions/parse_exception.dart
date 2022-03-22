class ParseException implements Exception {
  String cause;
  ParseException(this.cause);
  
  @override
  String toString(){
    return "${this.runtimeType} :: $cause";
  }
}