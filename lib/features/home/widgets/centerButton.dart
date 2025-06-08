import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';

// ignore: non_constant_identifier_names
Widget CenterButton() {
  return Builder(
    builder: (context) {
      UIUtils.init(context);
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;

      return Container(
        width: UIUtils.spacing48 - UIUtils.spacing4, // 44
        height: UIUtils.spacing48 - UIUtils.spacing4, // 44
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(
            UIUtils.spacing48,
          ), // 100 equivalent
          border: Border.all(color: colorScheme.primary, width: 1),
        ),
        child: Icon(
          Icons.navigation_rounded,
          size: UIUtils.iconSizeMedium + UIUtils.spacing4 + 2, // 30
          color: colorScheme.primary,
        ),
      );
    },
  );
}
