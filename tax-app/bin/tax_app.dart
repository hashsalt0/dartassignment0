
import 'dart:io';

import 'package:cli_util/cli_util.dart';
import 'package:path/path.dart' as path;

import 'package:tax_app/tax_app.dart' as tax_app;


void main(List<String> arguments) {
  // Get sdk dir from cli_util.
  String sdkPath = getSdkPath();
  
  // Do stuff... For example, print version string
  File versionFile = File(path.join(sdkPath, 'version'));
  print(versionFile.readAsStringSync());
}
