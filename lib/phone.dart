import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Myphone extends StatefulWidget {
  const Myphone({Key? key}) : super(key: key);
  static String verify ="";
  @override
  State<Myphone> createState() => _MyphoneState();
}

class _MyphoneState extends State<Myphone> {
  TextEditingController countrycode = TextEditingController();
  var phone = "";
  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+91";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    SizedBox(width: 40,child: TextField(controller: countrycode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),),
                    Text('|',style: TextStyle(fontSize: 35,color: Colors.grey.shade400),),
                    SizedBox(width: 10),
                    Expanded(child: TextField(
                      onChanged: (value){
                        phone = value;
                      },
                      decoration: InputDecoration(hintText: 'Enter Number',border: InputBorder.none,),
                      keyboardType: TextInputType.number,
                      // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    )
                    )
                   ],)),
              SizedBox(height: 10),
              SizedBox(
                height: 45,
                width: double.infinity,
                child:  ElevatedButton(onPressed: () async{
                  await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: '${countrycode.text+phone}',
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    Myphone.verify = verificationId;
                    Navigator.pushNamed(context, "otp");
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );

                }, child: Text('Send the code') , style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),),
              )
            ]
          )
          ),
        ),
      );
  }
}
