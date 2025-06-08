import 'package:flutter/material.dart';
import 'package:striide_flutter/core/utils/ui_utils.dart';

class FeedbackHeaderWidget extends StatelessWidget {
  final VoidCallback? onBackPressed;

  const FeedbackHeaderWidget({super.key, this.onBackPressed});

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
                color: const Color(0xFF33323a),
                borderRadius: BorderRadius.circular(100),
              ),
              child: IconButton(
                onPressed: onBackPressed ?? () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            UIUtils.horizontalSpace48,
            const Text(
              'Feedback page',
              style: TextStyle(
                color: Color(0xFFff7a4b),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
        UIUtils.verticalSpace8,
        Padding(
          padding: UIUtils.horizontalPadding16,
          child: const Text(
            'Your feedback is the heart of our progress',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
