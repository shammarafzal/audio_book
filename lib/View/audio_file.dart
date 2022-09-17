import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancePlayer;
  final String audioPath;
  const AudioFile({Key? key, required this.advancePlayer, required this.audioPath}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = Duration();
  Duration _position = Duration();
  // final String path = "https://luan.xyz/files/audio/ambient_c_motion.mp3";
  bool isPlaying=false;
  bool isPaused=false;
  bool isRepeat = false;
  Color color = Colors.black;
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
    this.widget.advancePlayer.setUrl(this.widget.audioPath);
    this.widget.advancePlayer.onPlayerCompletion.listen((event) {
      setState((){
        _position = Duration(seconds: 0);
        if(isRepeat==true){
          isPlaying = true;
        }
        else{
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }
  @override
  void dispose(){
    super.dispose();
    // this.widget.advancePlayer.dispose();
  }
  Widget btnStart(){
    return IconButton(
        padding: EdgeInsets.only(bottom: 10),
        onPressed: (){
          if(isPlaying == false){
            this.widget.advancePlayer.play(this.widget.audioPath);
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
        icon: isPlaying==false ? Icon(_icons[0], size: 50, color: Colors.blue,) : Icon(_icons[1], size: 50, color: Colors.blue));
  }
  Widget btnFast(){
    return IconButton(
        onPressed: (){
          this.widget.advancePlayer.setPlaybackRate(1.5);
        },
        icon: ImageIcon(
          AssetImage(
              'assets/img/forward.png'
          ),
          size: 15,
        )
    );
  }
  Widget btnSlow(){
    return IconButton(
        onPressed: (){
          this.widget.advancePlayer.setPlaybackRate(0.5);
        },
        icon: ImageIcon(
          AssetImage(
              'assets/img/backward.png'
          ),
          size: 15,
        )
    );
  }

  Widget btnRepeat(){
    return IconButton(
        onPressed: (){
            if(isRepeat==false){
              this.widget.advancePlayer.setReleaseMode(ReleaseMode.LOOP);
              setState((){
                isRepeat= true;
                color = Colors.blue;
              });
            }
            else if(isRepeat==true){
              this.widget.advancePlayer.setReleaseMode(ReleaseMode.RELEASE);
              setState((){
                isRepeat= false;
                color = Colors.black;
              });
            }

        },
        icon: ImageIcon(
          AssetImage(
              'assets/img/repeat.png'
          ),
          size: 25,
          color: color,
        )
    );
  }
  Widget btnLoop(){
    return IconButton(
        onPressed: (){

        },
        icon: ImageIcon(
          AssetImage(
              'assets/img/loop.png'
          ),
          size: 40,

        )
    );
  }
  
  Widget loadAsset(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ],
      ),
    );
  }

  Widget slider(){
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value){
        setState((){
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }

void changeToSecond(int second){
    Duration newDuration =  Duration(seconds: second);
    this.widget.advancePlayer.seek(newDuration);
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
                  Text(_position.toString().split(".")[0].split(":")[1]+":"+_position.toString().split(".")[0].split(":")[2], style: TextStyle(fontSize: 16),),
                  Text(_duration.toString().split(".")[0].split(":")[1]+":"+_duration.toString().split(".")[0].split(":")[2], style: TextStyle(fontSize: 16),),
            ],
          ),),
          slider(),
          loadAsset(),
        ],
      ),
    );
  }
}
