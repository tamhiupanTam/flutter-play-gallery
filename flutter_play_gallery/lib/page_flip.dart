import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';

class RegistrationMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegistrationMainPageState();
}

class RegistrationMainPageState extends State<RegistrationMainPage>
    with TickerProviderStateMixin {
  PageController _pageController;
  AnimationController rotateAnimationController;
  Animation rotationAngle;
  int currentPage;

  @override
  void initState() {
    currentPage = 0;
    _pageController = PageController(initialPage: 0, keepPage: true);
    rotateAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    rotationAngle = Tween<double>(begin: 0.0, end:  pi / 2.0)
        .animate(rotateAnimationController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            currentPage ++;
          });
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    rotateAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.lightGreenAccent,
            ),
            child: LayoutBuilder(builder: (buildContext, constraint) {
              return
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Transform(
                          transform: Matrix4.identity()
                          // ..setEntry(3, 2, 0.0005)
                          // ..rotateX (-rotationAngle.value * 2.0)
                          //  ..rotateY(rotationAngle.value)
                          ,
                          alignment: Alignment.topLeft,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              height: constraint.maxHeight / 2.0,
                              width: constraint.maxWidth * 3.0 / 4.0,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(labelText: "Field 4"),
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(labelText: "Field 5"),
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(labelText: "Field 6"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        currentPage != 0 ? Container() :
                        Transform(
                          transform: Matrix4.identity()
                          // ..setEntry(3, 2, 0.001)  perspective : set row 3 col 2 means inverse pixel of 0.001 on z axis
                            ..rotateX (-rotationAngle.value )
                            ..rotateY(rotationAngle.value),
                          alignment: Alignment.topLeft,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(blurRadius: 2.0,spreadRadius: 0.5,offset: Offset(2.0, 2.0))],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                              height: constraint.maxHeight / 2.0,
                              width: constraint.maxWidth * 3.0 / 4.0,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(labelText: "Field 1"),
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(labelText: "Field 2"),
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(labelText: "Field 3"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text("previous"),
                          onPressed: (){
                            setState(() {
                              currentPage = 0;
                              rotateAnimationController.reverse();
                            });
                          },
                        ),
                        FlatButton(
                          child: Text("next"),
                          onPressed: (){
                            setState(() {
                              currentPage = 0;
                              rotateAnimationController.forward(from: 0.0);
                            });
                          },
                        )
                      ],)
                  ],
                )
              ;
            }),
          ),
          Center(
            child: Text("page2"),
          ),
          Center(
            child: Text("page3"),
          )
        ],
      ),
    );
  }
}
