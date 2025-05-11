import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shridungargarh/utils/constent.dart';
import '../../weight/snapkbar.dart';
import '../home-screen/homenav.dart';
import 'login-mobile-number.dart';

class OtpScreen extends StatefulWidget {
  String verfyid;
  OtpScreen({super.key, required this.verfyid});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();
  final Snakbar _snakbar = Snakbar();

  late double w, h;
  String otpCode = "";

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    h = size.height;
    w = size.width;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.05),
              Text('Verification Code', style: Maintital),
              SizedBox(height: h * 0.005),
              Text('We have sent the verification code to', style: smalltital),
              SizedBox(height: h * 0.02),
              Row(
                children: [
                  Text(
                    '+91${MobileNumber.phonenumber}',
                    style: const TextStyle(
                        fontSize: 15,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: w * 0.02),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "Change Phone number?",
                      style: const TextStyle(
                          fontSize: 15,
                          color: kBlackColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.1),

              /// OTP Input
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  counterText: "",
                  hintText: "Enter 6-digit OTP",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: kPrimaryColor),
                  ),
                ),
                onChanged: (value) {
                  otpCode = value;
                },
              ),

              SizedBox(height: h * 0.03),
              SizedBox(height: h * 0.14),

              /// Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Resend Button
                  InkWell(
                    onTap: resendOtp,
                    child: Container(
                      alignment: Alignment.center,
                      height: h * 0.062,
                      width: w * 0.40,
                      decoration: BoxDecoration(
                        color: ksubprime,
                        boxShadow: [
                          BoxShadow(color: kPrimaryColor, blurRadius: 7)
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Resend',
                        style: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),

                  /// Confirm Button
                  InkWell(
                    onTap: verifyOtp,
                    child: Container(
                      alignment: Alignment.center,
                      height: h * 0.062,
                      width: w * 0.40,
                      decoration: BoxDecoration(
                        boxShadow: [
                          const BoxShadow(color: kPrimaryColor, blurRadius: 7)
                        ],
                        color: ksubprime,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2)
                          : const Text(
                        'Confirm',
                        style: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔐 OTP Verification Logic
  void verifyOtp() async {
    if (otpCode.length != 6) {
      _snakbar.snakbarsms('कृपया 6 अंकों का ओटीपी दर्ज करें');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: widget.verfyid, smsCode: otpCode);

      await _auth.signInWithCredential(credential);
      Get.off(() => HomeNav(index: 0));
    } on FirebaseAuthException catch (e) {
      _snakbar.snakbarsms('OTP त्रुटि: ${e.message}');
    } catch (e) {
      _snakbar.snakbarsms('कृपया सही ओटीपी डालें');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// 🔁 Resend OTP Logic
  void resendOtp() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91${MobileNumber.phonenumber}',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        _snakbar.snakbarsms('OTP भेजने में त्रुटि: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        widget.verfyid = verificationId;
        _snakbar.snakbarsms('नया OTP भेज दिया गया है');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        widget.verfyid = verificationId;
      },
    );
  }
}
