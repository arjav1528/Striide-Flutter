import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    double heightMultiplier = MediaQuery.of(context).size.height / 852;
    double widthMultiplier = MediaQuery.of(context).size.width / 393;
    return Scaffold(
      backgroundColor: const Color(0xFF282632),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0 * widthMultiplier, vertical: 16.0 * heightMultiplier),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40 * heightMultiplier),
              Center(
                child: Text(
                  "Let's Connect",
                  style: TextStyle(
                      fontSize: 24 * widthMultiplier,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD4AF37),
                      fontFamily: "Montserrat"),
                  ),
                ),
              SizedBox(height: 10*heightMultiplier,),
              Center(
                child: Container(
                  width: 310*widthMultiplier,
                  child: Text("For Striide to work the way it’s meant to, your friends need to be here too. Let’s get them all on board!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20 * widthMultiplier,
                      color: Colors.white,
                      fontFamily: "Nunito",
                    ),
                  ),
                ),
              ),
              SizedBox(height: 120*heightMultiplier,),
              Center(
                child: Text("It’s powerful when shared",
                  style: TextStyle(
                    fontSize: 20 * widthMultiplier,
                    color: Colors.white,
                    fontFamily: "Nunito",
                  ),
                ),
              ),
              SizedBox(height: 20*heightMultiplier,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10*widthMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        // Handle WhatsApp share action

                      },
                      child: Container(
                        height: 60 * heightMultiplier,
                        width: 60 * widthMultiplier,
                        decoration: BoxDecoration(
                          color: Color(0xFF33333b),
                          shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Container(
                            height: 25 * heightMultiplier,
                            width: 25 * widthMultiplier,
                            child: SvgPicture.asset("assets/icons/wa.svg",

                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: 60 * heightMultiplier,
                        width: 60 * widthMultiplier,
                        decoration: BoxDecoration(
                            color: Color(0xFF33333b),
                            shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Container(
                            child: Image.asset("assets/icons/x.png",
                              height: 30 * heightMultiplier,
                              width: 30 * widthMultiplier,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: 60 * heightMultiplier,
                        width: 60 * widthMultiplier,
                        decoration: BoxDecoration(
                            color: Color(0xFF33333b),
                            shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Container(
                            height: 35 * heightMultiplier,
                            width: 35 * widthMultiplier,
                            child: SvgPicture.asset("assets/icons/mail.svg",

                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: 60 * heightMultiplier,
                        width: 60 * widthMultiplier,
                        decoration: BoxDecoration(
                            color: Color(0xFF33333b),
                            shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Container(
                            height: 40 * heightMultiplier,
                            width: 40 * widthMultiplier,
                            child: SvgPicture.asset("assets/icons/facebook.svg",

                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(height: 20 * heightMultiplier),
              GestureDetector(
                onTap: (){},
                child: Container(
                  height: 50 * heightMultiplier,
                  width: 170 * widthMultiplier,
                  decoration: BoxDecoration(
                    color: Color(0xFF00A886),
                    borderRadius: BorderRadius.circular(8 * widthMultiplier),
                  ),
                  child: Center(
                    child: Text("Copy Invite Link",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16 * widthMultiplier,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 220 * heightMultiplier),
              Container(
                height: 50*heightMultiplier,
                width: 323*widthMultiplier,
                decoration: BoxDecoration(
                  color: Color(0xFF6B18D8),
                  borderRadius: BorderRadius.circular(8 * widthMultiplier),
                ),
                child: Center(
                  child: Text("Start Striiding",
                  textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20 * widthMultiplier,
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
