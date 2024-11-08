import 'package:flutter/material.dart';

class AuthActionBtnWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isLoading;

  const AuthActionBtnWidget({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: isLoading ? const CircularProgressIndicator() : Text(text),
        ),
      ),
    );
  }
}
