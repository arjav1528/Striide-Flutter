import 'package:flutter/material.dart';
import 'package:striide_flutter/core/utils/ui_utils.dart';

class ReportHeaderWidget extends StatelessWidget {
  final VoidCallback? onBackPressed;

  const ReportHeaderWidget({super.key, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UIUtils.horizontalSpace12,
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
        UIUtils.verticalSpace24,
        Padding(
          padding: UIUtils.horizontalPadding16,
          child: const Text(
            'Map reporting',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        UIUtils.verticalSpace8,
        Padding(
          padding: UIUtils.horizontalPadding16,
          child: Text(
            '',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ],
    );
  }
}