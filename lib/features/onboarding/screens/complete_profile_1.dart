import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:striide_flutter/core/core.dart';
import 'package:striide_flutter/features/onboarding/providers/onboarding_provider.dart';

import 'complete_profile_2.dart';

class CompleteProfile1 extends StatefulWidget {
  const CompleteProfile1({super.key});

  @override
  State<CompleteProfile1> createState() => _CompleteProfile1State();
}

class _CompleteProfile1State extends State<CompleteProfile1> {
  @override
  void initState() {
    super.initState();
    // Add listeners to controllers for validation
    final provider = context.read<OnboardingProvider>();
    provider.occupationController.addListener(
      () => provider.validateProfile1(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightMultiplier = size.height / 852;
    final widthMultiplier = size.width / 393;

    return Consumer<OnboardingProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF282632),
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

                    // Header section
                    OnboardingHeader(
                      title: "You're almost there!",
                      privacyText: 'The information below stays ',
                      highlightedText: 'PRIVATE',
                      highlightColor: const Color(0xFF4CD964),
                      subtitle: "and won't be visible on your profile.",
                      icon: Icons.privacy_tip_outlined,
                      iconColor: const Color(0xFF4CD964),
                    ),

                    SizedBox(height: 32 * heightMultiplier),

                    // Form fields
                    _buildFormFields(
                      provider,
                      heightMultiplier,
                      widthMultiplier,
                    ),

                    SizedBox(height: 40 * heightMultiplier),

                    // Terms and conditions
                    FadeInWidget(
                      duration: const Duration(milliseconds: 700),
                      delay: const Duration(milliseconds: 1400),
                      slideOffset: const Offset(0.0, 0.4),
                      child: TermsCheckbox(
                        value: provider.termsAccepted,
                        onChanged: (value) {
                          provider.setTermsAccepted(value ?? false);
                        },
                      ),
                    ),

                    SizedBox(height: 50 * heightMultiplier),

                    // Continue button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FadeInWidget(
                          duration: const Duration(milliseconds: 700),
                          delay: const Duration(milliseconds: 1600),
                          slideOffset: const Offset(0.0, 0.4),
                          child: ContinueButton(
                            isEnabled: provider.isProfile1Valid,
                            onPressed: () => _navigateToNextScreen(provider),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16 * heightMultiplier),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormFields(
    OnboardingProvider provider,
    double heightMultiplier,
    double widthMultiplier,
  ) {
    return Column(
      children: [
        // Occupation field
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 800),
          slideOffset: const Offset(0.0, 0.4),
          child: CustomFormField(
            label: "Occupation",
            controller: provider.occupationController,
            hintText: "Besides changing the world",
          ),
        ),

        SizedBox(height: 24 * heightMultiplier),

        // Gender dropdown
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 1000),
          slideOffset: const Offset(0.0, 0.4),
          child: CustomDropdownField(
            label: "Gender",
            value: provider.selectedGender,
            hintText: "Let us know who you are!",
            options: provider.genders,
            onChanged: (String? newValue) {
              provider.setSelectedGender(newValue ?? '');
            },
          ),
        ),

        SizedBox(height: 24 * heightMultiplier),

        // Birthday field
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 1200),
          slideOffset: const Offset(0.0, 0.4),
          child: CustomFormField(
            label: "Birthday",
            controller: provider.birthdayController,
            hintText: "DD/MM/YY",
            readOnly: true,
            suffixIcon: Icon(
              Icons.calendar_today,
              color: Colors.grey.shade600,
              size: 20 * widthMultiplier,
            ),
            onTap: () => _selectDate(context, provider),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    OnboardingProvider provider,
  ) async {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo = DateTime(
      now.year - 18,
      now.month,
      now.day,
    );

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.selectedDate ?? eighteenYearsAgo,
      firstDate: DateTime(1923),
      lastDate: eighteenYearsAgo,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00A886),
              onPrimary: Colors.white,
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFD4AF37),
              ),
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF282632),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != provider.selectedDate) {
      provider.setSelectedDate(picked);
    }
  }

  Future<void> _navigateToNextScreen(OnboardingProvider provider) async {
    final success = await provider.saveProfile1();
    if (success && mounted) {
      Navigator.of(
        context,
      ).push(AppAnimations.slideTransition(const CompleteProfile2()));
    } else if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save profile. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
