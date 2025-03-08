import 'package:flutter/material.dart';

class CreditCardCarousel extends StatefulWidget {
  const CreditCardCarousel({Key? key}) : super(key: key);

  @override
  _CreditCardCarouselState createState() => _CreditCardCarouselState();
}

class _CreditCardCarouselState extends State<CreditCardCarousel> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.8);

  final List<CardData> _cards = [
    CardData(
      cardNumber: "**** **** 0124",
      type: "VISA",
      backgroundColor: Colors.black,
      textColor: Colors.white,
      logoColor: Colors.white,
      showCVC: true,
    ),
    CardData(
      cardNumber: "**** **** 5678",
      type: "VISA",
      backgroundColor: Colors.white,
      textColor: Colors.black,
      logoColor: Colors.blue,
      showCVC: false,
    ),
    CardData(
      cardNumber: "**** **** 9012",
      type: "MASTERCARD",
      backgroundColor: Color(0xFF6B4894), // Purple
      textColor: Colors.white,
      logoColor: null, // Uses the MasterCard logo with default colors
      showCVC: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentIndex != next) {
        setState(() {
          _currentIndex = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _cards.length,
            itemBuilder: (context, index) {
              bool isCurrentCard = index == _currentIndex;
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: isCurrentCard ? 0 : 20,
                ),
                child: _buildCard(_cards[index]),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _cards.length,
            (index) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentIndex == index ? 24 : 8,
              decoration: BoxDecoration(
                color: _currentIndex == index ? Color(0xFF9B51E0) : Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(CardData card) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: card.backgroundColor,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.cardNumber,
                  style: TextStyle(
                    color: card.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (card.showCVC)
                  Text(
                    "CVC",
                    style: TextStyle(
                      color: card.textColor.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: _buildCardLogo(card),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardLogo(CardData card) {
    if (card.type == "VISA") {
      return Text(
        "VISA",
        style: TextStyle(
          color: card.logoColor ?? Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      );
    } else if (card.type == "MASTERCARD") {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          Transform.translate(
            offset: Offset(-10, 0),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      );
    }
    return SizedBox();
  }
}

class CardData {
  final String cardNumber;
  final String type; // "VISA" or "MASTERCARD"
  final Color backgroundColor;
  final Color textColor;
  final Color? logoColor;
  final bool showCVC;

  CardData({
    required this.cardNumber,
    required this.type,
    required this.backgroundColor,
    required this.textColor,
    this.logoColor,
    this.showCVC = false,
  });
}
