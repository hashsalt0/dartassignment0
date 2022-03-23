import 'package:tax_app/utils/log_colors.dart';

class Log{
  static void error(String? text){
    print("${LogColors.red}$text${LogColors.reset}");
  }
  static void info(String? text){
    print("${LogColors.yellow}$text${LogColors.reset}");
  }
  static void out(String? text){
    print("${LogColors.green}$text${LogColors.reset}");
  }
}
