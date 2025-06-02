import 'package:flutter/material.dart';


class CompleteProfile1 extends StatefulWidget {
  const CompleteProfile1({super.key});

  @override
  State<CompleteProfile1> createState() => _CompleteProfile1State();
}

class _CompleteProfile1State extends State<CompleteProfile1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Complete your profile here!"),
      ),
    );
  }
}
