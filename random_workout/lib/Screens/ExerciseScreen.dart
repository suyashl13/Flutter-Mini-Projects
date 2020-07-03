import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lco_workout/DelayedAnimation.dart';

class ExerciseScreen extends StatefulWidget {
  
  List<Map<String,dynamic>> exercises;

  ExerciseScreen(
    {
      @required
      this.exercises
    }
  );

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState(this.exercises);
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  List<Map<String,dynamic>> exercises;
  _ExerciseScreenState(this.exercises);
  Timer _timer;
  int currentPageExercise = 0;
  double exerciseProgress = 0.00;
  PageController _pageController;
  int ticker = 0;
  bool isPlaying = false;
  List<int> timeIntervals;
  
  var audioFilePath;
  AudioPlayer _audioPlayer;
  AudioCache _audioCache;
  Duration _duration = Duration();
  Duration _position = Duration();

  void initPlayer(){
    _audioPlayer = AudioPlayer();
    _audioCache = AudioCache(fixedPlayer: _audioPlayer);

    _audioPlayer.durationHandler = (d){
      setState(() {
        _duration = d;
      });
    };

    _audioPlayer.positionHandler = (p){
      setState(() {
        _position = p;
      });
    };
  }

   Widget slider() {
    return Slider(
        activeColor: Colors.amber,
        inactiveColor: Colors.black26,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        label: 'max',
        onChanged: (double value) { print('Slider Value - ');
          print(value);
          setState(() {
            seekToSeconds(value.toInt());
            value = value;
            if (value <=  _duration.inSeconds.toDouble() -20) {
              _audioPlayer.stop();
            }
          });
        });
  }

  List<int> getExerciseDurations(){
    List<String> timeIntervalStringList = [];
    for (var exercise in exercises) {
      var i = exercise["timeRequired"];
      timeIntervalStringList.add(i.toString());
    }
    return timeIntervalStringList.map(int.parse).toList();
  }

  List<int> exerciseDurationAdjust(int multiplier){
    List<int> durations = getExerciseDurations();
    List<int> modifiedDurations = [];
    for (var duration in durations) {
      modifiedDurations.add(duration * multiplier);
    }
    return modifiedDurations;
  }

  void conductExercise(Timer timer) {
    List<int> durations = exerciseDurationAdjust(300);
    double progress;
    if (ticker == durations[currentPageExercise]) {
      setState(() {
        _pageController.jumpToPage(currentPageExercise + 1);
        ticker = 0;
        exerciseProgress = 0.00;
      });
    }
    setState(() {
      progress = (ticker / durations[currentPageExercise] * 100) / 100;
      exerciseProgress = progress;
    });
  }

  void runExercise(){
      if (_timer != null) {
      _timer.cancel();
    }
    setState(() {
      isPlaying = true;
    });
    try {
      _timer = Timer.periodic(Duration(milliseconds: 200), (timer){
      setState(() {
        ticker++;
        conductExercise(timer);
        if (currentPageExercise == 9) {
          timer.cancel();
          _timer.cancel();
          _pageController.dispose();
        }
      });
    });
    } catch (e) {
      _timer.cancel();
    }
    
  }

  @override
  void initState() {
    super.initState();
    this.initPlayer();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8
    );


