import 'package:flutter/material.dart';
import 'package:striide_flutter/core/theme/app_theme.dart';
import 'package:striide_flutter/core/utils/ui_utils.dart';

class StarRatingWidget extends StatefulWidget {
  final int starCount;
  final int currentRating;
  final ValueChanged<int> onRatingChanged;
  final double starSize;
  final Color activeColor;
  final Color inactiveColor;

  const StarRatingWidget({
    super.key,
    this.starCount = 5,
    required this.currentRating,
    required this.onRatingChanged,
    this.starSize = 40.0,
    this.activeColor = const Color(0xFFff7a4b),
    this.inactiveColor = const Color(0xFF424242),
  });

  @override
  State<StarRatingWidget> createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: UIUtils.screenWidth * 0.8,
      height: UIUtils.screenHeight * 0.1,
      decoration: BoxDecoration(
        color: const Color(0xFF33323a),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          widget.starCount,
          (index) => GestureDetector(
            onTap: () => widget.onRatingChanged(index + 1),
            child: Icon(
              Icons.star_outline_rounded,
              size: widget.starSize,
              color:
                  index < widget.currentRating
                      ? widget.activeColor
                      : widget.inactiveColor,
            ),
          ),
        ),
      ),
    );
  }
}
