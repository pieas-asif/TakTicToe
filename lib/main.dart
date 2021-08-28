import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tak Tic Toe',
      theme: ThemeData(
        primarySwatch: Colors.grey,
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
          _marker[index] = Icons.circle_outlined;
        } else {
          _marker[index] = Icons.clear;
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
    if (winner == Icons.clear) {
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
                  child: Text("PLAY AGAIN"),
                  color: Colors.grey.shade200,
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
      backgroundColor: Colors.grey.shade800,
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
                        fontSize: 28,
                        color: Colors.white,
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
                            color: oWins == xWins
                                ? Colors.grey
                                : xWins > oWins
                                    ? Colors.red
                                    : Colors.green,
                          ),
                        ),
                        Text(
                          "CROSS " + xWins.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            color: oWins == xWins
                                ? Colors.grey
                                : oWins > xWins
                                    ? Colors.red
                                    : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _setMark(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: _marker[index] == null
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade600),
                            color: _marker[index] == null
                                ? Colors.transparent
                                : Colors.grey.shade700,
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
                      oTurn ? Icons.circle_outlined : Icons.clear,
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
