import 'package:flutter/material.dart';

class EmptyTabPlaceHolder extends StatelessWidget {
  final String? label;
  final IconData? icon;
  const EmptyTabPlaceHolder({
    Key? key,
    this.label,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 100),
          Text('$label'),
        ],
      ),
    );
  }
}
