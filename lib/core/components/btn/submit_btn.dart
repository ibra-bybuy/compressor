import 'package:flutter/material.dart';

class SubmitBtn extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final Color? backgroundColor;
  const SubmitBtn(
    this.title, {
    super.key,
    this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          backgroundColor: backgroundColor,
        ),
        child: Text(title),
      ),
    );
  }
}
