import 'package:flutter/material.dart';
import 'package:structure/config/pallete.dart';

class CustomDivider extends StatelessWidget {
  final double height;

  const CustomDivider({super.key, this.height = 4});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: Pallete.fieldBorder,
    );
  }
}
