import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  // OTP controllers and focus nodes as lists
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    // Clean up controllers
    _phoneController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }

    // Clean up focus nodes
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightMultiplier = MediaQuery.of(context).size.height / 852;
    double widthMultiplier = MediaQuery.of(context).size.width / 393;
    return Scaffold(
      backgroundColor: Color(0xFF580bbf),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 64 * heightMultiplier),
              Text(
                "Striide",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Inter",
                  fontSize: 36 * widthMultiplier,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 100 * heightMultiplier),
              Container(
                height: 453 * heightMultiplier,
                width: 343 * widthMultiplier,
                decoration: BoxDecoration(
                  color: Color(0xFF3a0a8f),
                  borderRadius: BorderRadius.circular(20 * widthMultiplier),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Signup",
                        style: TextStyle(
                          fontSize: 30 * widthMultiplier,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 34 * widthMultiplier,
                        ),
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Inter",
                            fontSize: 16 * widthMultiplier,
                          ),
                          onChanged: (val) {
                            if (val.length == 10) {
                              // Handle phone number input
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Phone number entered: $val"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              FocusScope.of(context).unfocus();
                            }
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFFFF6FF),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10 * widthMultiplier,
                              ),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Phone Number",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontSize: 16 * widthMultiplier,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Enter your OTP here",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Nunito",
                          fontSize: 20 * widthMultiplier,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10 * widthMultiplier,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            6,
                            (index) => _buildOtpTextField(
                              _otpControllers[index],
                              _otpFocusNodes[index],
                              index < 5 ? _otpFocusNodes[index + 1] : null,
                              widthMultiplier,
                              index,
                            ),
                          ),
                        ),
                      ),

                      // OTP Text Fields
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpTextField(
    TextEditingController controller,
    FocusNode focusNode,
    FocusNode? nextFocusNode,
    double widthMultiplier,
    int index,
  ) {
    return Container(
      width: 40 * widthMultiplier,
      height: 40 * widthMultiplier,
      decoration: BoxDecoration(
        color: Color(0xFFFFF6FF),
        borderRadius: BorderRadius.circular(8 * widthMultiplier),
      ),
      child: Center(
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (RawKeyEvent event) {
            if (event is RawKeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.backspace &&
                controller.text.isEmpty &&
                index > 0) {
              // Move to previous field when backspace is pressed in an empty field
              _otpFocusNodes[index - 1].requestFocus();
              _otpControllers[index - 1].clear();
            }
          },
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(
              fontSize: 20 * widthMultiplier,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value) {
              if (value.length == 1 && nextFocusNode != null) {
                nextFocusNode.requestFocus();
              }

              // Check if all OTP fields are filled
              bool allFilled = _otpControllers.every(
                (controller) => controller.text.isNotEmpty,
              );

              if (allFilled) {
                String otpCode =
                    _otpControllers.map((controller) => controller.text).join();

                // Show OTP entered
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("OTP entered: $otpCode"),
                    duration: Duration(seconds: 2),
                  ),
                );
                FocusScope.of(context).unfocus();
              }
            },
          ),
        ),
      ),
    );
  }
}
