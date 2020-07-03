import 'package:flutter/material.dart';
import 'dart:math';

import 'package:lco_workout/DelayedAnimation.dart';
import 'package:lco_workout/Screens/ExerciseScreen.dart';

class RandomExerciseScreen extends StatefulWidget {
  @override
  _RandomExerciseScreenState createState() => _RandomExerciseScreenState();
}

class _RandomExerciseScreenState extends State<RandomExerciseScreen> {
  
  bool canStart = false;
  List<Map<String,dynamic>> randomExercises;
  List<Map<String,dynamic>> allExercises = [
    {
      "exerciseName" : "Bycycle crunch",
      "timeRequired" : null,
      "reps" : null,
      "assetImage" : AssetImage("assets/bicycle_crunch.jpeg")
    },
    {
      "exerciseName" : "Bird dog",
      "timeRequired" : null,
      "reps" : null,
      "assetImage" : AssetImage("assets/bird_dog.jpg")
    },
    {
      "exerciseName" : "Bridge",
      "timeRequired" : null,
      "reps" : null,
      "assetImage" : AssetImage("assets/bridge.jpg")
    },
    {
      "exerciseName" : "Donkey kick",
      "timeRequired" : null,
      "reps" : null,
      "assetImage" : AssetImage("assets/donkey_kick.jpg")
    },
    {
      "exerciseName" : "Forearm plank",
      "timeRequired" : null,
      "reps" : null,
      "assetImage" : AssetImage("assets/forearm_plank.jpg")
    },
    {
      "exerciseName" : "Lunges",
      "timeRequired" : null,
      "reps" : null,
      "assetImage" : AssetImage("assets/lunges.png")
    },
    {
      "exerciseName" : "Plank to downward dog",
      "timeRequired" : null,
      "reps" : null,
      "assetImage" : AssetImage("assets/plank_to_downward_dog.jpg")
    },
    {
      "exerciseName" : "Pushup",
      "timeRequired" : null,
      "reps" : null, 
      "assetImage" : AssetImage("assets/pushup.jpg")
    },
    {
      "exerciseName" : "Side lying hip abuction",
      "timeRequired" : null,
      "reps" : null,
      "assetImage" : AssetImage("assets/Side_lying_hip_abduction.jpg")
    }
  ];
  
  List<Map<String,dynamic>> generateRandomExercises(){
    List<int> checkDuplicate = [];
    List<Map<String,dynamic>> randomExercises = [];
    while (randomExercises.length < 5) {
      int rand = Random().nextInt(this.allExercises.length);
      if (!checkDuplicate.contains(rand)) {
        randomExercises.add(this.allExercises[rand]);
      }
      checkDuplicate.add(rand);
    }
    return randomExercises;
  }

  List<Map<String,dynamic>> putBrakesInRandomExercises(List<Map<String,dynamic>> randomExercises){
    Map<String,dynamic> restBreak = {
      "exerciseName" : " Rest break",
      "timeRequired" : 1,
      "reps" : 0,
      "assetImage" : AssetImage("assets/break.jpg")
    };
    List<Map<String,dynamic>> rExercises = [...randomExercises];
    List<Map<String,dynamic>> randomExercisesWithBreaks = [];
    int j = 0;
    for (var i = 0; i < rExercises.length*2; i++) {
      if (i % 2 == 0) {
        randomExercisesWithBreaks.add(rExercises[j]);
      }else{
        randomExercisesWithBreaks.add(restBreak);
        j += 1;
      }
    }
    return randomExercisesWithBreaks;
  }

