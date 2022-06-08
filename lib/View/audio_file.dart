import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancePlayer;
  const AudioFile({Key? key, required this.advancePlayer}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = Duration();
  Duration _position = Duration();
  final String path = "https://luan.xyz/files/audio/ambient_c_motion.mp3";
  bool isPlaying=false;
  bool isPaused=false;
  bool isLoop = false;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled
  ];
  @override
  void initState(){
    super.initState();
    this.widget.advancePlayer.onDurationChanged.listen((d) {
      setState((){
        _duration = d;
      });
    });
    this.widget.advancePlayer.onAudioPositionChanged.listen((p) {
      setState((){
        _position = p;
      });
    });
    this.widget.advancePlayer.setUrl(path);
  }
  Widget btnStart(){
    return IconButton(
        padding: EdgeInsets.only(bottom: 10),
        onPressed: (){
          if(isPlaying == false){
            this.widget.advancePlayer.play(path);
            setState((){
              isPlaying = true;
            });
          }
          else if(isPlaying == true){
            this.widget.advancePlayer.pause();
            setState((){
              isPlaying = false;
            });
          }

        },
        icon: isPlaying==false ? Icon(_icons[0]) : Icon(_icons[1]));
  }

  Widget loadAsset(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnStart()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            ],
          ),),
          loadAsset(),
        ],
      ),
    );
  }
}
