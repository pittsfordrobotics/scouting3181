// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// TODO: 2023 Release - Radio Buttons
// TODO: now - checkbox
//  TODO: Pit and match routes,
// TODO: NO ; in text fields ; ;; ; ; ;; ; ; ; ;; ; ; ;

String code = "";

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => StartingRoute(),
      '/PIT': (context) => PitRoute(),
      '/MATCH': (context) => MatchRoute(),
      '/QR': (context) => QRPage(),
    },
  ));
}

class BetterString {
  String string;
  BetterString(this.string);
}
class BetterList {
  List list;
  BetterList(this.list);
}

class StartingRoute extends StatelessWidget {
  BetterString scouterName = BetterString("");
  BetterString teamNumber = BetterString("");
  BetterString pitOrMatch = BetterString("Choose");

  final formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  StartingRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
        child: MaterialApp(
        title: "3181 Scouting 2022",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("3181 Scouting 2022"),
            ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10,20,0,0),
            child: Form(
              key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BetterTextField("Enter your name: ", scouterName),
                        BetterTextField("Scouted team number: ", teamNumber),
                        BetterDropdownButton("Scouting Type", const ["Choose", "Pit", "Match"], pitOrMatch),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (formKey.currentState!.validate()) {
                                if (teamNumber.string != "3181") {
                                  if (pitOrMatch.string == "Choose") {}
                                  else if (pitOrMatch.string == "Pit") {
                                    code = scouterName.string + ";" +
                                        teamNumber.string + ";" +
                                        pitOrMatch.string + ";";
                                    Navigator.pushNamed(context, '/PIT');
                                  }
                                  else if (pitOrMatch.string == "Match") {
                                    code = scouterName.string + ";" +
                                        teamNumber.string + ";" +
                                        pitOrMatch.string + ";";
                                    Navigator.pushNamed(context, '/MATCH');
                                  }
                                }
                              }
                            },
                            child: const Text('Next Page'),
                           ),
                        )
                      ],
                      ),
              ),
            ),
            ),
        ),
        ),
    );
  }
}
class PitRoute extends StatelessWidget {
  BetterList shooterType = BetterList([false, false]);
  BetterString driveTrain = BetterString("No Drive");
  BetterString climbPosition = BetterString("No Climb");
  BetterString autoBalls = BetterString("0");
  BetterList autoPositions = BetterList([false, false, false, false, false]);
  BetterString strategy = BetterString("No");
  BetterString comments = BetterString("");

  final formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  PitRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pit Scouting',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pit Scouting'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    BetterDropdownButton("Drive Train", const ["No Drive", "Swerve", "West Coast (6 or 8 wheel tank)", "Mecanum", "Omni"], driveTrain),
                    BetterText("Shooter Type"),
                    BetterCheckboxListTile("High Shooter", shooterType, 0),
                    BetterCheckboxListTile("Low Shooter", shooterType, 1),
                    BetterDropdownButton("Climb Position", const ["No Climb", "Low", "Mid", "High", "Traversal"], climbPosition),
                    BetterDropdownButton("Number of Balls in Auto", const ["0", "1", "2", "3", "4", "5", "> 5"], autoBalls),
                    BetterText("Auto Starting Position"),
                    Image.asset('assets/Field.png'),
                    BetterCheckboxListTile("Position 1", autoPositions, 0),
                    BetterCheckboxListTile("Position 2", autoPositions, 1),
                    BetterCheckboxListTile("Position 3", autoPositions, 2),
                    BetterCheckboxListTile("Position 4", autoPositions, 3),
                    BetterCheckboxListTile("Position 5", autoPositions, 4),
                    BetterDropdownButton("Do they want to defend", const ["No", "Yes"], strategy),
                    BetterTextField("Any extra comments?", comments),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (formKey.currentState!.validate()) {
                            code += driveTrain.string + ";" + (shooterType.list[0] == true ? "High" : "") + (shooterType.list[1] == true ? "Low" : "") + ";" + climbPosition.string + ";" +  autoBalls.string + ";" + (autoPositions.list[0] == true ? "1" : "") + (autoPositions.list[1] == true ? "2" : "") + (autoPositions.list[2] == true ? "3" : "") + (autoPositions.list[3] == true ? "4" : "") + (autoPositions.list[4] == true ? "5" : "") + ";" + strategy.string + ";" + comments.string;
                            Navigator.pushNamed(context, '/QR');
                          }
                        },
                        child: const Text('Next Page'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          code = "";
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text('Previous Page'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    ),
      ),
    );
  }
}
//TODO: make custom incrementer for counting balls scored
class MatchRoute extends StatelessWidget {
  BetterList autoPositions = BetterList([false, false, false, false, false]);
  BetterString taxi = BetterString("No");
  BetterString attemptedAutoBalls = BetterString("0");
  BetterString scoredAutoBalls = BetterString("0");
  BetterString scoredTeleopBalls = BetterString("0");
  BetterString attemptedClimbPosition = BetterString("No Attempt");
  BetterString successfulClimbPosition = BetterString("No Climb");
  BetterString comments = BetterString("");

