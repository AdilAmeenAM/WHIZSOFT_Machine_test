import 'package:flutter/material.dart';

class UserTileWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const UserTileWidget({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(32),
        child: Row(
          children: [
            // icon
            const Icon(
              Icons.person,
              size: 38,
              color: Colors.grey,
            ),
            const SizedBox(width: 20),
            // user name
            Text(
              text,
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
