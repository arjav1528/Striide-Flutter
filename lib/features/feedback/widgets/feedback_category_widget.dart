import 'package:flutter/material.dart';
import 'package:striide_flutter/core/utils/ui_utils.dart';

enum FeedbackCategory {
  bugReport('Bug report', Icons.bug_report_outlined),
  feature('Feature', Icons.diamond_outlined),
  experience('Experience', Icons.visibility_outlined),
  others('Others', Icons.more_horiz_outlined);

  const FeedbackCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}

class FeedbackCategoryWidget extends StatefulWidget {
  final FeedbackCategory? selectedCategory;
  final ValueChanged<FeedbackCategory> onCategorySelected;

  const FeedbackCategoryWidget({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  State<FeedbackCategoryWidget> createState() => _FeedbackCategoryWidgetState();
}

class _FeedbackCategoryWidgetState extends State<FeedbackCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          FeedbackCategory.values.map((category) {
            final isSelected = widget.selectedCategory == category;
            return GestureDetector(
              onTap: () => widget.onCategorySelected(category),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? const Color(0xFFff7a4b).withOpacity(0.1)
                              : const Color(0xFF33323a),
                      borderRadius: BorderRadius.circular(12),
                      border:
                          isSelected
                              ? Border.all(
                                color: const Color(0xFFff7a4b),
                                width: 2,
                              )
                              : null,
                    ),
                    child: Icon(
                      category.icon,
                      color:
                          isSelected
                              ? const Color(0xFFff7a4b)
                              : Colors.white.withOpacity(0.7),
                      size: 28,
                    ),
                  ),
                  UIUtils.verticalSpace8,
                  Text(
                    category.label,
                    style: TextStyle(
                      color:
                          isSelected
                              ? const Color(0xFFff7a4b)
                              : Colors.white.withOpacity(0.7),
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
