
class InvalidItemTypeException  {
  String cause;
  InvalidItemTypeException(this.cause);

  @override
  String toString(){
    return "${this.runtimeType} :: $cause";
  }
}
