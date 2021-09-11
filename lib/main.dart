import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class TakTicFont {
  TakTicFont._();

  static const _kFontFam = 'TakTicFont';
  static const String? _kFontPkg = null;

  static const IconData cancel =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData circle_empty =
      IconData(0xf10c, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tak Tic Toe',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool oTurn = true; // the first player in O
  int oWins = 0;
  int xWins = 0;
  int _moves = 0;
  List<IconData?> _marker = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
  ];

  void _setMark(int index) {
    if (_marker[index] == null) {
      setState(() {
        if (oTurn) {
          _marker[index] = TakTicFont.circle_empty;
        } else {
          _marker[index] = TakTicFont.cancel;
        }
        oTurn = !oTurn;
        _checkWinCondition();
      });
    }
  }

  void _checkWinCondition() {
    _moves += 1;

    if (_marker[0] == _marker[1] &&
        _marker[1] == _marker[2] &&
        _marker[2] != null) {
      _showWinnerDialog(_marker[0]!);
    } else if (_marker[3] == _marker[4] &&
        _marker[4] == _marker[5] &&
        _marker[5] != null) {
      _showWinnerDialog(_marker[3]!);
    } else if (_marker[6] == _marker[7] &&
        _marker[7] == _marker[8] &&
        _marker[8] != null) {
      _showWinnerDialog(_marker[6]!);
    } else if (_marker[0] == _marker[3] &&
        _marker[3] == _marker[6] &&
        _marker[6] != null) {
      _showWinnerDialog(_marker[0]!);
    } else if (_marker[1] == _marker[4] &&
        _marker[4] == _marker[7] &&
        _marker[7] != null) {
      _showWinnerDialog(_marker[1]!);
    } else if (_marker[2] == _marker[5] &&
        _marker[5] == _marker[8] &&
        _marker[8] != null) {
      _showWinnerDialog(_marker[2]!);
    } else if (_marker[0] == _marker[4] &&
        _marker[4] == _marker[8] &&
        _marker[8] != null) {
      _showWinnerDialog(_marker[0]!);
    } else if (_marker[2] == _marker[4] &&
        _marker[4] == _marker[6] &&
        _marker[6] != null) {
      _showWinnerDialog(_marker[2]!);
    } else if (_moves >= 9) {
      _showDrawDialog();
    }
  }

  void _showWinnerDialog(IconData winner) {
    if (winner == TakTicFont.cancel) {
      setState(() {
        xWins += 1;
      });
    } else {
      setState(() {
        oWins += 1;
      });
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Icon(
                  winner,
                  size: 50,
                ),
                Text("WON"),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    for (int i = 0; i < _marker.length; i++) {
                      setState(() {
                        _marker[i] = null;
                      });
                    }
                    setState(() {
                      _moves = 0;
                    });
                    Navigator.pop(context);
                  },
                  child: Text("PLAY AGAIN", style: TextStyle(color: Colors.white,),),
                  color: Color(0xFFe43a15),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                ),
              ],
            ),
          );
        });
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(
                "MATCH",
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
              Text("DRAW"),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  for (int i = 0; i < _marker.length; i++) {
                    setState(() {
                      _marker[i] = null;
                    });
                  }
                  setState(() {
                    _moves = 0;
                  });
                  Navigator.pop(context);
                },
                child: Text("PLAY AGAIN"),
                color: Colors.grey.shade200,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe43a15),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "SCOREBOARD",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "CIRCLE " + oWins.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: oWins > xWins ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        Text(
                          "CROSS " + xWins.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            color:Colors.white,
                            fontWeight: xWins > oWins ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      Border? border;
                      bool topRow = false;
                      bool bottomRow = false;
                      bool leftCol = false;
                      bool rightCol = false;
                      if (index == 0 || index == 1 || index == 2) {
                        topRow = true;
                      }
                      if (index == 0 || index == 3 || index == 6) {
                        leftCol = true;
                      }
                      if (index == 6 || index == 7 || index == 8) {
                        bottomRow = true;
                      }
                      if (index == 2 || index == 5 || index == 8) {
                        rightCol = true;
                      }
                      border = Border(
                        top: topRow
                            ? BorderSide.none
                            : BorderSide(width: 2.0, color: Colors.white),
                        left: leftCol
                            ? BorderSide.none
                            : BorderSide(width: 2.0, color: Colors.white),
                        right: rightCol
                            ? BorderSide.none
                            : BorderSide(width: 2.0, color: Colors.white),
                        bottom: bottomRow
                            ? BorderSide.none
                            : BorderSide(width: 2.0, color: Colors.white),
                      );
                      return GestureDetector(
                        onTap: () {
                          _setMark(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: border,
                          ),
                          child: Center(
                            child: _marker[index] != null
                                ? Icon(
                                    _marker[index],
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : SizedBox(),
                            // child: Text(
                            //   index.toString(),
                            //   style: TextStyle(fontSize: 40, color: Colors.white),
                            // ),
                          ),
                        ),
                      );
                    }),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      oTurn ? TakTicFont.circle_empty : TakTicFont.cancel,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      "'S TURN",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
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
