import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_otp/phone.dart';
import 'package:pinput/pinput.dart';

class Myotp extends StatefulWidget {
  const Myotp({Key? key}) : super(key: key);

  @override
  State<Myotp> createState() => _MyotpState();
}

class _MyotpState extends State<Myotp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code ;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context, "phone");
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25,right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/otp.png", height: 150, width: 150,),
                  SizedBox(height: 25,),
                  Text("Phone Verification" ,style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22
                  ),),
                  SizedBox(height: 10,),
                  Text("We need to register your phone before getting started!" ,style: TextStyle(
                    fontWeight: FontWeight.w300, fontSize: 16,
                  ),
                    textAlign: TextAlign.center,),
                  SizedBox(height: 30,),
            Pinput(
              onChanged: (value){
            code = value;
              },
              length: 6,
              // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              // onCompleted: (pin) => print(pin),
            ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child:  ElevatedButton(onPressed: ()async{
                      try {
                        PhoneAuthCredential credential = PhoneAuthProvider
                            .credential(
                            verificationId: Myphone.verify, smsCode: code);
                        await auth.signInWithCredential(credential);
                        Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
                        // Navigator.pushNamed(context, "otp");
                      }
                      catch(e){
                              print("wrong otp");
                       //  Fluttertoast.showToast(
                       //      msg: "Wrong Otp Entered",
                       //      toastLength: Toast.LENGTH_SHORT,
                       //      gravity: ToastGravity.BOTTOM,
                       //      timeInSecForIosWeb: 1,
                       //      backgroundColor: Colors.blue,
                       //      textColor: Colors.white,
                       //      fontSize: 16.0
                       // );
                      }
                    },
                      child: Text('Verify Phone Number') ,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(onPressed:  (){
                        Navigator.pushNamedAndRemoveUntil(context, "phone",(route)=>false);
                      }, child:  Text("Edit Phone Number?" , style: TextStyle(color: Colors.black),))

                    ],
                  )
                ]
            )
        ),
      ),
    );
  }
}
