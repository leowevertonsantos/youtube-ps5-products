import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:ps5_products_youtube/screens/homepage/item_card_shape.dart';
import 'package:ps5_products_youtube/screens/homepage/models/controller.dart';
import 'package:ps5_products_youtube/screens/homepage/models/options.dart';

const Color blueColor = const Color(0xCC2372F0);
const Color iconBackgroundColor = const Color(0xFF647082);
final BorderRadius optionBorderRadius = BorderRadius.circular(8);

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _BackGround(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              _AppBar(),
              SizedBox(
                height: 30,
              ),
              _Title(
                firstTitle: 'Produtos em',
                secondeTitle: 'Destaque',
              ),
              SizedBox(height: 30),
              _SettingAndOption(),
              SizedBox(height: 25),
              _ItemsWidget(items: controllers),
              Spacer(),
              _BottomBar(),
              SizedBox(height: 30)
            ],
          )
        ],
      ),
    );
  }
}

class _BottomBar extends StatefulWidget {
  const _BottomBar({Key key}) : super(key: key);

  @override
  __BottomBarState createState() => __BottomBarState();
}

class __BottomBarState extends State<_BottomBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    void ontap(int tapIndex) {
      setState(() {
        selectedIndex = tapIndex;
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClayContainer(
        height: 60,
        borderRadius: 10,
        color: Colors.white,
        spread: 10,
        depth: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _BarItem(
                  icon: Icons.home,
                  text: 'Home',
                  isSelected: selectedIndex == 0,
                  onTap: () => ontap(0)),
              _BarItem(
                  icon: Icons.person,
                  text: 'Perfil',
                  isSelected: selectedIndex == 1,
                  onTap: () => ontap(1)),
              _BarItem(
                  icon: Icons.settings,
                  text: 'Configuração',
                  isSelected: selectedIndex == 2,
                  onTap: () => ontap(2)),
              _BarItem(
                  icon: Icons.bookmark,
                  text: 'Lista de desejos',
                  isSelected: selectedIndex == 3,
                  onTap: () => ontap(3)),
            ],
          ),
        ),
      ),
    );
  }
}

class _BarItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;
  final Function() onTap;

  const _BarItem({Key key, this.icon, this.text, this.isSelected, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: isSelected ? blueColor : Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : iconBackgroundColor,
            ),
            if (isSelected) VerticalDivider(color: iconBackgroundColor),
            if (isSelected)
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SettingAndOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        children: [
          Icon(
            Icons.filter_list_rounded,
            color: iconBackgroundColor,
            size: 40,
          ),
          SizedBox(width: 20),
          _OptionsWidget(selectedOptionId: 1),
        ],
      ),
    );
  }
}

class _ItemsWidget extends StatelessWidget {
  final List<Controller> items;

  const _ItemsWidget({Key key, this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.42,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: PageController(viewportFraction: 0.7),
        // pageSnapping: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              children: [
                Material(
                  elevation: 10,
                  shape: ItemCardShape(size.width * 0.65, size.height * 0.38),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Align(
                    alignment: Alignment(0, -0.3),
                    child: Image.asset(items[index].imagePath),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[index].title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          items[index].description,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 20,
                  child: Image.asset(
                    'assets/icons/ps_logo.png',
                    width: 40,
                    height: 40,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OptionsWidget extends StatelessWidget {
  final int selectedOptionId;

  const _OptionsWidget({
    Key key,
    @required this.selectedOptionId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: options.map((option) {
          return _Option(
            option: option,
            isSelected: option.id == selectedOptionId,
          );
        }).toList(),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  final Option option;
  final bool isSelected;

  const _Option({
    Key key,
    this.option,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 70,
          height: 65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:
                  isSelected ? Colors.black87.withOpacity(0.8) : Colors.white),
          child: Image.asset(option.imagePath,
              color: isSelected ? Colors.white : iconBackgroundColor),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String firstTitle;
  final String secondeTitle;

  const _Title({Key key, this.firstTitle, this.secondeTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: firstTitle,
              style: TextStyle(
                height: 0.8,
                fontWeight: FontWeight.w800,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            TextSpan(text: '\n'),
            TextSpan(
              text: secondeTitle,
              style: TextStyle(
                fontFamily: 'BungeeOutline-Regular',
                height: 1,
                letterSpacing: 5,
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClayContainer(
            height: 50,
            width: 50,
            depth: 20,
            borderRadius: 25,
            curveType: CurveType.concave,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: iconBackgroundColor.withOpacity(0.05),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  )),
              child: Icon(
                Icons.menu,
                color: iconBackgroundColor,
                size: 25,
              ),
            ),
          ),
          ClayContainer(
            height: 50,
            width: 50,
            depth: 20,
            parentColor: blueColor,
            borderRadius: 25,
            curveType: CurveType.convex,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: iconBackgroundColor.withOpacity(0.1),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: iconBackgroundColor,
                size: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BackGround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Positioned(
      top: 0,
      right: 0,
      width: size.width * 0.4,
      height: size.height * 0.85,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
        ),
        child: const ColoredBox(
          color: blueColor,
        ),
      ),
    );
  }
}
