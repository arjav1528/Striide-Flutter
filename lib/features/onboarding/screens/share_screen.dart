import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:striide_flutter/features/onboarding/providers/onboarding_provider.dart';
import 'package:striide_flutter/features/onboarding/screens/demo_screen.dart';
import 'package:striide_flutter/features/home/screens/home.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isLinkCopied = false;
  final String _inviteLink = "https://striide.app/invite/12345";
  final String _inviteMessage =
      "Join me on Striide! It's a great way to connect. Download the app: https://striide.app/invite/12345";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _copyInviteLink() {
    Clipboard.setData(ClipboardData(text: _inviteLink));
    setState(() {
      _isLinkCopied = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invite link copied to clipboard!'),
        backgroundColor: Color(0xFF00A886),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLinkCopied = false;
        });
      }
    });
  }

  void _shareViaWhatsApp() async {
    final String encodedMessage = Uri.encodeComponent(_inviteMessage);
    final Uri whatsappUrl = Uri.parse("whatsapp://send?text=$encodedMessage");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      _showErrorDialog("WhatsApp is not installed on your device.");
    }
  }

  void _shareViaTwitter() async {
    final String encodedMessage = Uri.encodeComponent(_inviteMessage);
    final Uri twitterUrl = Uri.parse(
      "https://twitter.com/intent/tweet?text=$encodedMessage",
    );

    if (await canLaunchUrl(twitterUrl)) {
      await launchUrl(twitterUrl, mode: LaunchMode.externalApplication);
    } else {
      _showErrorDialog("Could not open Twitter.");
    }
  }

  void _shareViaEmail() async {
    final Uri emailUri = Uri.parse(
      "mailto:?subject=Join me on Striide&body=$_inviteMessage",
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      _showErrorDialog("Could not open email client.");
    }
  }

  void _shareViaFacebook() async {
    try {
      await Share.share(_inviteMessage, subject: "Join me on Striide!");
    } catch (e) {
      _showErrorDialog("Could not share via Facebook.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Sharing Error"),
            content: Text(message),
            backgroundColor: const Color(0xFF33333b),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            contentTextStyle: const TextStyle(color: Colors.white),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "OK",
                  style: TextStyle(color: Color(0xFFD4AF37)),
                ),
              ),
            ],
          ),
    );
  }

  void _navigateToHomeScreen() {
    _animationController.forward().then((_) => _animationController.reverse());
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DemoScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double heightMultiplier = MediaQuery.of(context).size.height / 852;
    double widthMultiplier = MediaQuery.of(context).size.width / 393;

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
                SizedBox(height: 30 * heightMultiplier),
                // Header
                _buildHeader(widthMultiplier),
                SizedBox(height: 16 * heightMultiplier),
                _buildInfoContainer(heightMultiplier, widthMultiplier),
                SizedBox(height: 80 * heightMultiplier),
                // Share section
                _buildShareSection(heightMultiplier, widthMultiplier),
                SizedBox(height: 120 * heightMultiplier),
                // Start striding button
                _buildStartStrideButton(heightMultiplier, widthMultiplier),
                SizedBox(height: 16 * heightMultiplier),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double widthMultiplier) {
    return ShaderMask(
      shaderCallback:
          (bounds) => const LinearGradient(
            colors: [Color(0xFFD4AF37), Color(0xFFE9D172)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
      child: Text(
        "Let's Connect",
        style: TextStyle(
          fontSize: 28 * widthMultiplier,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: "Montserrat",
        ),
      ),
    );
  }

  Widget _buildInfoContainer(double heightMultiplier, double widthMultiplier) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16 * widthMultiplier,
        vertical: 12 * heightMultiplier,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF33333b),
        borderRadius: BorderRadius.circular(12 * widthMultiplier),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        "For Striide to work the way it's meant to, your friends need to be here too. Let's get them all on board!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18 * widthMultiplier,
          color: Colors.white,
          fontFamily: "Nunito",
          height: 1.3,
        ),
      ),
    );
  }

  Widget _buildShareSection(double heightMultiplier, double widthMultiplier) {
    return Column(
      children: [
        Text(
          "It's powerful when shared",
          style: TextStyle(
            fontSize: 22 * widthMultiplier,
            color: Colors.white,
            fontFamily: "Nunito",
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 24 * heightMultiplier),
        // Sharing options
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 * widthMultiplier),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildShareButton(
                icon: "assets/icons/wa.svg",
                isSvg: true,
                size: 25,
                onTap: _shareViaWhatsApp,
                heightMultiplier: heightMultiplier,
                widthMultiplier: widthMultiplier,
              ),
              _buildShareButton(
                icon: "assets/icons/x.png",
                isSvg: false,
                size: 30,
                onTap: _shareViaTwitter,
                heightMultiplier: heightMultiplier,
                widthMultiplier: widthMultiplier,
              ),
              _buildShareButton(
                icon: "assets/icons/mail.svg",
                isSvg: true,
                size: 35,
                onTap: _shareViaEmail,
                heightMultiplier: heightMultiplier,
                widthMultiplier: widthMultiplier,
              ),
              _buildShareButton(
                icon: "assets/icons/facebook.svg",
                isSvg: true,
                size: 40,
                onTap: _shareViaFacebook,
                heightMultiplier: heightMultiplier,
                widthMultiplier: widthMultiplier,
              ),
            ],
          ),
        ),
        SizedBox(height: 30 * heightMultiplier),
        // Copy invite link button
        _buildCopyLinkButton(heightMultiplier, widthMultiplier),
      ],
    );
  }

  Widget _buildCopyLinkButton(double heightMultiplier, double widthMultiplier) {
    return GestureDetector(
      onTap: _copyInviteLink,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 54 * heightMultiplier,
        width: 190 * widthMultiplier,
        decoration: BoxDecoration(
          color:
              _isLinkCopied ? const Color(0xFF007C64) : const Color(0xFF00A886),
          borderRadius: BorderRadius.circular(10 * widthMultiplier),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00A886).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isLinkCopied ? Icons.check : Icons.link,
                color: Colors.white,
                size: 20 * widthMultiplier,
              ),
              SizedBox(width: 8 * widthMultiplier),
              Text(
                _isLinkCopied ? "Copied!" : "Copy Invite Link",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16 * widthMultiplier,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStartStrideButton(
    double heightMultiplier,
    double widthMultiplier,
  ) {
    return GestureDetector(
      onTap: _navigateToHomeScreen,
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: 56 * heightMultiplier,
          width: 323 * widthMultiplier,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6B18D8), Color(0xFF8442E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12 * widthMultiplier),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6B18D8).withOpacity(0.3),
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
                  "Start Striiding",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20 * widthMultiplier,
                    fontFamily: "Nunito",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8 * widthMultiplier),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 22 * widthMultiplier,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShareButton({
    required String icon,
    required bool isSvg,
    required double size,
    required VoidCallback onTap,
    required double heightMultiplier,
    required double widthMultiplier,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 65 * heightMultiplier,
        width: 65 * widthMultiplier,
        decoration: BoxDecoration(
          color: const Color(0xFF33333b),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child:
              isSvg
                  ? SvgPicture.asset(
                    icon,
                    height: size * heightMultiplier,
                    width: size * widthMultiplier,
                    fit: BoxFit.contain,
                  )
                  : Image.asset(
                    icon,
                    height: size * heightMultiplier,
                    width: size * widthMultiplier,
                    fit: BoxFit.contain,
                  ),
        ),
      ),
    );
  }
}
