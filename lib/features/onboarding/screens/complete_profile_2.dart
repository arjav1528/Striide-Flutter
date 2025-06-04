import 'package:flutter/material.dart';
import 'package:striide_flutter/core/core.dart';
import 'package:striide_flutter/features/onboarding/screens/share_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompleteProfile2 extends StatefulWidget {
  const CompleteProfile2({super.key});

  @override
  State<CompleteProfile2> createState() => _CompleteProfile2State();
}

class _CompleteProfile2State extends State<CompleteProfile2> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  String selectedPronouns = '';
  bool bioExpanded = false;
  final TextEditingController bioController = TextEditingController();

  // Pronouns options
  final List<String> pronounOptions = [
    'she/her',
    'they/them',
    'he/him',
    'she/they',
    'he/they',
    'other',
  ];

  // Colors from theme - matching CompleteProfile1
  static const Color primaryGreen = Color(0xFF00A886);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color bgDark = Color(0xFF282632);

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightMultiplier = MediaQuery.of(context).size.height / 852;
    double widthMultiplier = MediaQuery.of(context).size.width / 393;

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
                _buildNextButton(heightMultiplier, widthMultiplier),
                SizedBox(height: 16 * heightMultiplier),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header section with animations
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
                "One last step!",
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
                    Icons.public,
                    color: primaryGreen,
                    size: 20 * widthMultiplier,
                  ),
                  SizedBox(width: 8 * widthMultiplier),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'The information below will be ',
                        style: TextStyle(
                          fontSize: 16 * widthMultiplier,
                          color: Colors.white,
                          fontFamily: AppTheme.bodyFontFamily,
                        ),
                        children: [
                          TextSpan(
                            text: 'PUBLIC',
                            style: TextStyle(
                              color: accentGold,
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
                "and will help you connect with people",
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
                "Let's build your profile!",
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

  // Form fields with animations
  Widget _buildFormFields(double heightMultiplier, double widthMultiplier) {
    return Column(
      children: [
        // Bio field
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 600),
          slideOffset: const Offset(0.0, 0.4),
          child: _buildBioField(heightMultiplier, widthMultiplier),
        ),
        SizedBox(height: 24 * heightMultiplier),

        // First Name field
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 800),
          slideOffset: const Offset(0.0, 0.4),
          child: _buildFormField(
            "First Name",
            firstNameController,
            "What should we call you?",
            heightMultiplier,
            widthMultiplier,
          ),
        ),
        SizedBox(height: 24 * heightMultiplier),

        // Last Name field
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 1000),
          slideOffset: const Offset(0.0, 0.4),
          child: _buildFormField(
            "Last Name",
            lastNameController,
            "What should we call you?",
            heightMultiplier,
            widthMultiplier,
          ),
        ),
        SizedBox(height: 24 * heightMultiplier),

        // Pronouns dropdown
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 1200),
          slideOffset: const Offset(0.0, 0.4),
          child: _buildPronounsDropdown(heightMultiplier, widthMultiplier),
        ),
      ],
    );
  }

  // Reusable form field builder
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
            child: Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14 * widthMultiplier,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppTheme.bodyFontFamily,
                  ),
                ),
              ],
            ),
          ),

          // Field input
          Container(
            height: 40 * heightMultiplier,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12 * widthMultiplier),
                bottomRight: Radius.circular(12 * widthMultiplier),
              ),
            ),
            child: TextFormField(
              controller: controller,
              readOnly: readOnly,
              onTap: onTap,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: primaryGreen,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
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
            ),
          ),
        ],
      ),
    );
  }

  // Bio expandable field
  Widget _buildBioField(double heightMultiplier, double widthMultiplier) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              bioExpanded = !bioExpanded;
            });
          },
          child: Container(
            width: 329 * widthMultiplier,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12 * widthMultiplier),
              border: Border.all(color: primaryGreen, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(12 * widthMultiplier),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bio",
                    style: TextStyle(
                      fontSize: 16 * widthMultiplier,
                      color: Colors.white,
                      fontFamily: AppTheme.bodyFontFamily,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    bioExpanded ? Icons.remove : Icons.add,
                    color: primaryGreen,
                    size: 24 * widthMultiplier,
                  ),
                ],
              ),
            ),
          ),
        ),

        if (bioExpanded)
          FadeInWidget(
            duration: const Duration(milliseconds: 400),
            slideOffset: const Offset(0.0, 0.2),
            child: Padding(
              padding: EdgeInsets.only(top: 8 * heightMultiplier),
              child: Container(
                width: 329 * widthMultiplier,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12 * widthMultiplier),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: bioController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Write something about yourself...",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontFamily: AppTheme.bodyFontFamily,
                      fontSize: 15 * widthMultiplier,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16 * widthMultiplier),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: AppTheme.bodyFontFamily,
                    fontSize: 14 * widthMultiplier,
                  ),
                  cursorColor: primaryGreen,
                ),
              ),
            ),
          ),
      ],
    );
  }

  // Pronouns dropdown field
  Widget _buildPronounsDropdown(
    double heightMultiplier,
    double widthMultiplier,
  ) {
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
            child: Row(
              children: [
                Text(
                  "Pronouns",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14 * widthMultiplier,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppTheme.bodyFontFamily,
                  ),
                ),
              ],
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
                value: selectedPronouns.isNotEmpty ? selectedPronouns : null,
                hint: Text(
                  "she/her, they/them",
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
                    selectedPronouns = newValue!;
                  });
                },
                items:
                    pronounOptions.map<DropdownMenuItem<String>>((
                      String value,
                    ) {
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

  // Next button
  Widget _buildNextButton(double heightMultiplier, double widthMultiplier) {
    final bool isFormValid =
        firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        selectedPronouns.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 40 * widthMultiplier),
      child: GestureDetector(
        onTap: isFormValid ? _saveProfileAndNavigate : null,
        child: Container(
          height: 56 * heightMultiplier,
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
      ),
    );
  }

  // Save profile and navigate
  Future<void> _saveProfileAndNavigate() async {
    try {
      await Supabase.instance.client
          .from('profiles')
          .update({
            'first_name': firstNameController.text,
            'last_name': lastNameController.text,
            'pronouns': selectedPronouns,
            'bio': bioController.text,
          })
          .eq('userId', Supabase.instance.client.auth.currentUser!.id);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) => const ShareScreen(),
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
