import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpErrorHandler {
  static String getMessage(dynamic error, {http.Response? response}) {
    if (error is SocketException) {
      return "No internet connection. Please check your network.";
    }

    if (error is TimeoutException) {
      return "The request timed out. Please try again later.";
    }

    if (response != null) {
      try {
        final Map<String, dynamic> body = json.decode(response.body);

        final fieldErrors = body.entries.where((e) => e.value is List);
        if (fieldErrors.isNotEmpty) {
          final messages = fieldErrors.expand((e) {
            final list = e.value;
            if (list is List) {
              return list.cast<String>();
            }
            return [];
          }).toList();
          return messages.join('\n');
        }

        if (body.containsKey('detail')) {
          return body['detail'];
        }

        return "Something went wrong.";
      } catch (_) {
        return "Server error. Please try again later.";
      }
    }

    return "An unexpected error occurred. Please try again later.";
  }
}