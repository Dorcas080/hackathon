import 'package:e_commerce_app/screens/recovery_screen.dart';
import 'package:flutter/material.dart';

class OTPVeryfyScreen extends StatefulWidget {
  const OTPVeryfyScreen({super.key});

  @override
  State<OTPVeryfyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVeryfyScreen> {
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  TextEditingController textEditingController = TextEditingController(
    text: "",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Enter OTP",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 150),
              Text(
                "Please enter the OTP code that we have sent to your number,please check your number and enter here OTP to verify ",
                style: TextStyle(fontSize: 15),
              ),

              SizedBox(height: 50),
              // TextFieldPin(
              //   textController: textEditingController,
              //   autoFocus: false,
              //   codeLength: 4,
              //   alignment: MainAxisAlignment.center,
              //   defaultBoxSize: 60.0,
              //   margin: 10,
              //   selectedBoxSize: 55.0,
              //   textStyle: TextStyle(fontSize: 16),
              //   defaultDecoration: _pinPutDecoration.copyWith(
              //     border: Border.all(color: Colors.grey),
              //   ),
              //   selectedDecoration: _pinPutDecoration,
              //   onChange: (code) {
              //     setState(() {});
              //   },
              // ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecoveryScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(55),
                  backgroundColor: Color(0xFFDB3022),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Verify", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
