import 'dart:io';

import 'package:flutter/foundation.dart';
import 'utilities/app_starter.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) {
      exit(1);
    }
  };

  return appStarter();
}
