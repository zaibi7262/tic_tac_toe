import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initBannerAd();
  }
  late BannerAd bannerAd;
  bool isAdLoaded=false;
  var adUnit= "ca-app-pub-1661934709027267/7409195774";
  initBannerAd(){
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnit,
      listener: BannerAdListener(
        onAdLoaded: (ad){
          setState(() {
            isAdLoaded=true;
          });
        },
        onAdFailedToLoad: (ad,error){
         ad.dispose();
         print(error);
      },
      ),
        request: const AdRequest(),
    );
    bannerAd.load();
  }
  var grid = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  var winner = "";
  var currentplayer = 'X';
  var count=0;
  void drawxo(i){
    if(grid[i] == ''){
      setState(() {
        grid[i] = currentplayer;
        currentplayer = currentplayer == 'X' ? 'O' : 'X';
      });

      findWinner(grid[i]);
    }

  }
  bool checkMove(i1,i2,i3,sign){
    if(grid[i1] == sign && grid[i2] == sign && grid[i3]== sign){
      return true;
    }
    return false;
  }
  void showAwesomeDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          title: Text(
              "Awesome!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Colors.amberAccent,
            ),
          ),
          content: Text(
              message,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(70.0,0,70.0,0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green[400]),
                ),

                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  reset(); // Reset the game after the dialog is closed
                },
                child: Text(
                    "Play Again",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  void findWinner(currentsign) {
    if (
    checkMove(0, 1, 2, currentsign) || checkMove(3, 4, 5, currentsign) ||
        checkMove(6, 7, 8, currentsign) || //rows
        checkMove(0, 3, 6, currentsign) || checkMove(1, 4, 7, currentsign) ||
        checkMove(2, 5, 8, currentsign) || //columns
        checkMove(0, 4, 8, currentsign) ||
        checkMove(2, 4, 6, currentsign) //diagonal

    ) {
      setState(() {
        winner = '$currentsign won the game';
      });
      showAwesomeDialog(winner);
    }
    else if(grid.every((cell) => cell.isNotEmpty)){
      setState(() {
        winner="It's a draw";
      });
      showAwesomeDialog(winner);
    }
  }

  void reset(){
    setState(() {
      winner = "";
      grid = [
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
      ];
    });
  }
  @override
  Widget build(BuildContext context) {
    count++;
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        backgroundColor: Color(0xFF32305B),
        appBar: AppBar(
          title: Text('TicTacToe'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              // if(winner != "")
              //   Text(winner,style: TextStyle(fontSize: 30,color: Colors.amber),),

                Container(
                constraints: BoxConstraints(maxHeight: 400,maxWidth: 400),
                margin: EdgeInsets.all(20),
                // color: Colors.black,
                child: GridView.builder(
                shrinkWrap:true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                itemCount: grid.length,
                itemBuilder: (context, index) => Material(
                color: Colors.red,
                child:
                InkWell(
                      splashColor: Colors.black,
                      onTap: ()=>drawxo(index),
                      child: Center(
                          child: Text(
                            grid[index],
                            style: TextStyle(fontSize: 90),
                          )),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(onPressed: reset, icon:Icon(Icons.refresh), label: Text('Reset'))
            ],
          ),
        ),
        bottomNavigationBar: isAdLoaded
          ? SizedBox(
          height: bannerAd.size.height.toDouble(),
          width: bannerAd.size.height.toDouble(),
          child: AdWidget(ad: bannerAd),
        )
            : SizedBox(),
      ),
    );
  }
}

