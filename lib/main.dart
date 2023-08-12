import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'home.dart';
void main() async{
  // var devices=["FE69C402B4EC24CDE1350277BE05B465"];
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  // RequestConfiguration requestConfiguration=RequestConfiguration(testDeviceIds: devices);
  // MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  runApp(firstScreen());
}
class firstScreen extends StatelessWidget {
  const firstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF32305B),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF32305B),
          title: Text(
            'TicTacToe',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body:  Padding(
          padding: const EdgeInsets.fromLTRB(120.0,0,0,0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyApp()
                      )
                  );
                },
                child: Text(
                  'Start Game',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(150, 60),
                ),
              ),
            ],
          ),
        )
    );
  }
}
