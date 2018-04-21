import 'package:flutter/material.dart';
import 'package:flutkart/utils/flutkart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController animCtrl;
  Animation<double> animation;

  AnimationController animCtrl2;
  Animation<double> animation2;

  bool showFirst = true;

  @override
  void initState() {
    super.initState();

    // Animation init
    animCtrl = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);
    animation = new CurvedAnimation(parent: animCtrl, curve: Curves.easeOut);
    animation.addListener(() {
      this.setState(() {});
    });
    animation.addStatusListener((AnimationStatus status) {});

    animCtrl2 = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);
    animation2 = new CurvedAnimation(parent: animCtrl2, curve: Curves.easeOut);
    animation2.addListener(() {
      this.setState(() {});
    });
    animation2.addStatusListener((AnimationStatus status) {});
  }

  @override
  void dispose() {
    animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Flutkart.name),
        actions: <Widget>[
          Padding(
            child: Icon(Icons.search),
            padding: const EdgeInsets.only(right: 10.0),
          )
        ],
      ),
      drawer: Drawer(),
      body: new Center(
          child: new Stack(
        children: <Widget>[
          new Center(
            child: new DragTarget(onWillAccept: (_) {
              print('red');
              return true;
            }, onAccept: (_) {
              setState(() => showFirst = false);
              animCtrl.forward();
              animCtrl2.forward();
            }, builder: (_, _1, _2) {
              return new SizedBox.expand(
                child: new Container(color: Colors.red),
              );
            }),
          ),
          new Center(
            child: new DragTarget(onWillAccept: (_) {
              print('green');
              return true;
            }, builder: (_, _1, _2) {
              return new SizedBox.fromSize(
                size: new Size(350.0, 350.0),
                child: new Container(color: Colors.green),
              );
            }),
          ),
          new Stack(alignment: FractionalOffset.center, children: <Widget>[
            new Align(
              alignment: new Alignment(0.0, 0.5 - animation.value * 0.15),
              child: new CardView(200.0 + animation.value * 60),
            ),
            new Align(
                alignment: new Alignment(0.0, 0.35 - animation2.value * 0.35),
                child: new InkWell(
                  onTap: () => Navigator.of(context).push(
                      new MaterialPageRoute(builder: (_) => new HomeScreen())),
                  child: new CardView(260.0 + animation2.value * 80),
                )),
            new Draggable(
              feedback: new CardView(340.0),
              child: showFirst ? new CardView(340.0) : new Container(),
              childWhenDragging: new Container(),
            )
          ]),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () => {},
        child: Icon(Icons.shopping_cart, color: Colors.white),
      ),
    );
  }
}

class CardView extends StatelessWidget {
  final double cardSize;
  CardView(this.cardSize);

  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new SizedBox.fromSize(
      size: new Size(cardSize, cardSize),
    ));
  }
}
