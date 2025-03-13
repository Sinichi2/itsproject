import 'package:flutter/material.dart';
import 'learn.dart';
import '../components/navigationbar.dart';
import '../components/nav_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<Homepage> {
  //Navigation bar
  final homeNavKey = GlobalKey<NavigatorState>();
  final stocksNavKey = GlobalKey<NavigatorState>();
  final reportNavKey = GlobalKey<NavigatorState>();
  final accountNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<NavModel> items = [];

  bool _hideBalance = false;
  double _savingsAmount = 120342.0;
  double _investmentsAmount = 124342.0;

  // Calculate total wallet balance from savings and investments
  double get _walletBalance => _savingsAmount + _investmentsAmount;

  

  @override
  void initState() {
    super.initState(); 
    items = [
      NavModel(
        page: const TabPage(tab: 1), 
        navKey: homeNavKey, 
      ),
            NavModel(
        page: const TabPage(tab: 2), 
        navKey: stocksNavKey, 
      ),
                  NavModel(
        page: const TabPage(tab: 3), 
        navKey: reportNavKey, 
      ),
                  NavModel(
        page: const TabPage(tab: 4), 
        navKey: accountNavKey, 
      ),

    ]
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //background color
        color: Colors.black,
        child: Stack(
          children: [
            // Background gradient
            Opacity(
              opacity: 0.15,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFA59E9E), // 0%
                      Color(0xFFEA1A6E), // 50%
                      Color(0xFF9B51E0), // 80%
                      Color(0xFF9B51E0), // 100%
                    ],
                    stops: [0.0, 0.5, 0.8, 1.0],
                  ),
                ),
              ),
            ),

            //Main Content of the whole thing
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dashboard header
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 16,
                                  fontFamily: 'Archivo',
                                ),
                              ),
                              //Shiva Matthew
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  'Shiva Matthew',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Archivo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //Flow points and learn icon
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3.0,
                                  horizontal: 14.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(0, 174, 174, 174),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/Coin.png', // Changed to Image.asset and PNG path
                                      width: 12.0,
                                      height: 12.0,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      '300',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 4),
                              //Learn icon
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const Learnpage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 1.0,
                                    horizontal: 5.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/Learn.png', // Changed to Image.asset and PNG path
                                        width: 30.0,
                                        height: 25.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Wallet card
                    Opacity(
                      opacity: 1,
                      child: Container(
                        margin: const EdgeInsets.only(top: 16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(25, 165, 158, 158),
                              Color.fromARGB(25, 234, 26, 110),
                              Color.fromARGB(25, 155, 81, 224),
                            ],
                            stops: [0.0, 0.5, 1.0],
                          ),
                          border: Border.all(
                            color: Colors.purpleAccent.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2.0),
                            // Wallet balance
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wallet Balance',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _hideBalance
                                          ? '₱ ••••••'
                                          : '₱ ${_walletBalance.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _hideBalance = !_hideBalance;
                                        });
                                      },
                                      child: Icon(
                                        _hideBalance
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 16.0),

                            // Investments and savings
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      _hideBalance
                                          ? '₱••••• Savings'
                                          : '₱${_savingsAmount.toStringAsFixed(0)} Savings',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16.0),
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.purple,
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      _hideBalance
                                          ? '₱••••• Investments'
                                          : '₱${_investmentsAmount.toStringAsFixed(0)} Investments',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Progress Tracker
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Progress Tracker',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Goal progress card
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF282828).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Buying a House',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Text(
                                          '1.3 M of 2 M',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          '69%',
                                          style: TextStyle(
                                            color: Colors.pinkAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8.0),
                                    Container(
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          4.0,
                                        ),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Colors.pinkAccent,
                                            Colors.purpleAccent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade900,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Column(
                                    children: const [
                                      Text(
                                        '123',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'funds',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8.0),

                          // Action buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildActionButton(
                                Icons.document_scanner_outlined,
                              ),
                              _buildActionButton(Icons.chat_bubble_outline),
                              _buildActionButton(Icons.calendar_today_outlined),
                              _buildActionButton(Icons.more_horiz),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Recommendations
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 12.0),
                      child: Text(
                        'Recommendations',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Archivo',
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Recommendation cards
                    SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          _buildRecommendationCard(
                            'Savings',
                            Colors.pinkAccent,
                          ),
                          const SizedBox(width: 12),
                          _buildRecommendationCard(
                            'Budget',
                            Colors.purpleAccent,
                          ),
                          const SizedBox(width: 12),
                          _buildRecommendationCard('Inv', Colors.blueAccent),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Icon(icon, color: Colors.white70, size: 20.0),
    );
  }

  Widget _buildRecommendationCard(String title, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.8), color.withOpacity(0.4)],
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
