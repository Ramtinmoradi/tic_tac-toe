import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTurnO = true;
  List<String> xOrOLists = ['', '', '', '', '', '', '', '', ''];
  int filledBoxes = 0;
  bool gameHasResult = false;
  int scoreX = 0;
  int scoreO = 0;
  String winnerTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              clearGame();
              setState(() {
                scoreO = 0;
                scoreX = 0;
                winnerTitle = '';
                gameHasResult = false;
              });
            },
            icon: Icon(Icons.refresh_outlined),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white,
            ),
          ),
        ],
        title: Text(
          'TicTacToc',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 5.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey[900],
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 20.0),
          _getScoreBoard(),
          SizedBox(height: 40.0),
          _getGridView(),
          SizedBox(height: 60.0),
          _getResultButton(),
          SizedBox(height: 40.0),
          _getTurnOn(),
        ],
      ),
    );
  }

  Widget _getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        onPressed: () {
          setState(() {
            gameHasResult = false;
            clearGame();
          });
        },
        child: Text(
          '$winnerTitle,  Play Again!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _getTurnOn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: TextStyle(
        color: isTurnO == true ? Colors.red : Colors.blue,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void clearGame() {
    setState(() {
      for (int i = 0; i < xOrOLists.length; i++) {
        xOrOLists[i] = '';
      }
      filledBoxes = 0;
    });
  }

  void tapped(int index) {
    setState(() {
      if (gameHasResult) {
        return;
      }
      if (xOrOLists[index] != '') {
        return;
      }
      if (isTurnO) {
        xOrOLists[index] = 'O';
        filledBoxes++;
      } else {
        xOrOLists[index] = 'X';
        filledBoxes++;
      }

      isTurnO = !isTurnO;

      checkWinner();
    });
  }

  void setResult(String winner, String title) {
    setState(() {
      winnerTitle = title;
      gameHasResult = true;

      if (winner == 'X') {
        scoreX++;
      } else if (winner == 'O') {
        scoreO++;
      }
    });
  }

  void checkWinner() {
    if (xOrOLists[0] == xOrOLists[1] &&
        xOrOLists[0] == xOrOLists[2] &&
        xOrOLists[0] != '') {
      setResult(xOrOLists[0], 'Winner is ' + xOrOLists[0]);
      return;
    }
    if (xOrOLists[0] == xOrOLists[4] &&
        xOrOLists[0] == xOrOLists[8] &&
        xOrOLists[0] != '') {
      setResult(xOrOLists[0], 'Winner is ' + xOrOLists[0]);
      return;
    }
    if (xOrOLists[0] == xOrOLists[3] &&
        xOrOLists[0] == xOrOLists[6] &&
        xOrOLists[0] != '') {
      setResult(xOrOLists[0], 'Winner is ' + xOrOLists[0]);
      return;
    }
    if (xOrOLists[1] == xOrOLists[4] &&
        xOrOLists[1] == xOrOLists[7] &&
        xOrOLists[1] != '') {
      setResult(xOrOLists[1], 'Winner is ' + xOrOLists[1]);
      return;
    }
    if (xOrOLists[2] == xOrOLists[4] &&
        xOrOLists[2] == xOrOLists[6] &&
        xOrOLists[2] != '') {
      setResult(xOrOLists[2], 'Winner is ' + xOrOLists[2]);
      return;
    }
    if (xOrOLists[2] == xOrOLists[5] &&
        xOrOLists[2] == xOrOLists[8] &&
        xOrOLists[2] != '') {
      setResult(xOrOLists[2], 'Winner is ' + xOrOLists[2]);
      return;
    }
    if (xOrOLists[3] == xOrOLists[4] &&
        xOrOLists[3] == xOrOLists[5] &&
        xOrOLists[3] != '') {
      setResult(xOrOLists[3], 'Winner is ' + xOrOLists[3]);
      return;
    }
    if (xOrOLists[6] == xOrOLists[7] &&
        xOrOLists[6] == xOrOLists[8] &&
        xOrOLists[6] != '') {
      setResult(xOrOLists[6], 'Winner is ' + xOrOLists[6]);
      return;
    }
    if (filledBoxes == 9) {
      setResult('', 'Equal');
    }
  }

  Widget _getGridView() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 9,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            tapped(index);
          },
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Center(
              child: Text(
                xOrOLists[index],
                style: TextStyle(
                  fontSize: 80.0,
                  color: xOrOLists[index] == 'O' ? Colors.red : Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Player O',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '$scoreO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Player X',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '$scoreX',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
