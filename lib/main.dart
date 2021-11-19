import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> languages = [
    'English',
    'Urdu',
    'Punjabi',
    'Chinese',
    'Latin',
    'Dutch',
    'Japanese',
    'Korean',
    'Pashto',
    'Sindhi',
    'Telugu',
    'Tamil'
  ];

  bool _checked = true;
  bool allLanguages = false;

  List<String> selectedLanguages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setLanguages();
  }

  setLanguages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      selectedLanguages = (prefs.getStringList('selectedLanguages'))!;
    });

    if(selectedLanguages.length > 0) {
      for (int i = 0; i < selectedLanguages.length; i++) {
        setState(() {
          languages.remove(selectedLanguages[i]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select your languages'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
            children: [

              selectedLanguages.length > 0 ? Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Selected Languages',
                  style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
              ) : Container(),

              Expanded(
                flex: selectedLanguages.length == 0 ? 0 : selectedLanguages.length == 1 || selectedLanguages.length == 2 ? 1 : 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                      itemCount: selectedLanguages.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 70.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text(
                                  selectedLanguages[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0
                                  ),
                                ),

                                Checkbox(
                                    value: _checked,
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                    fillColor: MaterialStateProperty.all<Color>(Colors.white),
                                    onChanged: (bool? value) async {

                                      setState(() {
                                        languages.add(selectedLanguages[index]);
                                        selectedLanguages.removeAt(index);
                                      });

                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      await prefs.setStringList('selectedLanguages', selectedLanguages);

                                      // if(value != null) {
                                      //   setState(() {
                                      //     _checked = value;
                                      //   });
                                      // }

                                    }
                                ),

                              ],
                            )
                          );
                      },
                    ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  'All Languages',
                  style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
              ),

              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: languages.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 70.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text(
                                  languages[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0
                                  ),
                                ),

                                Checkbox(
                                    value: allLanguages,
                                    activeColor: Colors.white,
                                    checkColor: Colors.black,
                                    fillColor: MaterialStateProperty.all<Color>(Colors.white),
                                    onChanged: (bool? value) async {

                                      if(selectedLanguages.length != 3) {
                                        setState(() {
                                          selectedLanguages.add(
                                              languages[index]);
                                          languages.removeAt(index);
                                        });

                                        SharedPreferences prefs = await SharedPreferences
                                            .getInstance();
                                        await prefs.setStringList(
                                            'selectedLanguages',
                                            selectedLanguages);
                                      }
                                    }
                                ),

                              ],
                            )
                        );
                    },
                  ),
                ),
              ),

            ],
          ),
      ),
    );
  }
}
