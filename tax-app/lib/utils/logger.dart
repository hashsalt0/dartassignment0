import 'package:tax_app/utils/log_const.dart';

class Log{
  static void error(String? text){
    print("$red$text$reset");
  }
  static void info(String? text){
    print("$yellow$text$reset");
  }
}
