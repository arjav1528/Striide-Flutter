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
      backgroundColor: const Color(0xFF282632), // Dark background color
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0 * widthMultiplier,
            vertical: 16.0 * heightMultiplier,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40 * heightMultiplier),
              // Animated header section
              StaggeredList(
                itemDelay: const Duration(milliseconds: 150),
                itemDuration: const Duration(milliseconds: 600),
                children: [
                  Text(
                    "One last step!",
                    style: TextStyle(
                      fontSize: 24 * widthMultiplier,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD4AF37),
                      fontFamily: "Montserrat",
                    ),
                  ),
                  SizedBox(height: 16 * heightMultiplier),
                  RichText(
                    text: TextSpan(
                      text: 'The information below will be ',
                      style: TextStyle(
                        fontSize: 16 * widthMultiplier,
                        color: Colors.white,
                        fontFamily: "Nunito",
                      ),
                      children: [
                        TextSpan(
                          text: 'PUBLIC',
                          style: TextStyle(
                            color: const Color(0xFFD4AF37), // Gold color
                            fontWeight: FontWeight.bold,
                            fontSize: 16 * widthMultiplier,
                            fontFamily: "Nunito",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "and will help you connect with people",
                    style: TextStyle(
                      fontSize: 16 * widthMultiplier,
                      color: Colors.white,
                      fontFamily: "Nunito",
                    ),
                  ),
                  SizedBox(height: 16 * heightMultiplier),
                  Text(
                    "Let's build your profile !",
                    style: TextStyle(
                      fontSize: 16 * widthMultiplier,
                      color: Colors.white,
                      fontFamily: "Nunito",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24 * heightMultiplier),

              // Bio Expandable Field with animation
              FadeInWidget(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 800),
                slideOffset: const Offset(0.0, 0.3),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      bioExpanded = !bioExpanded;
                    });
                  },
                  child: Container(
                    width: 329 * widthMultiplier,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8 * widthMultiplier),
                      border: Border.all(
                        color: const Color(0xFF00A886),
                        width: 1,
                      ),
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
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.add,
                            color: const Color(0xFF00A886),
                            size: 24 * widthMultiplier,
                          ),
                        ],
                      ),
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
                        borderRadius: BorderRadius.circular(
                          8 * widthMultiplier,
                        ),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: bioController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Write something about yourself...",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Nunito",
                            fontSize: 14 * widthMultiplier,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16 * widthMultiplier),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Nunito",
                          fontSize: 14 * widthMultiplier,
                        ),
                      ),
                    ),
                  ),
                ),

              SizedBox(height: 24 * heightMultiplier),

              // First Name Field with animation
              FadeInWidget(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 1000),
                slideOffset: const Offset(0.0, 0.3),
                child: Container(
                  height: 69 * heightMultiplier,
                  width: 329 * widthMultiplier,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8 * widthMultiplier),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 32 * heightMultiplier,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16 * widthMultiplier,
                          vertical: 6 * heightMultiplier,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8 * widthMultiplier),
                            topRight: Radius.circular(8 * widthMultiplier),
                          ),
                          color: Color(0xFF00A886),
                        ),
                        child: Text(
                          "First Name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14 * widthMultiplier,
                            fontFamily: "Nunito",
                          ),
                        ),
                      ),
                      Container(
                        height: 37 * heightMultiplier,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16 * widthMultiplier,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8 * widthMultiplier),
                            bottomRight: Radius.circular(8 * widthMultiplier),
                          ),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "What should we call you?",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Nunito",
                              fontSize: 14 * widthMultiplier,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8 * heightMultiplier,
                            ),
                            isDense: true,
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Nunito",
                            fontSize: 14 * widthMultiplier,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16 * heightMultiplier),

              // Last Name Field
              Container(
                height: 69 * heightMultiplier,
                width: 329 * widthMultiplier,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8 * widthMultiplier),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 32 * heightMultiplier,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16 * widthMultiplier,
                        vertical: 6 * heightMultiplier,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8 * widthMultiplier),
                          topRight: Radius.circular(8 * widthMultiplier),
                        ),
                        color: Color(0xFF00A886),
                      ),
                      child: Text(
                        "Last Name",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14 * widthMultiplier,
                          fontFamily: "Nunito",
                        ),
                      ),
                    ),
                    Container(
                      height: 37 * heightMultiplier,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16 * widthMultiplier,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8 * widthMultiplier),
                          bottomRight: Radius.circular(8 * widthMultiplier),
                        ),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "What should we call you?",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Nunito",
                            fontSize: 14 * widthMultiplier,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8 * heightMultiplier,
                          ),
                          isDense: true,
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Nunito",
                          fontSize: 14 * widthMultiplier,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16 * heightMultiplier),

              // Pronouns Field
              Container(
                height: 69 * heightMultiplier,
                width: 329 * widthMultiplier,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8 * widthMultiplier),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 32 * heightMultiplier,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16 * widthMultiplier,
                        vertical: 6 * heightMultiplier,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8 * widthMultiplier),
                          topRight: Radius.circular(8 * widthMultiplier),
                        ),
                        color: Color(0xFF00A886),
                      ),
                      child: Text(
                        "Pronoun",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14 * widthMultiplier,
                          fontFamily: "Nunito",
                        ),
                      ),
                    ),
                    Container(
                      height: 37 * heightMultiplier,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16 * widthMultiplier,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8 * widthMultiplier),
                          bottomRight: Radius.circular(8 * widthMultiplier),
                        ),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8 * heightMultiplier,
                          ),
                          child: DropdownButton<String>(
                            value:
                                selectedPronouns.isNotEmpty
                                    ? selectedPronouns
                                    : null,
                            hint: Text(
                              "she/her, they/them",
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: "Nunito",
                                fontSize: 14 * widthMultiplier,
                              ),
                            ),

                            isExpanded: true,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
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
                                        fontFamily: "Nunito",
                                        fontSize: 14 * widthMultiplier,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 130 * heightMultiplier), // Spacer
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () async {
                      if (firstNameController.text.isNotEmpty &&
                          lastNameController.text.isNotEmpty &&
                          selectedPronouns.isNotEmpty) {
                        debugPrint("Public profile information: ");
                        debugPrint("First Name: ${firstNameController.text}");
                        debugPrint("Last Name: ${lastNameController.text}");
                        debugPrint("Pronouns: $selectedPronouns");
                        debugPrint("Bio: ${bioController.text}");

                        final response = await Supabase.instance.client
                            .from('profiles')
                            .update({
                              'first_name': firstNameController.text,
                              'last_name': lastNameController.text,
                              'pronouns': selectedPronouns,
                              'bio': bioController.text,
                            })
                            .eq(
                              'userId',
                              Supabase.instance.client.auth.currentUser!.id,
                            )
                            .then((onValue) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShareScreen(),
                                ),
                              );
                            })
                            .catchError((onError) {
                              debugPrint("Error updating profile: $onError");
                            });
                      }
                    },
                    child: Container(
                      width: 120 * widthMultiplier,
                      color: Colors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.chevron_right,
                            size: 40 * widthMultiplier,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 40 * widthMultiplier,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 40 * widthMultiplier,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
