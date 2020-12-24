import 'package:flutter/material.dart';
import 'package:pet_social_app/theme/theme.dart';
import 'package:pet_social_app/utils/responsive.dart';
import 'package:pet_social_app/pages/home/trend_page.dart';
import 'package:pet_social_app/pages/home/start_page.dart';
import 'package:pet_social_app/pages/home/profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  int _currentIndex = 0;
  Animation<double> _animation;
  AnimationController _animationController;

  final _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _animation = Tween(begin: 1.0, end: 1.1).animate(CurvedAnimation(curve: Curves.ease, parent: _animationController));
    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveScreen(context);
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _bottomAppBarItem(FontAwesomeIcons.fire, 0, responsive),
            _bottomAppBarItem(FontAwesomeIcons.home, 1, responsive),
            _bottomAppBarItem(FontAwesomeIcons.userAlt, 2, responsive),
          ],
        ),
        shape: CircularNotchedRectangle(),
        color: MyTheme.blue,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => pageChanged(index),
        children: [
          TrendPage(),
          StartPage(),
          ProfilePage()
        ]
      )
    );
  }

  Widget _bottomAppBarItem(IconData icon, int cant, ResponsiveScreen responsive) {
    return IconButton(
      icon: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return Transform.scale(
            scale: (_currentIndex == cant) ? _animation.value : 1.0,
            child: Icon(icon,
              size: responsive.ip(2.8),
              color: (_currentIndex == cant)
              ? MyTheme.pink
              : Colors.white
            )
          );
        },
      ),
      onPressed: () => bottomTapped(cant),
    );
  }

  void pageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    _animationController.forward();
  }

  void bottomTapped(int index) {
    _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

}