import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'hostel.dart';
import 'ragister-page.dart';
import 'forgot-page.dart';
import 'package:flutter/services.dart';
import 'mess-page.dart';
import 'classes-page.dart';
import 'bottom-page.dart';
import 'splash-page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Findr 360",
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Roboto",
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
// ============================================================
// LOGIN PAGE
// ============================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool _obscureText = true;
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ==========================================================
  // LOGIN
  // ==========================================================

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      print("Login Success");

      User? user = userCredential.user;

      if (user != null) {
        await user.reload();
      }

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
            (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      print("Error code: ${e.code}");
      print("Error message: ${e.message}");

      if (!mounted) return;

      String message = "Login failed";

      if (e.code == "user-not-found") {
        message = "No account found with this email.";
      } else if (e.code == "wrong-password") {
        message = "Incorrect password.";
      } else if (e.code == "invalid-credential") {
        message = "Invalid email Not Registered";
      } else if (e.code == "invalid-email") {
        message = "Invalid email address.";
      } else if (e.code == "user-disabled") {
        message = "This account has been disabled.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red.shade700,
          margin: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } catch (e) {
      print(e);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong. Please try again."),
        ),
      );
    }

    if (mounted) {
      setState(() {
        loading = false;
      });
    }
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







  // ==========================================================
  // BUILD LOGIN
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),

      body: SafeArea(
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
                        return const Icon(
                          Icons.home_work_rounded,
                          size: 80,
                          color: Colors.teal,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ------------------------------------------------
                  // APP NAME
                  // ------------------------------------------------

                  const Text(
                    "Findr 360",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1565C0),
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Find a place that feels like home",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ------------------------------------------------
                  // LOGIN CARD
                  // ------------------------------------------------

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

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Center(
                            child: Text(
                              "Welcome Back",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                           SizedBox(height: 5),

                          Center(
                            child: Text(
                              "Login to continue",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),

                          SizedBox(height: 28),

                          // EMAIL
                          TextFormField(
                            validator:validateEmail,
                            controller: emailController,

                            keyboardType:
                            TextInputType.emailAddress,

                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "Enter your email",

                              prefixIcon: const Icon(
                                Icons.email_outlined,
                              ),

                              filled: true,
                              fillColor:
                              const Color(0xFFF8FAFA),

                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),

                              enabledBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide:
                                BorderSide.none,
                              ),

                              focusedBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide:
                                const BorderSide(
                                  color: Colors.teal,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          // PASSWORD
                          TextFormField(

                            validator:validatePassword,
                            controller: passwordController,

                            obscureText: _obscureText,

                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter your password",

                              prefixIcon: const Icon(
                                Icons.lock_outline,
                              ),

                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),

                                onPressed: () {
                                  setState(() {
                                    _obscureText =
                                    !_obscureText;
                                  });
                                },
                              ),

                              filled: true,
                              fillColor:
                              const Color(0xFFF8FAFA),

                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),

                              enabledBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide:
                                BorderSide.none,
                              ),

                              focusedBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(14),
                                borderSide:
                                const BorderSide(
                                  color: Colors.teal,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // FORGOT PASSWORD
                          Align(
                            alignment: Alignment.centerRight,

                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        forgot(),
                                  ),
                                );
                              },

                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          // LOGIN BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 55,

                            child: ElevatedButton(
                              onPressed:
                              loading ? null : login,

                              style:
                              ElevatedButton.styleFrom(
                                backgroundColor:
                                Colors.teal,

                                foregroundColor:
                                Colors.white,

                                disabledBackgroundColor:
                                Colors.teal.shade200,

                                elevation: 3,

                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                    14,
                                  ),
                                ),
                              ),

                              child: loading
                                  ?  SizedBox(
                                height: 25,
                                width: 25,
                                child:
                                CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                                  : Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          // CREATE ACCOUNT
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,

                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color:
                                  Colors.grey.shade600,
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Register(),
                                    ),
                                  );
                                },

                                child: const Text(
                                  "Create Account",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
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

// ============================================================
// MAIN PAGE
// ============================================================

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  // ==========================================================
  // LOGOUT
  // ==========================================================

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      if (!context.mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
            (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // ==========================================================
  // CATEGORY CARD
  // ==========================================================

  Widget categoryCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),

      onTap: onTap,

      child: Container(
        width: 155,
        height: 135,

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(22),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 15,
              offset: const Offset(0, 7),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Container(
              width: 58,
              height: 58,

              decoration: BoxDecoration(
                color: color.withOpacity(0.10),
                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                size: 30,
                color: color,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),

        foregroundColor: Colors.white,

        elevation: 2,

        centerTitle: true,

        title: const Text(
          "Findr 360",
          style: TextStyle(
            color: Color(0xFFFFD54F),
            fontSize: 25,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),

        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.account_circle_outlined,
              size: 30,
            ),

            onSelected: (value) {
              if (value == "logout") {
                logout(context);
              }
            },

            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "logout",

                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),

                    SizedBox(width: 10),

                    Text("Logout"),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(width: 8),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            25,
            20,
            30,
          ),

          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 700,
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Text(
                    "Find what you need",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    "Explore hostels, messes and other services.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 25),


                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),

                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1565C0),
                          Color(0xFF1976D2),
                        ],
                      ),

                      borderRadius:
                      BorderRadius.circular(24),

                      boxShadow: [
                        BoxShadow(
                          color:
                          Colors.blue.withOpacity(0.20),
                          blurRadius: 15,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: const [
                              Text(
                                "Looking for a place?",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 7),

                              Text(
                                "Find hostels and rooms near your preferred location.",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 15),

                        const Icon(
                          Icons.location_city,
                          size: 65,
                          color: Color(0xFFFFD54F),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),


                  Text(
                    "Explore Categories",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 18),

                  // FIRST ROW
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,

                    children: [

                      categoryCard(
                        context: context,
                        icon: Icons.bed_rounded,
                        title: "PG & Hostels",
                        color: Colors.teal,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              HostelPage(),
                            ),
                          );
                        },
                      ),

                      categoryCard(
                        context: context,
                        icon: Icons.restaurant_rounded,
                        title: "Mess",
                        color: Colors.orange,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MessPage(),)
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // SECOND ROW
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.start,

                    children: [

                      categoryCard(
                        context: context,
                        icon: Icons.school_rounded,
                        title: "Classes",
                        color: Colors.deepPurple,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>ClassPage(),),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // ------------------------------------------------
                  // INFO
                  // ------------------------------------------------

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(20),

                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),

                    child: Row(
                      children: [

                        Container(
                          width: 48,
                          height: 48,

                          decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            shape: BoxShape.circle,
                          ),

                          child: const Icon(
                            Icons.info_outline,
                            color: Colors.teal,
                          ),
                        ),

                         SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [
                               Text(
                                "Find your next place",
                                style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "Search by location and explore available options.",
                                style: TextStyle(
                                  color:
                                  Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 0,
      ),
    );
  }
}