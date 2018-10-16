import 'package:flutter/material.dart';

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context) {
  /*print(
      "Size: $size * MQ: ${MediaQuery.of(context).size.height} / $baseHeight = ${size * MediaQuery.of(context).size.height / baseHeight}");*/
  return size * MediaQuery.of(context).size.height / baseHeight;
}