import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tensorflow_lite_flutter/tensorflow_lite_flutter.dart';

import 'main.dart';

class EmotionDetector extends StatefulWidget {
  const EmotionDetector({super.key});

  @override
  State<EmotionDetector> createState() => _FirstState();
}

class _FirstState extends State<EmotionDetector> {
  CameraController? cameraController;
  String output = '';
  double per = 0.0;
  int? i;

  LoadCamera() {
    cameraController = CameraController(
      cameras![0],
      ResolutionPreset.high,
    );

    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((image) {
            runModel(image);
          });
        });
      }
    });
  }

  runModel(CameraImage img) async {
    dynamic recognitions = await Tflite.runModelOnFrame(
      bytesList: img.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      // required
      imageHeight: img.height,
      imageWidth: img.width,
      imageMean: 127.5,
      // defaults to 127.5
      imageStd: 127.5,
      // defaults to 127.5
      rotation: 90,
      // defaults to 90, Android only
      numResults: 2,
      // defaults to 5
      threshold: 0.1,
      // defaults to 0.1
      asynch: true, // defaults to true
    );
    for (var element in recognitions) {
      setState(() {
        output = element['label'];
      });

      for (var element in recognitions) {
        setState(() {
          per = element['confidence'];
        });
      }
    }
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadCamera();
    loadModel();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner:
    false;
    return Scaffold(
      backgroundColor: Color.fromRGBO(148, 78, 99, 20),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 231, 231, 20),
        title: Text(
          "Emotion Detector",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: !cameraController!.value.isInitialized
                ? Container()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CameraPreview(cameraController!),
                  ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                output,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 70,
              ),
              CircularPercentIndicator(
                radius: 35.0,
                lineWidth: 4.0,
                percent: per,
                center: Text(
                  "${(per * 100).toInt()}%",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                progressColor: Color.fromRGBO(255, 231, 231, 20),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Don't forget to contact me on social media",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(5),

                  onTap:(){},
                  child:FaIcon(FontAwesomeIcons.instagram,color: Color.fromRGBO(251, 173, 80, 20),size: 35,),


                ),
                InkWell(
                    borderRadius: BorderRadius.circular(5),

                    onTap:(){},
                   child:FaIcon(FontAwesomeIcons.facebook,color: Colors.blueAccent,size: 35,),
                ),
                InkWell(
                    borderRadius: BorderRadius.circular(5),

                    onTap:(){},
                  child:FaIcon(FontAwesomeIcons.whatsapp,color: Colors.green,size: 35,),


                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
