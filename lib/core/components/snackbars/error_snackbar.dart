import 'package:flutter/material.dart';

class ErrorSnackbar {
  final String message;

  const ErrorSnackbar(this.message);

  void call(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      style: const TextStyle(color: Colors.red),
    )));
  }
}
