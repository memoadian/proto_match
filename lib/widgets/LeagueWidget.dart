import 'package:flutter/material.dart';
import 'package:proto_match/pages/LeagueDetail.dart';
import 'package:proto_match/styles.dart';

class LeagueWidget extends StatelessWidget {
  final String image;
  final String name;
  final int colorBegin;
  final int colorEnd;
  final PageController pageController;
  final int currentPage;

  LeagueWidget({Key key, this.image, this.name, this.colorBegin, this.colorEnd, this.pageController, this.currentPage})
     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LeagueDetail()),
        );
      },
      child: AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double value = 1;
          if (pageController.position.haveDimensions) {
            value = pageController.page - currentPage;
            value = (1 - (value.abs() * 1.6)).clamp(0.0, 1.0);
          }

          return Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: LeagueBackgroundClipper(),
                  child: Container(
                    height: screenHeight * .5,
                    width: screenWidth * .9,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(colorBegin), Color(colorEnd)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft
                      )
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.1),
                child: Image.network(
                  image,
                  height: 220 * value,
                ),
              ),
              Align(
                alignment: Alignment(0, 0.8),
                child: Text(name, style: AppTheme.pagerName,),
              )
            ],
          );
        },
      ),
    );
  }
}

class LeagueBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path clippedPath = Path();
    double curvedDistance = 40;

    clippedPath.moveTo(0, size.height * 0.4);
    clippedPath.lineTo(0, size.height - curvedDistance);
    clippedPath.quadraticBezierTo(1, size.height - 1, 0 + curvedDistance, size.height);
    clippedPath.lineTo(size.width - curvedDistance, size.height);
    clippedPath.quadraticBezierTo(size.width + 1, size.height - 1, size.width, size.height - curvedDistance);
    clippedPath.lineTo(size.width, 0 + curvedDistance);
    clippedPath.quadraticBezierTo(size.width - 1, 0, size.width - curvedDistance - 5, 0 + curvedDistance / 3);
    clippedPath.lineTo(curvedDistance, size.height * 0.29);
    clippedPath.quadraticBezierTo(1, (size.height * 0.3) + 10, 0, size.height * 0.4);

    return clippedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}