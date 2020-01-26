import 'package:flutter/material.dart';
import 'package:proto_match/styles.dart';
import 'package:proto_match/widgets/LeagueWidget.dart';


class Leagues extends StatefulWidget {
  @override
  createState() => LeaguesState();
}

class LeaguesState extends State<Leagues> {
  PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: currentPage,
      keepPage: false
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ligas'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50, left: 10, right: 10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'Pro ', style: AppTheme.title1),
                      TextSpan(text: 'Match', style: AppTheme.title2),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Text('Una quiniela para que juegues contra gente de todo el mundo :D',
                  style: AppTheme.paragraph,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  children: <Widget>[
                    LeagueWidget(
                      image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/MX_logo.png/1200px-MX_logo.png',
                      name: 'Liga MX',
                      colorBegin: 0xFFB2FCCB,
                      colorEnd: 0xFF29643E,
                      pageController: _pageController,
                      currentPage: 0,
                    ),
                    LeagueWidget(
                      image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/LaLiga_Santander.svg/1024px-LaLiga_Santander.svg.png',
                      name: 'La Liga',
                      colorBegin: 0xFFFCB2B2,
                      colorEnd: 0xFF730707,
                      pageController: _pageController,
                      currentPage: 1,
                    ),
                    LeagueWidget(
                      image: 'https://logodownload.org/wp-content/uploads/2016/03/premier-league-5.png',
                      name: 'Premier League',
                      colorBegin: 0xFFB2D7FF,
                      colorEnd: 0xFF093C73,
                      pageController: _pageController,
                      currentPage: 2,
                    ),
                    LeagueWidget(
                      image: 'https://upload.wikimedia.org/wikipedia/commons/9/93/Serie_A_Logo_%28ab_2019%29.png',
                      name: 'Serie A',
                      colorBegin: 0xFFD9D9D9,
                      colorEnd: 0xFF505050,
                      pageController: _pageController,
                      currentPage: 3,
                    ),
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