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

        if (body.containsKey('errors')) {
          final errors = body['errors'] as Map<String, dynamic>;
          if (errors.isNotEmpty) {
            return errors.values.first[0];
          }
        }

        return body['detail'] ?? "Something went wrong.";
      } catch (_) {
        return "Server error. Please try again later.";
      }
    }

    return "An unexpected error occurred. Please try again later.";
  }
}