
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(message) {
  Fluttertoast.showToast(msg: message.toString(), textColor: Colors.black, backgroundColor: Colors.white, toastLength: Toast.LENGTH_LONG);
}