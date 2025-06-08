import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';

// ignore: non_constant_identifier_names
Widget FeatureButton(String title, CustomPaint icon) {
  return Builder(
    builder: (context) {
      UIUtils.init(context);
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;

      return Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: UIUtils.spacing48 - UIUtils.spacing4, // 44
                height: UIUtils.spacing48 - UIUtils.spacing4, // 44
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(12), // 12
                ),
              ),
              icon,
            ],
          ),
          UIUtils.verticalSpace(2),
          Text(
            title,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: colorScheme.onSurface.withOpacity(0.87),
            ),
          ),
        ],
      );
    },
  );
}
