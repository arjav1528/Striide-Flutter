import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'complete_profile_2.dart';

class CompleteProfile1 extends StatefulWidget {
  const CompleteProfile1({super.key});

  @override
  State<CompleteProfile1> createState() => _CompleteProfile1State();
}

class _CompleteProfile1State extends State<CompleteProfile1> {
  bool termsAccepted = false;
  final TextEditingController occupationController = TextEditingController();
  String selectedGender = '';
  DateTime? selectedDate;
  final TextEditingController birthdayController = TextEditingController();
  
  // Gender options
  final List<String> genders = ['Male', 'Female', 'Non-binary', 'Prefer not to say'];
  
  @override
  void dispose() {
    occupationController.dispose();
    birthdayController.dispose();
    super.dispose();
  }
  
  Future<void> _selectDate(BuildContext context, double widthMultiplier) async {
    final DateTime now = DateTime.now();
    final DateTime eighteenYearsAgo = DateTime(now.year - 18, now.month, now.day);
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? eighteenYearsAgo,
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
            dialogBackgroundColor: const Color(0xFF282632),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFD4AF37),
              ),
            ),
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

  @override
  Widget build(BuildContext context) {
    double heightMultiplier = MediaQuery.of(context).size.height / 852;
    double widthMultiplier = MediaQuery.of(context).size.width / 393;
    
    return Scaffold(
      backgroundColor: const Color(0xFF282632), // Dark background color
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0 * widthMultiplier,
            vertical: 16.0 * heightMultiplier
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40 * heightMultiplier),
              Text(
                "You're almost there!",
                style: TextStyle(
                  fontSize: 24 * widthMultiplier,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFD4AF37),
                  letterSpacing: 0.5
                ),
              ),
              SizedBox(height: 8 * heightMultiplier),
              RichText(
                text: TextSpan(
                  text: 'The information below stays ',
                  style: TextStyle(
                    fontSize: 16 * widthMultiplier,
                    color: Colors.white,
                    fontFamily: "Nunito"
                  ),
                  children: [
                    TextSpan(
                      text: 'PRIVATE',
                      style: TextStyle(
                        color: const Color(0xFF4CD964), // Green color
                        fontWeight: FontWeight.bold,
                        fontSize: 16 * widthMultiplier,
                        fontFamily: "Nunito"
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "and won't be visible on your profile.",
                style: TextStyle(
                  fontSize: 16 * widthMultiplier,
                  color: Colors.white,
                  fontFamily: "Nunito"
                ),
              ),
              SizedBox(height: 16 * heightMultiplier),
              Text(
                "Share a little about you!",
                style: TextStyle(
                  fontSize: 16 * widthMultiplier,
                  color: Colors.white,
                  fontFamily: "Nunito",
                ),
              ),
              SizedBox(height: 24 * heightMultiplier),

              // Occupation Field
              Container(
                height: 69*heightMultiplier,
                width: 329*widthMultiplier,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8 * widthMultiplier),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 32*heightMultiplier,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16*widthMultiplier, vertical: 6*heightMultiplier),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8*widthMultiplier),
                          topRight: Radius.circular(8*widthMultiplier)
                        ),
                        color: Color(0xFF00A886)
                      ),
                      child: Text(
                        "Occupation",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14 * widthMultiplier,
                          fontFamily: "Nunito"
                        ),
                      ),
                    ),
                    Container(
                      height: 37*heightMultiplier,
                      padding: EdgeInsets.symmetric(horizontal: 16*widthMultiplier),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8*widthMultiplier),
                          bottomRight: Radius.circular(8*widthMultiplier)
                        ),
                        color: Colors.white
                      ),
                      child: TextField(
                        controller: occupationController,
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          hintText: "Besides changing the world",
                          hintStyle: TextStyle(color: Colors.grey,fontFamily: "Nunito", fontSize: 14*widthMultiplier),
                          // Add these properties to center the text vertically
                          contentPadding: EdgeInsets.symmetric(vertical: 8*heightMultiplier),
                          isDense: true,
                        ),
                        style: TextStyle(color: Colors.black,fontFamily: "Nunito", fontSize: 14*widthMultiplier),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 24 * heightMultiplier), // Increased from 16 to 24

              // Gender Field
              Container(
                height: 69*heightMultiplier,
                width: 329*widthMultiplier,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8 * widthMultiplier),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 32*heightMultiplier,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16*widthMultiplier, vertical: 6*heightMultiplier),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8*widthMultiplier),
                          topRight: Radius.circular(8*widthMultiplier)
                        ),
                        color: Color(0xFF00A886)
                      ),
                      child: Text(
                        "Gender",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14 * widthMultiplier,
                          fontFamily: "Nunito"
                        ),
                      ),
                    ),
                    Container(
                      height: 37*heightMultiplier,
                      padding: EdgeInsets.symmetric(horizontal: 16*widthMultiplier),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8*widthMultiplier),
                          bottomRight: Radius.circular(8*widthMultiplier)
                        ),
                        color: Colors.white
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8*heightMultiplier),
                          child: DropdownButton<String>(
                            value: selectedGender.isNotEmpty ? selectedGender : null,
                            hint: Text("Select your gender", style: TextStyle(color: Colors.grey,fontFamily: "Nunito", fontSize: 14*widthMultiplier)),

                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                            dropdownColor: Colors.white,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedGender = newValue!;
                              });
                            },
                            items: genders.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: TextStyle(color: Colors.black,fontFamily: "Nunito", fontSize: 14*widthMultiplier),),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 24 * heightMultiplier), // Increased from 16 to 24

              // Birthday Field
              Container(
                height: 69*heightMultiplier,
                width: 329*widthMultiplier,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8 * widthMultiplier),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 32*heightMultiplier,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16*widthMultiplier, vertical: 6*heightMultiplier),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8*widthMultiplier),
                          topRight: Radius.circular(8*widthMultiplier)
                        ),
                        color: Color(0xFF00A886)
                      ),
                      child: Text(
                        "Birthday",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14 * widthMultiplier,
                          fontFamily: "Nunito"
                        ),
                      ),
                    ),
                    Container(
                      height: 37*heightMultiplier,
                      padding: EdgeInsets.symmetric(horizontal: 16*widthMultiplier),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8*widthMultiplier),
                          bottomRight: Radius.circular(8*widthMultiplier)
                        ),
                        color: Colors.white
                      ),
                      child: TextField(
                        controller: birthdayController,
                        readOnly: true,
                        onTap: () => _selectDate(context, widthMultiplier),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Select your birthday",
                          hintStyle: TextStyle(color: Colors.grey,fontFamily: "Nunito", fontSize: 14*widthMultiplier),
                          suffixIcon: Icon(Icons.calendar_today, color: Colors.black, size: 20*widthMultiplier),
                          // Add these properties to center the text vertically
                          contentPadding: EdgeInsets.symmetric(vertical: 8*heightMultiplier),
                          isDense: true,
                        ),
                        style: TextStyle(color: Colors.black,fontFamily: "Nunito", fontSize: 14*widthMultiplier),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40 * heightMultiplier), // Increased from 24 to 40

              // Terms and Conditions Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24 * widthMultiplier,
                    height: 24 * heightMultiplier,
                    child: Checkbox(
                      value: termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          termsAccepted = value ?? false;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                        (states) => Colors.white,
                      ),
                      checkColor: Colors.black,
                    ),
                  ),
                  SizedBox(width: 8 * widthMultiplier),
                  Expanded(
                    child: Text(
                      "I hereby confirm that I have read and agree to the Terms of Service and Privacy Policy.",
                      style: TextStyle(
                        fontSize: 14 * widthMultiplier,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              // Next Button (triple chevron)
              SizedBox(height: 200*heightMultiplier,),
              Padding(
                padding: EdgeInsets.only(top: 24 * heightMultiplier), // Added padding for spacing
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: termsAccepted ? () {
                      // Check if required fields are filled
                      if (occupationController.text.isNotEmpty && 
                          selectedGender.isNotEmpty && 
                          selectedDate != null) {
                        print("Profile information: ");
                        print("Occupation: ${occupationController.text}");
                        print("Gender: $selectedGender");
                        print("Birthday: ${birthdayController.text}");
                        
                        // Navigate to CompleteProfile2 with right to left transition
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => 
                              const CompleteProfile2(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;
                              
                              var tween = Tween(begin: begin, end: end).chain(
                                CurveTween(curve: curve)
                              );
                              
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 300),
                          ),
                        );
                      }
                    } : null,
                    child: Container(
                      width: 120 * widthMultiplier,
                      height: 16 * heightMultiplier,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.chevron_right,
                            size: 40 * widthMultiplier,
                            color: termsAccepted ? Colors.white : Colors.grey,
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 40 * widthMultiplier,
                            color: termsAccepted ? Colors.white : Colors.grey,
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 40 * widthMultiplier,
                            color: termsAccepted ? Colors.white : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16 * heightMultiplier),
            ],
          ),
        ),
      ),
    );
  }
}
