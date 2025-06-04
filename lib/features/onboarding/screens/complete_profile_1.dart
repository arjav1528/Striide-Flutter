import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:striide_flutter/core/core.dart';

import 'complete_profile_2.dart';

class CompleteProfile1 extends StatefulWidget {
  const CompleteProfile1({super.key});

  @override
  State<CompleteProfile1> createState() => _CompleteProfile1State();
}

class _CompleteProfile1State extends State<CompleteProfile1> {
  // Form state
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  String selectedGender = '';
  DateTime? selectedDate;
  bool termsAccepted = false;

  // Gender options
  final List<String> genders = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say',
  ];

  // Colors from theme
  static const Color primaryGreen = Color(0xFF00A886);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color safeGreen = Color(0xFF4CD964);
  static const Color bgDark = Color(0xFF282632);

  @override
  void dispose() {
    occupationController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use responsive sizing
    final size = MediaQuery.of(context).size;
    final heightMultiplier = size.height / 852;
    final widthMultiplier = size.width / 393;

    return Scaffold(
      backgroundColor: bgDark,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0 * widthMultiplier,
              vertical: 16.0 * heightMultiplier,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40 * heightMultiplier),
                _buildHeaderSection(heightMultiplier, widthMultiplier),
                SizedBox(height: 32 * heightMultiplier),
                _buildFormFields(heightMultiplier, widthMultiplier),
                SizedBox(height: 40 * heightMultiplier),
                _buildTermsAndConditions(heightMultiplier, widthMultiplier),
                SizedBox(height: 50 * heightMultiplier),
                _buildNextButton(heightMultiplier, widthMultiplier),
                SizedBox(height: 16 * heightMultiplier),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(double heightMultiplier, double widthMultiplier) {
    return StaggeredList(
      itemDelay: const Duration(milliseconds: 150),
      itemDuration: const Duration(milliseconds: 600),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16 * widthMultiplier,
                vertical: 8 * heightMultiplier,
              ),
              decoration: BoxDecoration(
                color: accentGold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16 * widthMultiplier),
              ),
              child: Text(
                "You're almost there!",
                style: TextStyle(
                  fontSize: 24 * widthMultiplier,
                  fontWeight: FontWeight.bold,
                  color: accentGold,
                  letterSpacing: 0.5,
                  fontFamily: AppTheme.primaryFontFamily,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20 * heightMultiplier),
        Container(
          padding: EdgeInsets.all(12 * widthMultiplier),
          decoration: BoxDecoration(
            color: bgDark.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12 * widthMultiplier),
            border: Border.all(color: primaryGreen.withOpacity(0.3), width: 1),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.privacy_tip_outlined,
                    color: safeGreen,
                    size: 20 * widthMultiplier,
                  ),
                  SizedBox(width: 8 * widthMultiplier),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'The information below stays ',
                        style: TextStyle(
                          fontSize: 16 * widthMultiplier,
                          color: Colors.white,
                          fontFamily: AppTheme.bodyFontFamily,
                        ),
                        children: [
                          TextSpan(
                            text: 'PRIVATE',
                            style: TextStyle(
                              color: safeGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 16 * widthMultiplier,
                              fontFamily: AppTheme.bodyFontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4 * heightMultiplier),
              Text(
                "and won't be visible on your profile.",
                style: TextStyle(
                  fontSize: 16 * widthMultiplier,
                  color: Colors.white,
                  fontFamily: AppTheme.bodyFontFamily,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20 * heightMultiplier),
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_outline,
                color: primaryGreen,
                size: 20 * widthMultiplier,
              ),
              SizedBox(width: 8 * widthMultiplier),
              Text(
                "Share a little about you!",
                style: TextStyle(
                  fontSize: 18 * widthMultiplier,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontFamily: AppTheme.bodyFontFamily,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(double heightMultiplier, double widthMultiplier) {
    return Column(
      children: [
        // Occupation field
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 800),
          slideOffset: const Offset(0.0, 0.4),
          child: _buildFormField(
            "Occupation",
            occupationController,
            "Besides changing the world",
            heightMultiplier,
            widthMultiplier,
          ),
        ),
        SizedBox(height: 24 * heightMultiplier),

        // Gender dropdown
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 1000),
          slideOffset: const Offset(0.0, 0.4),
          child: _buildGenderDropdown(heightMultiplier, widthMultiplier),
        ),
        SizedBox(height: 24 * heightMultiplier),

        // Birthday field
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 1200),
          slideOffset: const Offset(0.0, 0.4),
          child: _buildBirthdayField(heightMultiplier, widthMultiplier),
        ),
      ],
    );
  }

  Widget _buildFormField(
    String label,
    TextEditingController controller,
    String hintText,
    double heightMultiplier,
    double widthMultiplier, {
    bool readOnly = false,
    Widget? suffixIcon,
    VoidCallback? onTap,
  }) {
    return Container(
      height: 72 * heightMultiplier,
      width: 329 * widthMultiplier,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * widthMultiplier),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Field label
          Container(
            height: 32 * heightMultiplier,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16 * widthMultiplier,
              vertical: 6 * heightMultiplier,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12 * widthMultiplier),
                topRight: Radius.circular(12 * widthMultiplier),
              ),
              color: primaryGreen,
            ),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14 * widthMultiplier,
                fontWeight: FontWeight.w600,
                fontFamily: AppTheme.bodyFontFamily,
              ),
            ),
          ),

          // Field input
          SizedBox(
            height: 40 * heightMultiplier,
            child: TextFormField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16 * widthMultiplier,
                ),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: AppTheme.bodyFontFamily,
                  fontSize: 14 * widthMultiplier,
                ),
                suffixIcon: suffixIcon,
              ),
              style: TextStyle(
                color: Colors.black,
                fontFamily: AppTheme.bodyFontFamily,
                fontSize: 15 * widthMultiplier,
              ),
              cursorColor: primaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown(double heightMultiplier, double widthMultiplier) {
    return Container(
      height: 72 * heightMultiplier,
      width: 329 * widthMultiplier,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12 * widthMultiplier),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Container(
            height: 32 * heightMultiplier,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16 * widthMultiplier,
              vertical: 6 * heightMultiplier,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12 * widthMultiplier),
                topRight: Radius.circular(12 * widthMultiplier),
              ),
              color: primaryGreen,
            ),
            child: Text(
              "Gender",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14 * widthMultiplier,
                fontWeight: FontWeight.w600,
                fontFamily: AppTheme.bodyFontFamily,
              ),
            ),
          ),

          // Dropdown
          Container(
            height: 40 * heightMultiplier,
            padding: EdgeInsets.symmetric(horizontal: 16 * widthMultiplier),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12 * widthMultiplier),
                bottomRight: Radius.circular(12 * widthMultiplier),
              ),
              color: Colors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedGender.isNotEmpty ? selectedGender : null,
                hint: Text(
                  "Select your gender",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontFamily: AppTheme.bodyFontFamily,
                    fontSize: 14 * widthMultiplier,
                  ),
                ),
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: primaryGreen,
                  size: 24 * widthMultiplier,
                ),
                dropdownColor: Colors.white,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue!;
                  });
                },
                items:
                    genders.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: AppTheme.bodyFontFamily,
                            fontSize: 14 * widthMultiplier,
                          ),
                        ),
                      );
                    }).toList(),
                padding: EdgeInsets.zero,
                menuMaxHeight: 200 * heightMultiplier,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBirthdayField(double heightMultiplier, double widthMultiplier) {
    return _buildFormField(
      "Birthday",
      birthdayController,
      "Select your birthday",
      heightMultiplier,
      widthMultiplier,
      readOnly: true,
      suffixIcon: Icon(
        Icons.calendar_today,
        color: Colors.black,
        size: 20 * widthMultiplier,
      ),
      onTap: () => _selectDate(context, widthMultiplier),
    );
  }

  Future<void> _selectDate(BuildContext context, double widthMultiplier) async {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo = DateTime(
      now.year - 18,
      now.month,
      now.day,
    );

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? eighteenYearsAgo,
      firstDate: DateTime(1923),
      lastDate: eighteenYearsAgo,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: primaryGreen,
              onPrimary: Colors.white,
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: accentGold),
            ),
            dialogTheme: const DialogThemeData(backgroundColor: bgDark),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthdayController.text = DateFormat('MMM dd, yyyy').format(picked);
      });
    }
  }

  Widget _buildTermsAndConditions(
    double heightMultiplier,
    double widthMultiplier,
  ) {
    return Container(
      padding: EdgeInsets.all(12 * widthMultiplier),
      decoration: BoxDecoration(
        color: bgDark.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12 * widthMultiplier),
        border: Border.all(color: primaryGreen.withOpacity(0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24 * widthMultiplier,
            height: 24 * heightMultiplier,
            child: Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: termsAccepted,
                onChanged: (value) {
                  setState(() {
                    termsAccepted = value ?? false;
                  });
                },
                fillColor: WidgetStateProperty.resolveWith<Color>(
                  (states) =>
                      states.contains(WidgetState.selected)
                          ? primaryGreen
                          : Colors.white,
                ),
                checkColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(width: 12 * widthMultiplier),
          Expanded(
            child: Text(
              "I hereby confirm that I have read and agree to the Terms of Service and Privacy Policy.",
              style: TextStyle(
                fontSize: 14 * widthMultiplier,
                color: Colors.white,
                height: 1.4,
                fontFamily: AppTheme.secondaryFontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton(double heightMultiplier, double widthMultiplier) {
    final bool isFormValid =
        occupationController.text.isNotEmpty &&
        selectedGender.isNotEmpty &&
        selectedDate != null &&
        termsAccepted;

    return GestureDetector(
      onTap: isFormValid ? _navigateToNextScreen : null,
      child: Container(
        width: double.infinity,
        height: 56 * heightMultiplier,
        margin: EdgeInsets.symmetric(horizontal: 40 * widthMultiplier),
        decoration: BoxDecoration(
          color: isFormValid ? primaryGreen : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(28 * heightMultiplier),
          boxShadow:
              isFormValid
                  ? [
                    BoxShadow(
                      color: primaryGreen.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CONTINUE",
              style: TextStyle(
                color: isFormValid ? Colors.white : Colors.grey,
                fontSize: 16 * widthMultiplier,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontFamily: AppTheme.primaryFontFamily,
              ),
            ),
            SizedBox(width: 12 * widthMultiplier),
            Icon(
              Icons.arrow_forward_rounded,
              size: 24 * widthMultiplier,
              color: isFormValid ? Colors.white : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToNextScreen() async {
    try {
      await Supabase.instance.client
          .from('profiles')
          .update({
            'occupation': occupationController.text,
            'gender': selectedGender,
            'birthday': birthdayController.text,
          })
          .eq('userId', Supabase.instance.client.auth.currentUser!.id);

      if (mounted) {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    const CompleteProfile2(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(
                begin: begin,
                end: end,
              ).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      }
    } catch (error) {
      debugPrint("Error updating profile: $error");
    }
  }
}
