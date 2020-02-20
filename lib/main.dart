import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var q = new Queen();
    q.run();

    print("Start App");
    var cells = <Widget>[];
    for (var row = 0; row < 8; row++) {
      for (var column = 0; column < 8; column++) {
        if (q.board[row][column] == -1) {
          cells.add(
              GestureDetector(
                  onTap:() { q.setQueen(row, column); },
                  child: Container(
                    color: ((row + column) % 2 == 0) ? Colors.black26 : Colors.white,
                    child: getQueen(),
                  )));
        } else {
          cells.add(
              GestureDetector(
                  onTap: () {
                    print('Hi');
                  },
                  child: Container(
                    color: ((row + column) % 2 == 0) ? Colors.black26 : Colors
                        .white,
                  )));
        }
      }
    }
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(title: Text("Something from hell")),
          backgroundColor: Colors.grey,
          body: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisCount: 8,
            children: cells,
          )),
    );
  }
}

Container getQueen() {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      image: DecorationImage(
        image: AssetImage("assets/images/ic_queen_3.png"),
        fit: BoxFit.fill
      )
    ),
  );
}

//logic part
class Queen {
  List<List<int>> board = new List<List<int>>();

  bool tryQueen(int i) {
    bool result = false;
    for (int j = 0; j < 8; j++) {
      if (board[i][j] == 0) {
        setQueen(i, j);
        if (i == 7) {
          result = true;
        } else {
          if (!(result = tryQueen(i + 1))) {
            resetQueen(i, j);
          }
        }
      }
      if (result) {
        break;
      }
    }
    return result;
  }

  void setQueen(int i, int j) {
    for (int x = 0; x < 8; x++) {
      board[x][j]++;
      board[i][x]++;
      int line = j - i + x;
      if (line >= 0 && line < 8) {
        board[x][line]++;
      }
      line = j + i - x;
      if (line >= 0 && line < 8) {
        board[x][line]++;
      }
    }
    board[i][j] = -1;
  }

  void resetQueen(int i, int j) {
    for (int x = 0; x < 8; x++) {
      board[x][j]--;
      board[i][x]--;
      int line = j - i + x;
      if (line >= 0 && line < 8) {
        board[x][line]--;
      }
      line = j + i - x;
      if (line >= 0 && line < 8) {
        board[x][line]--;
      }
    }
    board[i][j] = 0;
  }

  void run() {
    for (int i = 0; i < 8; i++) {
      board.add(List());
      for (int j = 0; j < 8; j++) {
        board[i].add(0);
      }
    }
    tryQueen(0);
    for (int i = 0; i < 8; i++) {
      var line = "";
      for (int j = 0; j < 8; j++) {
        if (board[i][j] == -1) {
          line += "Q";
        } else {
          line += ".";
        }
      }
      print(line);
    }
  }

}