  final formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  MatchRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match Scouting',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Match Scouting'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
           child: Form(
            key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BetterText("Auto Starting Position"),
                    Image.asset('assets/Field.png'),
                    BetterCheckboxListTile("Position 1", autoPositions, 0),
                    BetterCheckboxListTile("Position 2", autoPositions, 1),
                    BetterCheckboxListTile("Position 3", autoPositions, 2),
                    BetterCheckboxListTile("Position 4", autoPositions, 3),
                    BetterCheckboxListTile("Position 5", autoPositions, 4),
                    BetterDropdownButton("Did they leave the tarmac?", const ["No", "Yes"], taxi),
                    BetterDropdownButton("Number of Balls Attempted in Auto", const ["0", "1", "2", "3", "4", "5", ">5"], attemptedAutoBalls),
                    BetterDropdownButton("Number of Balls Scored in Auto", const ["0", "1", "2", "3", "4", "5", ">5"], scoredAutoBalls),
                    BetterTextField("Number of Balls Scored in Teleop", scoredTeleopBalls),
                    BetterDropdownButton("Attempted Climb Position", const ["No Attempt", "Low", "Mid", "High", "Traversal"], attemptedClimbPosition),
                    BetterDropdownButton("Successful Climb Position", const ["No Climb", "Low", "Mid", "High", "Traversal"], successfulClimbPosition),
                    BetterTextField("Any extra comments?", comments),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (formKey.currentState!.validate()) {
                            code +=  ";;;;;;;" + (autoPositions.list[0] == true ? "1" : "") + (autoPositions.list[1] == true ? "2" : "") + (autoPositions.list[2] == true ? "3" : "") + (autoPositions.list[3] == true ? "4" : "") + (autoPositions.list[4] == true ? "5" : "") + ";" + taxi.string + ";" + attemptedAutoBalls.string + ";" + scoredAutoBalls.string + ";" + scoredTeleopBalls.string + ";" + attemptedClimbPosition.string + ";" + successfulClimbPosition.string + ";" + comments.string;
                            Navigator.pushNamed(context, '/QR');
                          }
                        },
                        child: const Text('Next Page'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          code = "";
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text('Previous Page'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    ),
      ),
    );
  }
}
class QRPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3181 Scouting 2022',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('3181 Scouting 2022'),
        ),
        body: Center(
          child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,100,0,0),
            child: Column(
              children: [
                QrImage(
                  data: code,
                  version: QrVersions.auto,
                  size: 350,

                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,50,0,0),
                child: ElevatedButton(onPressed: () {
                  showAlert(context, "Warning!", "Are you sure you want to restart?",  "/");
                  code = "";
                },
                    child: const Text('Restart'))
              )
              ],
          ),
          ),
        ),
    ),
      ),
    );
  }
}

class BetterDropdownButton extends StatefulWidget {
  String prompt;
  List<String> items;
  BetterString variable;

  BetterDropdownButton(this.prompt, this.items, this.variable);

  @override
  BetterDropdownButtonState createState() => BetterDropdownButtonState(prompt, items, variable);
}
// class BetterRadio extends StatefulWidget {
//   String prompt;
//   List<String> items;
//   BetterString variable;
//
//   BetterRadio(this.prompt, this.items, this.variable);
//
//   @override
//   BetterRadioState createState() => BetterRadioState(prompt, items, variable);
// }
class BetterCheckboxListTile extends StatefulWidget {
  var prompt;
  var variable;
  var number;

  BetterCheckboxListTile(this.prompt, this.variable, this.number);

  @override
  BetterCheckboxListTileState createState() => BetterCheckboxListTileState(prompt, variable, number);
}

class BetterText extends StatelessWidget {
  final prompt;

  BetterText(this.prompt);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(prompt,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
        ]
    );
  }
}
class BetterTextField extends StatelessWidget {
  final prompt;
  var variable;

  BetterTextField(this.prompt, this.variable);

  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
    Align(
        alignment: Alignment.centerLeft,
        child: Text(prompt,
          style: TextStyle(fontSize: 25),
        ),
      ),
    SizedBox(
      width: 300,
      height: 100,
      child: TextFormField(
        textAlign: TextAlign.center,
        minLines: 1,
        maxLines: 1,
        style: const TextStyle(fontSize: 25),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return prompt;
          }
        },
        onChanged: (text) {
          variable.string = text; },
      ),
    )
    ]
    );
  }
}
class BetterDropdownButtonState extends State {
  String prompt;
  List<String> items;
  BetterString variable;

  BetterDropdownButtonState(this.prompt, this.items, this.variable);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(prompt,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: SizedBox(
            width: 300,
            child: DropdownButton(
              isExpanded: true,
              itemHeight: 50,
              value: variable.string,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20
              ),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  variable.string = newValue!;
                });
              },
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );}).toList(),
            )
          )
          )
        ]
      ),
    );
  }
}
// class BetterRadioState extends State {
//   String prompt;
//   var items;
//   BetterString variable;
//
//   BetterRadioState(this.prompt, this.items, this.variable);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(prompt,
//               style: TextStyle(fontSize: 25),
//             ),
//           ),
//
//         ]
//     );
//   }
// }
class BetterCheckboxListTileState extends State {
  String prompt;
  BetterList variable;
  int number;

  BetterCheckboxListTileState(this.prompt, this.variable, this.number);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                  width: 300,
                   child: CheckboxListTile(
                    title: Text(prompt),
                    value: variable.list[number],
                    onChanged: (bool? newValue) {
                      setState(() {
                        variable.list[number] = newValue!;
                      });
                    },
                  ) // child:
              )
          )
        ]
    );
  }
}

showAlert(BuildContext context, String title, String prompt, String nextLocation) {
  // set up the button
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed:  () {
      Navigator.pushNamed(context, nextLocation);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(prompt),
    actions: [
      cancelButton,
      continueButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}