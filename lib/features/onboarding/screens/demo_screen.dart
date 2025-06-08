import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:striide_flutter/core/core.dart';
import 'package:striide_flutter/features/onboarding/providers/onboarding_provider.dart';
import 'package:striide_flutter/features/home/screens/home.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final heightMultiplier = size.height / 852;
    final widthMultiplier = size.width / 393;

    return Consumer<OnboardingProvider>(
      builder: (context, provider, child) {
        final profileData = provider.getProfileSummary();

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

                    // Header
                    _buildHeader(heightMultiplier, widthMultiplier),

                    SizedBox(height: 40 * heightMultiplier),

                    // Profile Card
                    _buildProfileCard(
                      profileData,
                      heightMultiplier,
                      widthMultiplier,
                    ),

                    SizedBox(height: 40 * heightMultiplier),

                    // Welcome Message
                    _buildWelcomeMessage(
                      profileData['firstName'],
                      heightMultiplier,
                      widthMultiplier,
                    ),

                    SizedBox(height: 50 * heightMultiplier),

                    // Continue Button
                    _buildContinueButton(
                      context,
                      heightMultiplier,
                      widthMultiplier,
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

  Widget _buildHeader(double heightMultiplier, double widthMultiplier) {
    return FadeInWidget(
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 100),
      slideOffset: const Offset(0.0, -0.3),
      child: Column(
        children: [
          // Success Icon
          Container(
            width: 80 * widthMultiplier,
            height: 80 * heightMultiplier,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00A886), Color(0xFF4CD964)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00A886).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 40 * widthMultiplier,
            ),
          ),

          SizedBox(height: 20 * heightMultiplier),

          // Title
          ShaderMask(
            shaderCallback:
                (bounds) => const LinearGradient(
                  colors: [Color(0xFFD4AF37), Color(0xFFE9D172)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
            child: Text(
              "Profile Complete!",
              style: TextStyle(
                fontSize: 28 * widthMultiplier,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Montserrat",
              ),
            ),
          ),

          SizedBox(height: 8 * heightMultiplier),

          Text(
            "Here's how your profile looks",
            style: TextStyle(
              fontSize: 16 * widthMultiplier,
              color: Colors.grey.shade300,
              fontFamily: "Nunito",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(
    Map<String, dynamic> profileData,
    double heightMultiplier,
    double widthMultiplier,
  ) {
    return FadeInWidget(
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 300),
      slideOffset: const Offset(0.0, 0.3),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 8 * widthMultiplier),
        padding: EdgeInsets.all(24 * widthMultiplier),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF33333b).withOpacity(0.8),
              const Color(0xFF2A2A3E).withOpacity(0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(20 * widthMultiplier),
          border: Border.all(
            color: const Color(0xFF00A886).withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name and Pronouns
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${profileData['firstName']} ${profileData['lastName']}",
                        style: TextStyle(
                          fontSize: 24 * widthMultiplier,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Montserrat",
                        ),
                      ),
                      SizedBox(height: 4 * heightMultiplier),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12 * widthMultiplier,
                          vertical: 4 * heightMultiplier,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4AF37).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFD4AF37),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          profileData['pronouns'],
                          style: TextStyle(
                            fontSize: 12 * widthMultiplier,
                            color: const Color(0xFFD4AF37),
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Profile Avatar Placeholder
                Container(
                  width: 60 * widthMultiplier,
                  height: 60 * heightMultiplier,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6B18D8), Color(0xFF8442E0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      "${profileData['firstName'][0]}${profileData['lastName'][0]}",
                      style: TextStyle(
                        fontSize: 20 * widthMultiplier,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20 * heightMultiplier),

            // Bio
            if (profileData['bio'].isNotEmpty) ...[
              Text(
                "Bio",
                style: TextStyle(
                  fontSize: 14 * widthMultiplier,
                  color: const Color(0xFF00A886),
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8 * heightMultiplier),
              Text(
                profileData['bio'],
                style: TextStyle(
                  fontSize: 16 * widthMultiplier,
                  color: Colors.grey.shade300,
                  fontFamily: "Nunito",
                  height: 1.4,
                ),
              ),
              SizedBox(height: 16 * heightMultiplier),
            ],

            // Profile Details
            _buildProfileDetail(
              "Occupation",
              profileData['occupation'],
              Icons.work_outline,
              widthMultiplier,
              heightMultiplier,
            ),

            SizedBox(height: 12 * heightMultiplier),

            _buildProfileDetail(
              "Birthday",
              profileData['birthday'],
              Icons.cake_outlined,
              widthMultiplier,
              heightMultiplier,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail(
    String label,
    String value,
    IconData icon,
    double widthMultiplier,
    double heightMultiplier,
  ) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF00A886), size: 20 * widthMultiplier),
        SizedBox(width: 12 * widthMultiplier),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12 * widthMultiplier,
                color: Colors.grey.shade400,
                fontFamily: "Nunito",
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14 * widthMultiplier,
                color: Colors.white,
                fontFamily: "Nunito",
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWelcomeMessage(
    String firstName,
    double heightMultiplier,
    double widthMultiplier,
  ) {
    return FadeInWidget(
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 500),
      slideOffset: const Offset(0.0, 0.3),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20 * widthMultiplier),
        decoration: BoxDecoration(
          color: const Color(0xFF6B18D8).withOpacity(0.1),
          borderRadius: BorderRadius.circular(16 * widthMultiplier),
          border: Border.all(
            color: const Color(0xFF6B18D8).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              Icons.celebration,
              color: const Color(0xFFD4AF37),
              size: 32 * widthMultiplier,
            ),
            SizedBox(height: 12 * heightMultiplier),
            Text(
              "Welcome to Striide, $firstName!",
              style: TextStyle(
                fontSize: 20 * widthMultiplier,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Montserrat",
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8 * heightMultiplier),
            Text(
              "You're all set up and ready to start connecting with amazing people. Let's begin your journey!",
              style: TextStyle(
                fontSize: 16 * widthMultiplier,
                color: Colors.grey.shade300,
                fontFamily: "Nunito",
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton(
    BuildContext context,
    double heightMultiplier,
    double widthMultiplier,
  ) {
    return FadeInWidget(
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 700),
      slideOffset: const Offset(0.0, 0.3),
      child: GestureDetector(
        onTap: () => _navigateToHome(context),
        child: Container(
          height: 56 * heightMultiplier,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00A886), Color(0xFF4CD964)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12 * widthMultiplier),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00A886).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Continue to App",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18 * widthMultiplier,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8 * widthMultiplier),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 20 * widthMultiplier,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      AppAnimations.fadeTransition(const HomeScreen()),
    );
  }
}