  bool checkCanStartState(){
    int j;
    for (var i in randomExercises) {
      if (i["reps"] != null && i["timeRequired"] != null) {
        j = 1;
      }else{
        j = 0;
      }
      j *= j;
    }
    if (j == 1) {
      setState(() {
        this.canStart = true;
      });
    } else{
      setState(() {
        this.canStart = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      this.randomExercises = generateRandomExercises();
    });    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 50, 5, 5),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Hey,",style: TextStyle(fontFamily: "Impact",fontSize: 62,),textAlign: TextAlign.left,),
              Text("Get Ready",style: TextStyle(fontFamily: "Impact",fontSize: 78),),
              SizedBox(height: 25,),
              Text(" Random workout", style: TextStyle(fontSize: 16),),
              SizedBox(height: 15,),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: randomExercises.length,
                  itemBuilder: (BuildContext context,int index) {
                    return Container(
                       decoration: new BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: randomExercises[index]["assetImage"]
                        ),
                        borderRadius: new BorderRadius.circular(15)
                      ),
                      margin: EdgeInsets.all(5),
                      width: 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 15, 0, 5),
                                child: Text(randomExercises[index]["exerciseName"],
                                style: TextStyle(
                                  fontFamily: "impact",
                                  color: Colors.black,
                                  fontSize: 25,
                                  ),
                                  ),
                                ),
                                randomExercises[index]["reps"]  == null && randomExercises[index]["timerRequired"] == null 
                                ? Padding(padding: EdgeInsets.all(0))
                                : Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text("${randomExercises[index]["reps"]} Reps\n${randomExercises[index]["timeRequired"]} Mins", 
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                            ],
                          ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: randomExercises[index]["reps"]  == null && randomExercises[index]["timeRequired"] == null
                              ? FlatButton(
                                  onPressed: (){
                                    GlobalKey<FormState> valKey = GlobalKey<FormState>();
                                    return showDialog(context: context,
                                      builder: (BuildContext context){
                                        return Dialog(
                                          child: SingleChildScrollView(
                                              child: Container(
                                              height: 320,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(height: 18,),
                                                  Text(randomExercises[index]["exerciseName"],
                                                    style: TextStyle(
                                                      fontFamily: "impact",
                                                      fontSize: 25
                                                    ),
                                                  ),
                                                  SizedBox(height: 30,),
                                                  Form(
                                                    key: valKey,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 50),
                                                          child: TextFormField(
                                                            validator: (input) {
                                                            if (input.length == 0) { 
                                                                return "Please enter valid reps";
                                                              }
                                                            },
                                                            onChanged: (input){
                                                              setState(() {
                                                                randomExercises[index]["reps"] = input;
                                                              });
                                                            },
                                                            cursorColor: Color.fromRGBO(224, 250, 25, 1),
                                                            keyboardType: TextInputType.number,
                                                            maxLength: 2,
                                                            decoration: InputDecoration(
                                                              focusColor: Color.fromRGBO(224, 250, 25, 1),
                                                              hintText: "Enter no. of reps",
                                                              labelText: "Reps",
                                                              border: OutlineInputBorder()
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 50),
                                                          child: TextFormField(
                                                            validator: (input) {
                                                            if (input.length == 0) { 
                                                                return "Please enter valid duration";
                                                              }
                                                            },
                                                            onChanged: (input){
                                                              setState(() {
                                                                randomExercises[index]["timeRequired"] = input;
                                                                print(randomExercises[index]["timeRequired"]);
                                                              });
                                                            },
                                                            cursorColor: Color.fromRGBO(224, 250, 25, 1),
                                                            keyboardType: TextInputType.number,
                                                            maxLength: 2,
                                                            decoration: InputDecoration(
                                                              focusColor: Color.fromRGBO(224, 250, 25, 1),
                                                              hintText: "Enter time required in mins",
                                                              labelText: "Duration",
                                                              border: OutlineInputBorder()
                                                              
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        RaisedButton(
                                                          elevation: 1.0,
                                                          color: Colors.white,
                                                          child: Text("Set",style: TextStyle(color: Colors.black87),),
                                                          onPressed: (){
                                                             if (valKey.currentState.validate()){
                                                               valKey.currentState.save();
                                                               Navigator.pop(context);
                                                            }
                                                            checkCanStartState();
                                                          }
                                                        )
                                                      ],
                                                    )
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    );
                                  },
                                  child: Text("Set\nReps & duration", 
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                              : FlatButton(
                                  onPressed: (){
                                    GlobalKey<FormState> valKey = GlobalKey<FormState>();
                                    return showDialog(context: context,
                                      builder: (BuildContext context){
                                        return Dialog(
                                          child: SingleChildScrollView(
                                              child: Container(
                                              height: 320,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  SizedBox(height: 18,),
                                                  Text(randomExercises[index]["exerciseName"],
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 25
                                                    ),
                                                  ),
                                                  SizedBox(height: 30,),
                                                  Form(
                                                    key: valKey,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 50),
                                                          child: TextFormField(
                                                            validator: (input){
                                                            if (input.length == 0) { 
                                                                return "Please enter valid reps";
                                                              }
                                                            },
                                                            onChanged: (input){
                                                              setState(() {
                                                                randomExercises[index]["reps"] = input;
                                                              });
                                                            },
                                                            cursorColor: Color.fromRGBO(224, 250, 25, 1),
                                                            keyboardType: TextInputType.number,
                                                            maxLength: 2,
                                                            decoration: InputDecoration(
                                                              focusColor: Color.fromRGBO(224, 250, 25, 1),
                                                              hintText: "Reset : ${randomExercises[index]["reps"]}",
                                                              labelText: "Reps",
                                                              border: OutlineInputBorder()
                                                              
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 50),
                                                          child: TextFormField(
                                                            validator: (input) {
                                                            if (input.length == 0) { 
                                                                return "Please enter valid duration";
                                                              }
                                                            },
                                                            onChanged: (input){
                                                              setState(() {
                                                                randomExercises[index]["timeRequired"] = input;
                                                                print(randomExercises[index]["timeRequired"]);
                                                              });
                                                            },
                                                            cursorColor: Color.fromRGBO(224, 250, 25, 1),
                                                            keyboardType: TextInputType.number,
                                                            maxLength: 2,
                                                            decoration: InputDecoration(
                                                              focusColor: Color.fromRGBO(224, 250, 25, 1),
                                                              hintText: "Reset : ${randomExercises[index]["timeRequired"]}",
                                                              labelText: "Duration",
                                                              border: OutlineInputBorder()
                                                              
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5,),
                                                        RaisedButton(
                                                          elevation: 1.0,
                                                          color: Colors.white,
                                                          child: Text("Reset",style: TextStyle(color: Colors.black87),),
                                                          onPressed: (){
                                                             if (valKey.currentState.validate()){
                                                               valKey.currentState.save();
                                                               Navigator.pop(context);
                                                            }
                                                            checkCanStartState();
                                                          }
                                                        )
                                                      ],
                                                    )
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    );
                                  },
                                  child: Text("Reset\nReps & duration", 
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ),
              ! canStart ? SizedBox(height: 60,)
              : DelayedAnimation(
                delay: 10,
                  child: Padding(
                  padding: EdgeInsets.fromLTRB(180, 10, 10, 10),
                  child:  FlatButton(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10
                ),
                onPressed: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (BuildContext context) => ExerciseScreen(exercises: putBrakesInRandomExercises(randomExercises)))
                  );
                },
                child: Text("Start Exercise",style: TextStyle(fontSize: 20,color:  Colors.amber),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.amber,width: 2)
                ),
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
