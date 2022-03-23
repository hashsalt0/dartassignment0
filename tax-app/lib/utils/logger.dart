import 'package:tax_app/utils/log_const.dart';

class Log{
  static void error(String? text){
    print("${LogColors.red}$text${LogColors.reset}");
  }
  static void info(String? text){
    print("${LogColors.yellow}$text${LogColors.reset}");
  }
}