    _pageController.addListener(() {
      int next = _pageController.page.round();

      if (currentPageExercise != next) {
        setState(() {
          currentPageExercise = next;
        });
      }
    });

  }

  Widget pageView(){
    return IgnorePointer(
      ignoringSemantics: true,
      ignoring: true,
        child: PageView.builder(
        controller: _pageController,
        itemCount: exercises.length,
        itemBuilder: (BuildContext context, int index ){
          bool active = index == currentPageExercise;
          return _buildExercisePage(exercises[index], active);
        },
      ),
    );
  }

  _buildExercisePage(Map data,bool active){
    final double blur =   active ? 30 : 0;  
    final double offset = active ? 20 : 0;  
    final double top =    active ? 90 : 112;

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top : top, bottom: 50, right: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: blur, offset: Offset(offset,offset))],
        image: DecorationImage(
          fit: BoxFit.scaleDown,  
          image: data["assetImage"] 
        )
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 0, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            active 
            ? DelayedAnimation(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(data["exerciseName"],
                  style: TextStyle(
                    fontFamily: "impact",
                    color: Colors.black,
                    fontSize: 35),
                    ),
                    Text("\n${data["reps"]} Reps\n${data["timeRequired"]} Mins", 
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
            ) : Padding(padding: EdgeInsets.zero) ,
            active  
            ? DelayedAnimation(
                child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 25),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.black12,
                    value: exerciseProgress,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber,),
                  ),
                )
              ),
            ) : Padding(padding: EdgeInsets.zero)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void seekToSeconds(int s){
    Duration newDuration = Duration(seconds: s);
    _audioPlayer.seek(newDuration);
  }

  Future<bool> _onBackPressed() {
  return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Are you sure?'),
      content: new Text('Do you want to exit exercise'),
      actions: <Widget>[
        new GestureDetector(
          onTap: () => Navigator.of(context).pop(false),
          child: Text("NO"),
        ),
        SizedBox(height: 16),
        new GestureDetector(
          onTap: () { 
              setState(() {
                try {
                  _timer.cancel();
                } catch (e) {
                }
                ticker = 0;
                try {
                  _audioPlayer.stop();                  
                } catch (e) {
                }

              });
            Navigator.of(context).pop(true);
          },
          child: Text("YES"),
        ),
      ],
    ),
  ) ??
      false;
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
          child: SafeArea(
          child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Expanded(child: pageView()),
                    // SizedBox(height: 0,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 15),
                          child: FlatButton.icon(
                            icon: Icon(Icons.stop),
                            onPressed: isPlaying ? (){
                            setState(() {
                              isPlaying = false;
                              _timer.cancel();
                              ticker = 0;
                              exerciseProgress = 0.00;
                              _pageController.jumpTo(0);
                            });
                          } : (){},
                          label: Text("Stop"),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 15),
                          child: FlatButton.icon(onPressed: !isPlaying ? runExercise :(){},
                            icon : Icon(Icons.play_arrow),
                            label: Text("Start / Play"),
                          ),
                        ),
                        Padding(padding: EdgeInsets.fromLTRB(0, 0, 30, 15),
                          child: FlatButton.icon(
                            onPressed:  (){
                              // Perform pause
                                setState(() {
                                  _timer.cancel();
                                  ticker = 0;
                                  exerciseProgress = 0.00;
                                  isPlaying = false;
                                });
                             },
                            icon: Icon(Icons.pause),
                            label: Text("Pause"),
                          ),
                        ),
                      ],
                      ),
                    ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                minChildSize: 0.1,
                maxChildSize: 0.6,
                initialChildSize: 0.1,
                builder: (context, _scrollController) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                  )
                ),
                child: ListView(
                  controller: _scrollController,
                  children: <Widget>[
                    SizedBox(height: 5,),
                    Center(child: Icon(Icons.keyboard_arrow_up,size: 25,color: Colors.black,),),
                    Center(
                      child: Text("Settings\n",style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 16),),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left : 10,top: 10,bottom: 2),
                            child: Text("Music Settings",style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 26)),
                          ),
                          ListTile(
                            leading: Icon(Icons.queue_music ,color: Colors.black,),
                            title: Text("Select custom music",style: TextStyle(color: Colors.black,fontSize: 16)),
                            onTap: () async {
                              try {
                                var audPath = await FilePicker.getFilePath(type: FileType.audio);
                                setState(() {
                                  audioFilePath = audPath;
                                });
                              } catch (e) {
                                print("Unable to audio load file path");
                              }
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.music_note, color: Colors.black,),
                            title: audioFilePath == null ? IgnorePointer(
                                child: Slider(
                                inactiveColor: Colors.black38,
                                activeColor: Colors.amber,
                                max: _duration.inSeconds.toDouble(),
                                value: _position.inSeconds.toDouble(),
                                min: 0.0,
                                onChanged: (i)  {
                                  setState(()  {
                                    seekToSeconds(i.toInt());
                                    i = i;
                                  });
                                },
                              ),
                            )
                            : slider()
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RaisedButton.icon(
                                  icon: Icon(Icons.pause),
                                  label: Text("Pause"),
                                  onPressed: (){
                                    try {
                                      _audioPlayer.pause();
                                    } catch (e) {
                                      print("Error in pausing audio");
                                    }
                                  },
                                  color: Colors.amber,
                                  elevation: 0,
                                  disabledElevation: 0,
                                  highlightElevation: 0.1,
                                ),
                                RaisedButton.icon(
                                  elevation: 0,
                                  disabledElevation: 0,
                                  highlightElevation: 0.1,
                                  icon: Icon(Icons.play_arrow),
                                  label: Text("play"),
                                  onPressed: (){
                                    try {
                                      _audioPlayer.play(audioFilePath, isLocal:  true);
                                    } catch (e) {
                                      print("Err in playing");
                                    }
                                    
                                  },
                                  color: Colors.amber,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left : 10,top: 10,bottom: 22),
                            child: Text("Workout Settings",style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black,fontSize: 26)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RaisedButton.icon(
                                  icon: Icon(Icons.skip_next),
                                  label: Text("Skip"),
                                  onPressed: isPlaying ? (){
                                    setState(() {
                                      ticker = 0;
                                      exerciseProgress = 0.00;
                                      _pageController.jumpToPage(currentPageExercise + 1);
                                    });
                                  }: (){},
                                  color: Colors.amber,
                                  elevation: 0,
                                  disabledElevation: 0,
                                  highlightElevation: 0.1,
                                ),
                                RaisedButton.icon(
                                  icon: Icon(Icons.skip_previous),
                                  label: Text("Last exercise"),
                                  onPressed: isPlaying ? (){
                                    setState(() {
                                      ticker = 0;
                                      exerciseProgress = 0.00;
                                      _pageController.jumpToPage(currentPageExercise - 1);
                                    });
                                  }: (){},
                                  color: Colors.amber,
                                  elevation: 0,
                                  disabledElevation: 0,
                                  highlightElevation: 0.1,
                                ),
                                RaisedButton.icon(
                                  elevation: 0,
                                  disabledElevation: 0,
                                  highlightElevation: 0.1,
                                  icon: Icon(Icons.home),
                                  label: Text("Quit"),
                                  onPressed: (){
                                    setState(() {
                                      ticker = 0;
                                      currentPageExercise = 0;
                                      exerciseProgress = 0;
                                      _timer.cancel();
                                    });
                                  },
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ))
            ],
          ),
        ),
      ),
    );
  }
}