import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final bool isAutoImplyLeading;

  const MyAppBar({
    super.key,
    required this.title,
    required this.isAutoImplyLeading,
  });

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: isAutoImplyLeading,
      centerTitle: true,
      elevation: 0,
      title: Text(title),
    );
  }
}
