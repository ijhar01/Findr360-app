import 'package:flutter/material.dart';
import 'bottom-page.dart';


class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Contact Us",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Get in Touch",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Have a question or need help? We are here to help you.",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 25),

            contactCard(
              icon: Icons.person,
              title: "Ownner",
              value: "Ijhar Patel & Shobhit Kamble",
              color: Colors.green,
            ),



            const SizedBox(height: 25),

            contactCard(
              icon: Icons.phone_rounded,
              title: "Phone",
              value: "+91 98765 43210",
              color: Colors.green,
            ),


            const SizedBox(height: 15),

            contactCard(
              icon: Icons.email_rounded,
              title: "Email",
              value: "support@findr360.com",
              color: Colors.blue,
            ),

             SizedBox(height: 15),

            contactCard(
              icon: Icons.location_on_rounded,
              title: "Address",
              value: "123 College Road, Pune, Maharashtra, India",
              color: Colors.red,
            ),

            SizedBox(height: 15),

            contactCard(
              icon: Icons.access_time_rounded,
              title: "Working Hours",
              value: "Monday - Saturday\n9:00 AM - 6:00 PM",
              color: Colors.orange,
            ),

            SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding:EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                   Text(
                    "Listing ?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                   SizedBox(height: 8),

                  Text(
                    " To Add hostels, Pg's , messes, "
                        "classes or listings, please contact our support team.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
      ),
    );
  }

  Widget contactCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            width: 50,
            height: 50,

            decoration: BoxDecoration(
              color: color.withOpacity(0.10),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: color,
              size: 25,
            ),
          ),

          SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                 SizedBox(height: 5),

                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}