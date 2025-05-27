import 'package:flutter/material.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final VoidCallback? onBack;

  const Navbar({super.key, required this.username, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Hai, $username',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(221, 255, 255, 255),
      elevation: 0,
      actions: [
        Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
        ),
      ],
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
