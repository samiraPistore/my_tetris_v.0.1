import 'package:flutter/material.dart';

class BtnShape extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BtnShape({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
      ),
      child: Text(text),
    );
  }
}