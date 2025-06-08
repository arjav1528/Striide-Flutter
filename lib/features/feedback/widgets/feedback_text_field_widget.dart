import 'package:flutter/material.dart';
import 'package:striide_flutter/core/utils/ui_utils.dart';

class FeedbackTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final VoidCallback? onAddMedia;

  const FeedbackTextFieldWidget({
    super.key,
    required this.controller,
    this.hintText =
        "We're listening — tell us the good, the bad, and the ugly.",
    this.maxLines = 6,
    this.onAddMedia,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Nunito',
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.black45,
              fontSize: 16,
              fontFamily: 'Nunito',
            ),
            fillColor: Color(0xFFb8b8b8),
            filled: true,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
        UIUtils.verticalSpace12,
        GestureDetector(
          onTap: onAddMedia,
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFFff7a4b),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 16),
              ),
              UIUtils.horizontalSpace8,
              const Text(
                'Add media',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
