import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:playstation5_design/colors.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Playstation5 Design',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyContent(
        mycontext: context,
      ),
    );
  }
}

class MyContent extends StatefulWidget {
  BuildContext mycontext;
  MyContent({this.mycontext});
  @override
  _MyContentState createState() => _MyContentState();
}

class _MyContentState extends State<MyContent>
    with SingleTickerProviderStateMixin {
  bool isSelected = false, isEnd = false;
  AnimationController _controller;
  Animation<double> _animation;
  double _width = 0;
  @override
  void initState() {
    // TODO: implement initState
    _width = MediaQuery.of(widget.mycontext).size.width / 2.25;
    print("Size width : " + _width.toString());

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    _animation = Tween<double>(
            begin: 0, end: MediaQuery.of(widget.mycontext).size.height - 110)
        .animate(_controller)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                isSelected = true; // TODO: for black background
              });
            }
          });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  Future<void> open() {
    setState(() {
      isEnd = true;
    });

    return Future.delayed(Duration(milliseconds: 200))
        .then((value) => _controller.forward());
  }

  Future<void> close() {
    setState(() {
      isEnd = false;
      isSelected = false;
    });

    return Future.delayed(Duration(milliseconds: 200))
        .then((value) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: isSelected ? blackColor : bgColor),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      child: !isSelected
                          ? Stack(
                              children: <Widget>[
                                Image.asset('assets/images/border.png'),
                                Align(
                                  alignment: Alignment.center,
                                  child: Neumorphic(
                                    style: NeumorphicStyle(
                                        shape: NeumorphicShape.flat,
                                        shadowDarkColorEmboss:
                                            Color(0xFF37536F).withOpacity(.6),
                                        shadowLightColorEmboss: Colors.white,
                                        depth: -8,
                                        lightSource: LightSource.topLeft,
                                        color: bgColor,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(16))),
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      child: Center(
                                        child: Image.asset(
                                            'assets/images/menu.png'),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Neumorphic(
                              style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  shadowLightColor: blackColor,
                                  depth: 4,
                                  intensity: .7,
                                  lightSource: LightSource.topLeft,
                                  color: blackColor,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(16))),
                              child: Container(
                                width: 56,
                                height: 56,
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/menu.png',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    InkWell(
                      onTap: () {
                        close();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 116 - 76,
                        height: 60,
                        child: Center(
                            child: Image.asset(
                          isSelected
                              ? 'assets/images/logo.png'
                              : 'assets/images/logo_black.png',
                          width: 120,
                        )),
                      ),
                    ),
                    !isEnd
                        ? Neumorphic(
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                shadowDarkColor: Colors.white,
                                shadowLightColor: Color(0xFFB9CCE2),
                                depth: 8,
                                lightSource: LightSource.bottomRight,
                                color: bgColor,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(16))),
                            child: Container(
                              width: 56,
                              height: 56,
                              child: Center(
                                child:
                                    Image.asset('assets/images/settings.png'),
                              ),
                            ),
                          )
                        : Neumorphic(
                            style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                shadowLightColor: blackColor,
                                depth: 4,
                                intensity: .7,
                                lightSource: LightSource.topLeft,
                                color: blackColor,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(16))),
                            child: Container(
                              width: 56,
                              height: 56,
                              child: Center(
                                child: Image.asset(
                                  'assets/images/settings.png',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 100,
                child: GridView.count(
                  padding: EdgeInsets.only(left: 38, right: 38, bottom: 120),
                  crossAxisCount: 2,
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 0,
                  shrinkWrap: true,
                  childAspectRatio: _width / 403,
                  children: <Widget>[
                    UnLikeItem(
                      image: 'assets/images/ps5_de.png',
                      title: 'Game console',
                      subtitle: 'Playstation 5 Digital Edition',
                    ),
                    LikeItem(
                      image: 'assets/images/ps5.png',
                      title: 'Game console',
                      subtitle: 'Playstation 5',
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        open();
                      },
                      child: UnLikeItem(
                        image: 'assets/images/Controller.png',
                        title: 'Gaming Controller',
                        subtitle: 'DualSense Wireless Controller',
                      ),
                    ),
                    UnLikeItem(
                      image: 'assets/images/headset.png',
                      title: 'Audio and Communication',
                      subtitle: 'Wireless Headset',
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 80,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              shadowLightColor: blackColor,
                              depth: 4,
                              intensity: .7,
                              lightSource: LightSource.topLeft,
                              color: blackColor,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(16))),
                          child: Container(
                            width: 56,
                            height: 56,
                            color: blackColor,
                            child: Center(
                              child: Image.asset('assets/images/home.png'),
                            ),
                          ),
                        ),
                        Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              shadowLightColor: blackColor,
                              depth: 4,
                              intensity: .7,
                              lightSource: LightSource.topLeft,
                              color: blackColor,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(16))),
                          child: Container(
                            width: 56,
                            height: 56,
                            color: blackColor,
                            child: Center(
                              child: Image.asset('assets/images/search.png'),
                            ),
                          ),
                        ),
                        Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              shadowLightColor: blackColor,
                              depth: 4,
                              intensity: .7,
                              lightSource: LightSource.topLeft,
                              color: blackColor,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(16))),
                          child: Container(
                            width: 56,
                            height: 56,
                            color: blackColor,
                            child: Center(
                              child: Image.asset('assets/images/profile.png'),
                            ),
                          ),
                        ),
                        Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              shadowLightColor: blackColor,
                              depth: 4,
                              intensity: .7,
                              lightSource: LightSource.topLeft,
                              color: blackColor,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(16))),
                          child: Container(
                            width: 56,
                            height: 56,
                            color: blackColor,
                            child: Center(
                              child: Image.asset('assets/images/shop.png'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: blackColor,
                borderRadius: BorderRadius.circular(60)),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: _animation.value,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: Image.asset(
                        'assets/images/text.png',
                        width: 300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('assets/images/Controller.png',
                            fit: BoxFit.fitWidth),
                        height:
                            (MediaQuery.of(context).size.height / 2) - 118 - 45,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/slider_23.png', width: 200),
                ),
                isSelected
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height:
                              (MediaQuery.of(context).size.height / 2) - 140,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 190,
                                child: ListView(
                                  padding: EdgeInsets.only(left: 38),
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    SpecItem(
                                      index: 0,
                                      image: 'assets/images/microphone.png',
                                      text: 'Built-In Microphone',
                                    ),
                                    SpecItem(
                                      index: 1,
                                      image: 'assets/images/headset_jack.png',
                                      text: 'Headset Jack',
                                    ),
                                    SpecItem(
                                      index: 2,
                                      image: 'assets/images/motion.png',
                                      text: 'Motion\nSensor',
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 38.0),
                                child: Container(
                                  constraints: BoxConstraints(maxHeight: 60),
                                  decoration: BoxDecoration(
                                      color: blueColor,
                                      borderRadius: BorderRadius.circular(60)),
                                  child: Row(
                                    children: <Widget>[
                                      Neumorphic(
                                        style: NeumorphicStyle(
                                            shape: NeumorphicShape.convex,
                                            shadowLightColorEmboss:
                                                darkBlueColor,
                                            depth: -8,
                                            intensity: .8,
                                            lightSource: LightSource.topLeft,
                                            color: darkBlueColor,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(60))),
                                        child: Container(
                                          width: 140,
                                          color: darkBlueColor,
                                          child: Center(
                                            child: Text(
                                              '\$70',
                                              style: TextStyle(
                                                  fontFamily: 'MontserratBold',
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            'Buy Now',
                                            style: TextStyle(
                                                fontFamily: 'MontserratBold',
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                140 -
                                                2 -
                                                76,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
            decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: borderBlackColor),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60))),
          ),
        )
      ],
    );
  }
}

class SpecItem extends StatelessWidget {
  int index;
  String image;
  String text;
  SpecItem({this.index, this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Neumorphic(
          style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              shadowDarkColor: Colors.white,
              shadowLightColor: Color(0xFFB9CCE2),
              depth: 8,
              lightSource: LightSource.bottomRight,
              color: bgColor,
              boxShape:
                  NeumorphicBoxShape.roundRect(BorderRadius.circular(16))),
          child: Container(
            width: 150,
            height: 160,
            child: Stack(
              children: <Widget>[
                index == 0
                    ? Image.asset('assets/images/triangle.png')
                    : SizedBox(),
                Align(
                  alignment: index == 0
                      ? Alignment.bottomRight
                      : index == 1 ? Alignment.bottomLeft : Alignment.topLeft,
                  child: Image.asset(index == 0
                      ? 'assets/images/circle.png'
                      : index == 1
                          ? 'assets/images/circle_2.png'
                          : 'assets/images/triangle_2.png'),
                ),
                index > 0
                    ? Align(
                        alignment: index == 1
                            ? Alignment.topRight
                            : Alignment.bottomRight,
                        child: Image.asset(index == 1
                            ? 'assets/images/x.png'
                            : 'assets/images/square.png'),
                      )
                    : SizedBox(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(image),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            text,
                            style: TextStyle(
                                fontFamily: 'MontserratBold', fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 23,
        )
      ],
    );
  }
}

class UnLikeItem extends StatelessWidget {
  String image;
  String title;
  String subtitle;

  UnLikeItem({this.image, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 43,
          ),
          Container(
            height: 300 - 21.5,
            child: Neumorphic(
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  shadowDarkColor: Colors.white,
                  shadowLightColor: Color(0xFFB9CCE2),
                  depth: 8,
                  lightSource: LightSource.bottomRight,
                  color: bgColor,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(16))),
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: bgColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 16.0, right: 16.0),
                    child: Container(
                      height: 210,
                      child: Center(child: Image.asset(image)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                      child: Image.asset('assets/images/like.png'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, bottom: 8.0, right: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 10, fontFamily: 'MontserratMedium'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'DrukWideMedium',
                                color: blueColor),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LikeItem extends StatelessWidget {
  String image;
  String title;
  String subtitle;

  LikeItem({this.image, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 43.0),
            child: Container(
              decoration: BoxDecoration(
                  color: blueColor, borderRadius: BorderRadius.circular(16)),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              image,
              height: 275,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 19,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, bottom: 8.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style:
                        TextStyle(fontSize: 10, fontFamily: 'MontserratMedium'),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'DrukWideMedium',
                        color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
