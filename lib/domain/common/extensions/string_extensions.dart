import 'dart:convert';

import '../error_handling/app_error.dart';

extension JsonDecodingExtension on String {
  dynamic toJson() {
    try {
      return jsonDecode(this);
    } catch (e) {
      if (e is FormatException) {
        logger.e('Invalid JSON: $e');
        return null; // or you can return a default value like an empty map: {}
      } else {
        rethrow; // if it's not a FormatException, rethrow the error
      }
    }
  }
}