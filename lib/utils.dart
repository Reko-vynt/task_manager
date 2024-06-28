import 'package:intl/intl.dart';

extension MyDateTime on DateTime {
  String get ddMMMyyyy => DateFormat('dd MMM yyyy').format(this);
}
