import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:striide_flutter/core/core.dart';
import 'package:striide_flutter/features/onboarding/providers/onboarding_provider.dart';
import 'package:striide_flutter/features/onboarding/screens/share_screen.dart';

class CompleteProfile2 extends StatefulWidget {
  const CompleteProfile2({super.key});

  @override
  State<CompleteProfile2> createState() => _CompleteProfile2State();
}

class _CompleteProfile2State extends State<CompleteProfile2> {
  @override
  void initState() {
    super.initState();
    // Add listeners to controllers for validation
    final provider = context.read<OnboardingProvider>();
    provider.firstNameController.addListener(() => provider.validateProfile2());
    provider.lastNameController.addListener(() => provider.validateProfile2());
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
                      title: "One last step!",
                      privacyText: 'The information below will be ',
                      highlightedText: 'PUBLIC',
                      highlightColor: const Color(0xFFD4AF37),
                      subtitle: "and will help you connect with people",
                      icon: Icons.public,
                      iconColor: const Color(0xFF00A886),
                    ),

                    SizedBox(height: 32 * heightMultiplier),

                    // Form fields
                    _buildFormFields(
                      provider,
                      heightMultiplier,
                      widthMultiplier,
                    ),

                    SizedBox(height: 40 * heightMultiplier),

                    // Continue button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FadeInWidget(
                          duration: const Duration(milliseconds: 700),
                          delay: const Duration(milliseconds: 1400),
                          slideOffset: const Offset(0.0, 0.4),
                          child: ContinueButton(
                            isEnabled: provider.isProfile2Valid,
                            onPressed: () => _saveProfileAndNavigate(provider),
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
        // Bio field (expandable)
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 600),
          slideOffset: const Offset(0.0, 0.4),
          child: ExpandableBioField(controller: provider.bioController),
        ),

        SizedBox(height: 24 * heightMultiplier),

        // First Name field
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 800),
          slideOffset: const Offset(0.0, 0.4),
          child: CustomFormField(
            label: "First name",
            controller: provider.firstNameController,
            hintText: "What should we call you",
          ),
        ),

        SizedBox(height: 24 * heightMultiplier),

        // Last Name field
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 1000),
          slideOffset: const Offset(0.0, 0.4),
          child: CustomFormField(
            label: "Last name",
            controller: provider.lastNameController,
            hintText: "What should we call you",
          ),
        ),

        SizedBox(height: 24 * heightMultiplier),

        // Pronouns dropdown
        FadeInWidget(
          duration: const Duration(milliseconds: 700),
          delay: const Duration(milliseconds: 1200),
          slideOffset: const Offset(0.0, 0.4),
          child: CustomDropdownField(
            label: "Pronouns",
            value: provider.selectedPronouns,
            hintText: "she/her, they/them",
            options: provider.pronounOptions,
            onChanged: (String? newValue) {
              provider.setSelectedPronouns(newValue ?? '');
            },
          ),
        ),
      ],
    );
  }

  Future<void> _saveProfileAndNavigate(OnboardingProvider provider) async {
    final success = await provider.saveProfile2();
    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        AppAnimations.slideTransition(const ShareScreen()),
      );
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
