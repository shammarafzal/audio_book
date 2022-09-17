import 'package:audio_book/View/audio_file.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:audio_book/Constants/app_colors.dart' as AppColors;

class DetailAudioPage extends StatefulWidget {
  final booksData;
  final int index;
  const DetailAudioPage({Key? key, required this.booksData, required this.index}) : super(key: key);

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer advancePlayer;
  @override
  void initState(){
    super.initState();
    advancePlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight / 3,
                color: AppColors.audioBlueBackground,
          )),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: (){
                    Navigator.of(context).pop();
                    advancePlayer.dispose();
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: (){},
                  ),
                ],
          )),
          Positioned(
              top: screenHeight * 0.2,
              left: 0,
              right: 0,
              height: screenHeight * 0.36,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,

                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight*0.1,
                    ),
                    Text(this.widget.booksData[this.widget.index]["title"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: "Avenir"),),
                    Text(this.widget.booksData[this.widget.index]["text"], style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, fontFamily: "Avenir"),),
                    AudioFile(
                      advancePlayer: advancePlayer,
                      audioPath: this.widget.booksData[this.widget.index]["audio"],
                    ),
                  ],
                ),
              )),
          Positioned(
              top: screenHeight * 0.12,
              left: (screenWidth - 150) / 2,
              right: (screenWidth - 150) / 2,
              height: screenHeight * 0.16,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                  color: AppColors.audioGreyBackground
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            this.widget.booksData[this.widget.index]["img"]
                        )
                      )
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
