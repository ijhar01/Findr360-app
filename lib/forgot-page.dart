import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class forgot extends StatefulWidget{
  const forgot({super.key});

  @override
  State<forgot> createState() => _forgotState();
}

class _forgotState extends State<forgot>{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController newpassController = TextEditingController();

  bool _hidepassword = true;

  final _formKey = GlobalKey<FormState>();



  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    String email = value.trim();

    if (email.contains(' ')) {
      return "Email cannot contain spaces";
    }

    // Must be a Gmail address
    if (!email.toLowerCase().endsWith("@gmail.com")) {
      return "Enter a valid Gmail address";
    }

    // Gmail format
    final emailRegex = RegExp(
      r'^[a-zA-Z][a-zA-Z0-9._%+-]*@gmail\.com$',
    );

    if (!emailRegex.hasMatch(email)) {
      return "Enter a valid email address";
    }

    // Cannot contain consecutive dots
    if (email.contains('..')) {
      return "Email cannot contain consecutive dots";
    }

    return null;
  }



  String? validateNewpass(String? value){
    if(value == null || value.isEmpty){
      return "Password is required";
    }
    if(value.length<6){
      return "Password must be at least 6 characters";
    }
    if(!RegExp(r'[a-z]').hasMatch(value)){
      return "Password contain atleast 1 lowercase letter";
    }
    if(!RegExp(r'[0-9]').hasMatch(value)){
      return "Password contain a number";
    }
    if(!RegExp(r'[A-Z]').hasMatch(value)){
      return "Password contain atleast 1 Uppercase letter";
    }

    if(!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)){
      return "Password must contain a special character";
    }
    return null;

  }


  @override
  Widget build(BuildContext context){
    return Scaffold(

      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFFFFBF5),
      body:SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),

            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),

              child: Column(
                children: [

                  // ------------------------------------------------
                  // LOGO
                  // ------------------------------------------------

                  Container(
                    width: 150,
                    height: 150,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/onlylogo.png',
                      fit: BoxFit.contain,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return Icon(
                          Icons.home_work_rounded,
                          size: 80,
                          color: Colors.teal,
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 20,),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 25,
                          offset:  Offset(0, 10),
                        ),
                      ],
                    ),


                    child:Form(
                      key:_formKey,
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text(
                            "Change Password",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),

                          SizedBox(height: 20),

                          TextFormField(
                            controller: emailController,
                            validator: validateEmail,
                            decoration: InputDecoration(
                              labelText: "Enter Email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),

                          SizedBox(height: 20),


                          TextFormField(
                            controller: newpassController,
                            obscureText: _hidepassword,
                            validator: validateNewpass,
                            decoration: InputDecoration(
                              labelText: "New Password",
                              suffixIcon: IconButton(onPressed: (){
                                setState(() {
                                  _hidepassword = !_hidepassword;
                                });
                              }, icon: Icon(
                                  _hidepassword
                                      ?Icons.visibility_off
                                      :Icons.visibility
                              ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          ElevatedButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }

                              try {
                                UserCredential userCredential =
                                await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: emailController.text.trim(),
                                  password: newpassController.text.trim(),
                                );

                                await userCredential.user!.updatePassword(
                                  newpassController.text.trim(),
                                );

                                if (!mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Password changed successfully"),
                                  ),
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (!mounted) return;

                                String message = "Something went wrong";

                                if (e.code == 'user-not-found') {
                                  message = "Email is not registered";
                                } else if (e.code == 'wrong-password') {
                                  message = "Incorrect password";
                                } else if (e.code == 'invalid-credential') {
                                  message = "Email is not registered";
                                } else if (e.code == 'invalid-email') {
                                  message = "Enter a valid email";
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize:  Size(300, 55),
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shadowColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text("Change Password"),

                          ),
                        ],
                      ),

                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
