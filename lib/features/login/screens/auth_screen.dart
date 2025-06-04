import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:striide_flutter/core/core.dart';
import 'package:striide_flutter/features/onboarding/screens/complete_profile_1.dart';
import 'package:striide_flutter/screens/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());
  final supabase = Supabase.instance.client;
  bool _isOtpSent = false;
  bool _isLoading = false;
  final bool _isSignUpMode =
      false; 

  @override
  void initState() {
    super.initState();
    AppLogger.info('LoginScreen initialized');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    AppLogger.info('LoginScreen disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.06,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildHeader(),
                      const Spacer(flex: 1),
                      _buildAuthCard(),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final size = MediaQuery.of(context).size;
    final widthMultiplier = size.width / 393;

    return FadeInWidget(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 100),
      slideOffset: const Offset(0.0, -0.3),
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.08),
        child: Column(
          children: [
            Text(
              "Striide",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Inter",
                fontSize: 48 * widthMultiplier,
                fontWeight: FontWeight.w800,
                letterSpacing: 3,
                shadows: [
                  Shadow(
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthCard() {
    final size = MediaQuery.of(context).size;

    return FadeInWidget(
      duration: const Duration(milliseconds: 800),
      delay: const Duration(milliseconds: 300),
      slideOffset: const Offset(0.0, 0.5),
      curve: Curves.easeOutBack,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: size.width * 0.9),
        padding: EdgeInsets.all(size.width * 0.08),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
              spreadRadius: 5,
            ),
            BoxShadow(
              color: Colors.purple.withOpacity(0.15),
              blurRadius: 40,
              offset: const Offset(0, 20),
              spreadRadius: -5,
            ),
          ],
        ),
        child: StaggeredList(
          itemDelay: const Duration(milliseconds: 200),
          itemDuration: const Duration(milliseconds: 600),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildWelcomeText(),
            SizedBox(height: size.height * 0.04),
            _buildPhoneNumberSection(),
            SizedBox(height: size.height * 0.04),
            if (_isOtpSent) _buildOtpSection(),
            SizedBox(height: size.height * 0.03),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    final widthMultiplier = MediaQuery.of(context).size.width / 393;

    return Column(
      children: [
        Text(
          "Welcome to Striide",
          style: TextStyle(
            fontSize: 28 * widthMultiplier,
            fontFamily: "Inter",
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D1B69),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.004),
        Text(
          "Sign in with your phone number",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14 * widthMultiplier,
            fontFamily: "Inter",
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberSection() {
    final size = MediaQuery.of(context).size;
    final widthMultiplier = size.width / 393;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: TextStyle(
            fontSize: 14 * widthMultiplier,
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            color: const Color(0xFF374151),
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        _buildPhoneTextField(),
      ],
    );
  }

  Widget _buildPhoneTextField() {
    final size = MediaQuery.of(context).size;
    final widthMultiplier = size.width / 393;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        enabled: !_isLoading,
        style: TextStyle(
          color: const Color(0xFF111827),
          fontFamily: "Inter",
          fontSize: 16 * widthMultiplier,
          fontWeight: FontWeight.w500,
        ),
        onChanged: (val) {
          setState(() {});
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
          ),
          prefixIcon: Container(
            padding: EdgeInsets.all(12 * widthMultiplier),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "+91",
                  style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontFamily: "Inter",
                    fontSize: 16 * widthMultiplier,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8 * widthMultiplier),
                Container(height: 20, width: 1, color: const Color(0xFFE5E7EB)),
              ],
            ),
          ),
          hintText: "Enter your phone number",
          hintStyle: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontFamily: "Inter",
            fontSize: 16 * widthMultiplier,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: size.height * 0.02,
            horizontal: 16 * widthMultiplier,
          ),
        ),
      ),
    );
  }

  Widget _buildOtpSection() {
    final size = MediaQuery.of(context).size;
    final widthMultiplier = size.width / 393;

    return Column(
      children: [
        Text(
          "Enter Verification Code",
          style: TextStyle(
            color: const Color(0xFF374151),
            fontFamily: "Inter",
            fontSize: 16 * widthMultiplier,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Text(
          "We've sent a 6-digit code to your phone",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF6B7280),
            fontFamily: "Inter",
            fontSize: 13 * widthMultiplier,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: size.height * 0.03),
        _buildOtpFields(),
      ],
    );
  }

  Widget _buildOtpFields() {
    final size = MediaQuery.of(context).size;
    final widthMultiplier = size.width / 393;

    return Column(
      children: [
        SizedBox(
          width: size.width * 0.85,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (index) => _buildOtpTextField(
                _otpControllers[index],
                _otpFocusNodes[index],
                index < 5 ? _otpFocusNodes[index + 1] : null,
                index,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.025),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive code? ",
              style: TextStyle(
                color: const Color(0xFF6B7280),
                fontFamily: "Inter",
                fontSize: 14 * widthMultiplier,
                fontWeight: FontWeight.w400,
              ),
            ),
            GestureDetector(
              onTap: !_isLoading ? _sendOtp : null,
              child: Text(
                "Resend OTP",
                style: TextStyle(
                  color:
                      _isLoading
                          ? const Color(0xFF8B5CF6).withOpacity(0.5)
                          : const Color(0xFF8B5CF6),
                  fontFamily: "Inter",
                  fontSize: 14 * widthMultiplier,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOtpTextField(
    TextEditingController controller,
    FocusNode focusNode,
    FocusNode? nextFocusNode,
    int index,
  ) {
    final size = MediaQuery.of(context).size;
    final widthMultiplier = size.width / 393;
    final isFieldActive = focusNode.hasFocus;
    final hasValue = controller.text.isNotEmpty;

    return Container(
      width: size.width * 0.12,
      height: size.width * 0.14,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              isFieldActive
                  ? const Color(0xFF8B5CF6)
                  : hasValue
                  ? const Color(0xFF8B5CF6).withOpacity(0.5)
                  : const Color(0xFFE5E7EB),
          width: isFieldActive || hasValue ? 1.5 : 1,
        ),
        boxShadow: [
          if (isFieldActive || hasValue)
            BoxShadow(
              color: const Color(0xFF8B5CF6).withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          enabled: !_isLoading,
          style: TextStyle(
            fontSize: 22 * widthMultiplier,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111827),
            fontFamily: "Inter",
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            counterText: "",
            isDense: true,
            contentPadding: EdgeInsets.zero,
            fillColor: Color(0xFFF9FAFB),
            filled: true,
          ),
          onChanged: (value) {
            setState(() {});

            if (value.length == 1 && nextFocusNode != null) {
              nextFocusNode.requestFocus();
            }
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          autofocus:
              index == 0 && _isOtpSent && _otpControllers[0].text.isEmpty,
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    final size = MediaQuery.of(context).size;
    final widthMultiplier = size.width / 393;

    final bool isButtonEnabled =
        !_isLoading &&
        (_isOtpSent
            ? _otpControllers.every((controller) => controller.text.isNotEmpty)
            : _phoneController.text.length == 10);

    return ElevatedButton(
      onPressed: isButtonEnabled ? _handleAction : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8B5CF6),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: size.height * 0.018),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        minimumSize: Size(double.infinity, 56 * widthMultiplier),
        elevation: 0,
        disabledBackgroundColor: const Color(0xFF8B5CF6).withOpacity(0.5),
      ),
      child:
          _isLoading
              ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
              : Text(
                _isOtpSent ? "Verify OTP" : "Send OTP",
                style: TextStyle(
                  fontSize: 16 * widthMultiplier,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                ),
              ),
    );
  }

  Future<void> _handleAction() async {
    if (!_isOtpSent) {
      await _sendOtp();
    } else {
      await _verifyOtp();
    }
  }

  Future<void> _verifyOtp() async {
    FocusScope.of(context).unfocus();
    String otpCode =
        _otpControllers.map((controller) => controller.text).join();

    if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter the complete 6-digit OTP"),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      AppLogger.auth(
        'OTP verification initiated for ${_isSignUpMode ? "Sign Up" : "Sign In"}',
      );

      final AuthResponse authResponse = await supabase.auth.verifyOTP(
        phone: "+91${_phoneController.text}",
        token: otpCode,
        type: OtpType.sms,
      );

      if (authResponse.user != null) {
        AppLogger.auth(
          'User authenticated successfully',
          userId: authResponse.user!.id,
        );

        try {
          await supabase.from('profiles').upsert({
            'userId': authResponse.user!.id,
            'phone': _phoneController.text,
            'created_at': DateTime.now().toUtc().toString(),
          });

          AppLogger.database('upsert', 'profiles', id: authResponse.user!.id);

          AppLogger.auth(
            '${_isSignUpMode ? "Sign Up" : "Sign In"} successful',
            userId: authResponse.user!.id,
          );

          if (mounted) {
            // Check if the user has completed their profile
            final profileData =
                await supabase
                    .from('profiles')
                    .select('first_name, last_name')
                    .eq('userId', authResponse.user!.id)
                    .single();

            final hasCompletedProfile =
                profileData['first_name'] != null &&
                profileData['first_name'].toString().isNotEmpty;

            AppLogger.navigation(
              'LoginScreen',
              hasCompletedProfile ? 'HomeScreen' : 'CompleteProfile1',
            );

            Navigator.pushReplacement(
              context,
              AppAnimations.fadeSlideTransition(
                hasCompletedProfile
                    ? const HomeScreen()
                    : const CompleteProfile1(),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutBack,
              ),
            );
          }
        } catch (e, stackTrace) {
          AppLogger.error("Error creating profile", e, stackTrace);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Error creating profile"),
                backgroundColor: Color(0xFFEF4444),
              ),
            );
          }
        }
      }
    } catch (e, stackTrace) {
      AppLogger.error("Error verifying OTP", e, stackTrace);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid OTP. Please try again."),
            backgroundColor: Color(0xFFEF4444),
          ),
        );

        for (var controller in _otpControllers) {
          controller.clear();
        }
        _otpFocusNodes[0].requestFocus();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendOtp() async {
    if (_phoneController.text.length != 10) return;

    setState(() {
      _isLoading = true;
    });

    try {
      AppLogger.auth(
        'OTP send request initiated for ${_isSignUpMode ? "Sign Up" : "Sign In"}',
        userId: _phoneController.text,
      );

      await supabase.auth.signInWithOtp(phone: "+91${_phoneController.text}");

      setState(() {
        _isOtpSent = true;
      });

      AppLogger.auth('OTP sent successfully');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("OTP Sent to ${_phoneController.text}"),
            duration: const Duration(seconds: 2),
            backgroundColor: const Color(0xFF10B981),
          ),
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error("Error sending OTP", e, stackTrace);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to send OTP. Please try again."),
            backgroundColor: Color(0xFFEF4444),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
