import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'mess-page-details.dart';

class MessPage extends StatefulWidget {
  const MessPage({super.key});

  @override
  State<MessPage> createState() => _MessPageState();
}

class _MessPageState extends State<MessPage> {
  String searchLocation = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF5),


      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFBF5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Find Your Mess",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),


      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),

          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),

              child: Column(
                children: [
                  // -------------------------------------------------
                  // SEARCH
                  // -------------------------------------------------
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search by location...",

                      prefixIcon: const Icon(Icons.search, color: Colors.teal),

                      filled: true,
                      fillColor: Colors.white,

                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 15,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: Colors.teal,
                          width: 2,
                        ),
                      ),
                    ),

                    onChanged: (value) {
                      setState(() {
                        searchLocation = value.trim().toLowerCase();
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  // -------------------------------------------------
                  // HOSTEL LIST
                  // -------------------------------------------------
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("mess")
                          .snapshots(),

                      builder: (context, snapshot) {
                        // -------------------------------------------------
                        // LOADING
                        // -------------------------------------------------

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.teal,
                            ),
                          );
                        }

                        // -------------------------------------------------
                        // ERROR
                        // -------------------------------------------------

                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "Something went wrong.",
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                        }

                        // -------------------------------------------------
                        // NO DATA
                        // -------------------------------------------------

                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text("No mess data available."),
                          );
                        }

                        final docs = snapshot.data!.docs;

                        // -------------------------------------------------
                        // SEARCH EMPTY
                        // -------------------------------------------------

                        if (searchLocation.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Icon(
                                  Icons.search,
                                  size: 65,
                                  color: Colors.grey.shade400,
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  "Search for a location",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  "Find mess near you",
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          );
                        }

                        // -------------------------------------------------
                        // FILTER HOSTELS
                        // -------------------------------------------------

                        final filtered = docs.where((doc) {
                          final data = doc.data() as Map<String, dynamic>;

                          final location = (data["location"] ?? "")
                              .toString()
                              .trim()
                              .toLowerCase();

                          return location.startsWith(searchLocation);
                        }).toList();

                        // -------------------------------------------------
                        // NO RESULTS
                        // -------------------------------------------------

                        if (filtered.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Icon(
                                  Icons.location_off_outlined,
                                  size: 65,
                                  color: Colors.grey.shade400,
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  "No mess found",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  "Try another location",
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          );
                        }

                        // -------------------------------------------------
                        // HOSTEL LIST
                        // -------------------------------------------------

                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),

                          itemCount: filtered.length,

                          itemBuilder: (context, index) {
                            final doc = filtered[index];

                            final data = doc.data() as Map<String, dynamic>;

                            final images = List<String>.from(
                              data["images"] ?? [],
                            );

                            return Container(
                              margin: const EdgeInsets.only(bottom: 18),

                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(22),

                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.07),

                                    blurRadius: 15,

                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  // -----------------------------------------
                                  // IMAGE
                                  // -----------------------------------------
                                  if (images.isNotEmpty)
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(22),
                                      ),

                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                          height: 190,

                                          viewportFraction: 1,

                                          autoPlay: true,

                                          autoPlayInterval: const Duration(
                                            seconds: 4,
                                          ),
                                        ),

                                        items: images.map((imgUrl) {
                                          return Image.network(
                                            imgUrl,

                                            width: double.infinity,

                                            fit: BoxFit.cover,

                                            errorBuilder:
                                                (context, error, stack) {
                                              return Container(
                                                color: Colors.grey.shade200,

                                                child: const Center(
                                                  child: Icon(
                                                    Icons
                                                        .image_not_supported,
                                                    size: 50,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  else
                                    Container(
                                      height: 190,

                                      width: double.infinity,

                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,

                                        borderRadius:
                                        const BorderRadius.vertical(
                                          top: Radius.circular(22),
                                        ),
                                      ),

                                      child: const Center(
                                        child: Icon(
                                          Icons.image_outlined,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),

                                  // -----------------------------------------
                                  // DETAILS
                                  // -----------------------------------------
                                  Padding(
                                    padding: const EdgeInsets.all(16),

                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                      children: [
                                        // ---------------------------------
                                        // Name
                                        // ---------------------------------
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.restaurant,
                                              size: 17,
                                              color: Colors.red,
                                            ),

                                            SizedBox(width: 5),

                                            Expanded(
                                              child: Text(
                                                data["name"]?.toString() ??
                                                    "name not available",

                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),


                                        // ---------------------------------
                                        // PRICE
                                        // ---------------------------------
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.currency_rupee,
                                              size: 17,
                                              color: Colors.green,
                                            ),

                                             SizedBox(width: 4),

                                            Text(
                                              data["price"]?.toString() ??
                                                  "N/A",

                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),

                                            const SizedBox(width: 5),

                                            Text(
                                              "/ month",

                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 15),

                                        // ---------------------------------
                                        // DETAILS BUTTON
                                        // ---------------------------------
                                        SizedBox(
                                          width: double.infinity,

                                          height: 50,

                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MessDetailsPage(
                                                          data:{
                                                            "images": data["images"]??[],
                                                            "location": data["location"]?? "",
                                                            "price": data["price"]??"",
                                                            "contact": data["contact"]??"",
                                                            "direction": data["direction"]??"",
                                                            "details": data["details"]??"",
                                                            "name": data["name"]??"",
                                                          }
                                                      ),
                                                ),
                                              );
                                            },

                                            icon: const Icon(
                                              Icons.visibility_outlined,
                                            ),

                                            label: const Text("View Details"),

                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.teal,

                                              foregroundColor: Colors.white,

                                              elevation: 2,

                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
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
