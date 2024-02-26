import 'package:emotions/EmotionDetector.dart';
import 'package:flutter/material.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _Splach_screenState();
}

class _Splach_screenState extends State<SplachScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Navigator.push(context, MaterialPageRoute(builder: (context) => EmotionDetector(),),);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(180, 123, 132, 20),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Emotion Detector",style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("powerd by Sondos Khaled",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),),
            ),

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                backgroundColor:Colors.grey,
                 color: Color.fromRGBO(255, 231, 231, 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
