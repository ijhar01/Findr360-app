import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MessDetailsPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const MessDetailsPage({super.key, required this.data});

  @override
  State<MessDetailsPage> createState() => _MessDetailsPageState();
}

class _MessDetailsPageState extends State<MessDetailsPage> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> images = widget.data["images"] ?? [];

    String price = widget.data["price"]?.toString() ?? "N/A";
    String location =
        widget.data["location"]?.toString() ?? "Location not available";
    String contact =
        widget.data["contact"]?.toString() ?? "Contact not available";
    String direction = widget.data["direction"]?.toString() ?? "";
    String details = widget.data["details"]?.toString() ?? "Details not available";
    String name = widget.data["name"]?.toString()?? "Name not Found";



    return Scaffold(
      backgroundColor: Color(0xFFFFFBF5),

      appBar: AppBar(
        backgroundColor: Color(0xFFFFFBF5),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Mess Details",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE SECTION
              if (images.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 190,
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 4),
                      enlargeCenterPage: false,
                    ),
                    items: images.map((image) {
                      return Builder(
                        builder: (context) {
                          return Image.network(
                            image.toString(),
                            width: double.infinity,
                            fit: BoxFit.cover,

                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                child:Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }).toList(),
                  ),
                )
              else
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 60,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "No images available",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

              SizedBox(height: 25),

              // HOSTEL TITLE
              Text(
                "Mess Information",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade900,
                ),
              ),

              SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Mess Name",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.deepOrange,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color:Colors.black,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      details,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color:Colors.blueGrey,
                      ),
                    ),

                    SizedBox(height: 30),

                    // LOCATION CARD
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 28,
                          ),
                        ),

                        SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Location",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.deepOrange,
                                ),
                              ),

                              SizedBox(height: 5),

                              Text(
                                location,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              SizedBox(height: 15),

                              Text(
                                "Direction",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.deepOrange,
                                ),
                              ),

                              SizedBox(height: 10),

                              if (direction.isNotEmpty)
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(direction);

                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(
                                        url,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.directions),
                                  label: Text("Open in Google Maps"),
                                )
                              else
                                Text(
                                  "Direction not available",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),

                    // PRICE CARD
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.currency_rupee,
                            color: Colors.green,
                            size: 28,
                          ),
                        ),

                        SizedBox(width: 30),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.deepOrange,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              "₹$price",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 30),

                    // CONTACT CARD
                    Row(
                      children: [
                        Container(
                          padding:  EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.phone,
                            color: Colors.blue,
                            size: 28,
                          ),
                        ),

                        SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Contact",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.deepOrange,
                                ),
                              ),

                              SizedBox(height: 5),

                              Text(
                                contact,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),


                    /*
              SizedBox(height: 30),

              // CONTACT BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Contact functionality can be added later
                  },
                  icon: Icon(Icons.phone, color: Colors.white),
                  label: Text(
                    "Contact Hostel",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00897B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                  ),
                ),
              ),

         */
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
