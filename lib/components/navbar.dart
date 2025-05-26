import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final VoidCallback? onBack;
  final VoidCallback? onMenu;

  const Navbar({super.key, required this.username, this.onBack, this.onMenu});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBack ?? () => Navigator.of(context).pop(),
      ),
      title: Text('Hai, $username'),
      centerTitle: true,
      actions: [IconButton(icon: const Icon(Icons.menu), onPressed: onMenu)],
      backgroundColor: const Color.fromARGB(221, 255, 255, 255),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
