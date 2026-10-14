import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'main.dart';



class Register extends StatefulWidget{
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register>{



  final TextEditingController userController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;


  @override
  void dispose() {
    userController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }


  String? validateUsername(String? value){
    if(value == null || value.trim().isEmpty){
      return "Username is required";
    }
    if(value.trim().length<3 || value.trim().length>6){
      return "Use 3-6 characters";
    }
    if(!RegExp(r'^[a-zA-Z ]+$').hasMatch(value.trim())){
      return "Only letters allowed";
    }
    return null;
  }

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




  String? validatePassword(String? value){
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

    // Count special characters
    final specialCharacters =
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').allMatches(value).length;

    if (specialCharacters != 1) {
      return "Password must contain exactly 1 special character";
    }


    return null;
  }


  String? validateNumber(String? value){
    if(value==null || value.isEmpty){
      return "Phone numbber is required";
    }
    if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(value.trim())) {
      return "Enter a valid 10-digit phone number";
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

                    child: Form(
                      key: _formKey,

                      child:
                      Column(mainAxisSize: MainAxisSize.min,
                        children: [

                          Center(
                            child: Text(
                              "Create Your Account",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),


                          SizedBox(height: 28),

                          TextFormField(
                            controller: userController,
                            validator: validateUsername,
                            decoration: InputDecoration(
                              labelText: "UserName",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                          ),

                          SizedBox(height: 20),

                          TextFormField(
                            controller: emailController,
                            validator: validateEmail,
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          TextFormField(
                            controller: passwordController,
                            validator: validatePassword,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: "Password",
                              suffixIcon:IconButton(
                                onPressed: (){
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon:Icon(
                                    _obscureText
                                        ?Icons.visibility_off
                                        :Icons.visibility
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          TextFormField(
                            controller: phoneController,
                            validator: validateNumber,
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          ElevatedButton(
                            onPressed: () async {
                              if(_formKey.currentState!.validate()) {

                                try {


                                  UserCredential userCredential =
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );


                                  String uid = userCredential.user!.uid;

                                  await FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(uid)
                                      .set({
                                    "name": userController.text.trim(),
                                    "email": emailController.text.trim(),
                                    "phone":phoneController.text.trim(),
                                    "usernmae":userController.text.trim(),
                                  });

                                  User? user = userCredential.user;


                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Registered Successfully"
                                      ),
                                    ),
                                  );


                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),),
                                  );
                                }
                                on FirebaseAuthException catch (e, stackTrace) {
                                  print("Error code: ${e.code}");
                                  print("Error message: ${e.message}");
                                  print(stackTrace);
                                  ScaffoldMessenger.of(context).showSnackBar(

                                      SnackBar(content: Text(e.message?? "Something went wrong"))
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(300, 55),
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              elevation: 5,
                              shadowColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text("Register"),
                          )

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

