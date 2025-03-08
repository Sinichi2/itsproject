import 'package:flutter/material.dart';
// Import the custom navigation bar
import '../components/navigationbar.dart';
// Import the credit card carousel
import '../components/credit_card_carousel.dart';

class Reportspage extends StatefulWidget {
  const Reportspage({Key? key}) : super(key: key);

  @override
  _ReportpageState createState() => _ReportpageState();
}

class _ReportpageState extends State<Reportspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Report page",
          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w400),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.star, color: Colors.white),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            // Gradient overlay
            Opacity(
              opacity: 0.15,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: const [
                      Color(0xFFA59E9E), // 0%
                      Color(0xFFEA1A6E), // 50%
                      Color(0xFF9B51E0), // 80%
                      Color(0xFF9B51E0), // 100%
                    ],
                    stops: const [0.0, 0.5, 0.8, 1.0],
                  ),
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),

                      // Credit Card Carousel
                      CreditCardCarousel(),

                      SizedBox(height: 24),

                      // Total Portfolio & Total Spent Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard(
                              "Total Portfolio",
                              "₱45,200.00",
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildSummaryCard(
                              "Total Spent",
                              "₱3,580.25",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      // Creative Cloud & Analytics Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildSubscriptionCard(
                              "Creative Cloud",
                              "₱997 / month",
                              "3 days left",
                              icon: Icons.palette,
                              iconBackgroundColors: [
                                Colors.pink,
                                Colors.purple,
                                Colors.blue,
                                Colors.green,
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(child: _buildAnalyticsCard()),
                        ],
                      ),

                      SizedBox(height: 24),

                      // Transactions Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Transactions",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See all",
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8),

                      // Transaction List
                      _buildTransactionItem(
                        "Transportation",
                        "₱400.32",
                        Icons.directions_bus,
                        Color(0xFF9B51E0),
                      ),

                      SizedBox(height: 12),

                      _buildTransactionItem(
                        "Electricity",
                        "₱400.32",
                        Icons.bolt,
                        Color(0xFF9B51E0),
                      ),

                      SizedBox(
                        height: 140,
                      ), // Increased bottom padding for new navbar
                    ],
                  ),
                ),
              ),
            ),

            // Removed the old FAB as it will be part of the CustomNavBar
          ],
        ),
      ),
      // Do not include bottomNavigationBar property as the CustomNavBar will handle navigation
      // in the MainApp widget
    );
  }

  Widget _buildSummaryCard(String title, String amount) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.white60, fontSize: 14)),
          SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(
    String title,
    String price,
    String timeLeft, {
    required IconData icon,
    required List<Color> iconBackgroundColors,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: iconBackgroundColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(price, style: TextStyle(color: Colors.white70, fontSize: 14)),
          SizedBox(height: 8),
          Text(timeLeft, style: TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF9B51E0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                "Analytics",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Abstract background pattern
          Positioned(
            top: -10,
            right: -10,
            child: Opacity(
              opacity: 0.2,
              child: Icon(Icons.analytics, size: 60, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    String title,
    String amount,
    IconData icon,
    Color iconBgColor,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
