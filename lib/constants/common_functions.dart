import 'package:intl/intl.dart';

convertDateFormat({format, dateString}){
// Parse the date string into a DateTime object
  DateTime dateTime = DateTime.parse(dateString.toString());

  // Create a DateFormat instance for the desired format
  DateFormat formatter = DateFormat(format ?? 'dd MMM, yyyy');

  // Format the DateTime object and return the formatted date string
  return formatter.format(dateTime);
}