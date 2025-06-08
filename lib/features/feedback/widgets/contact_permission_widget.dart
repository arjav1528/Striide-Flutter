import 'package:flutter/material.dart';
import 'package:striide_flutter/core/utils/ui_utils.dart';

class ContactPermissionWidget extends StatelessWidget {
  final bool? allowContact;
  final ValueChanged<bool> onPermissionChanged;

  const ContactPermissionWidget({
    super.key,
    required this.allowContact,
    required this.onPermissionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Can we contact you about your feedback?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Nunito',
          ),
        ),
        UIUtils.verticalSpace12,
        Row(
          children: [
            GestureDetector(
              onTap: () => onPermissionChanged(false),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                        width: 2,
                      ),
                      color:
                          allowContact == false
                              ? Colors.white
                              : Colors.transparent,
                    ),
                    child:
                        allowContact == false
                            ? const Icon(
                              Icons.circle,
                              size: 10,
                              color: Color(0xFF292732),
                            )
                            : null,
                  ),
                  UIUtils.horizontalSpace8,
                  const Text(
                    'No',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
            ),
            UIUtils.horizontalSpace24,
            GestureDetector(
              onTap: () => onPermissionChanged(true),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                        width: 2,
                      ),
                      color:
                          allowContact == true
                              ? Colors.white
                              : Colors.transparent,
                    ),
                    child:
                        allowContact == true
                            ? const Icon(
                              Icons.circle,
                              size: 10,
                              color: Color(0xFF292732),
                            )
                            : null,
                  ),
                  UIUtils.horizontalSpace8,
                  const Text(
                    'Yes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
