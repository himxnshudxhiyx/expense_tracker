import 'package:flutter/cupertino.dart';

printFlutterError({error, stack, runTimeType}){
  debugPrint("Error--->${error.toString()}");
  debugPrint("Stack--->${stack}");
  debugPrint("RunTimeType--->${runTimeType}");
}