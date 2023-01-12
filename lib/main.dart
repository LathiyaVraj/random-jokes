import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/api_helper.dart';
import 'models/model.dart';
import 'screens/jokes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  String isSaved = sharedPreferences.getString('isSaved') ?? "";
  await sharedPreferences.setString('isSaved', isSaved);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        'jokes_page': (context) => SavedJokes(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Random_Jokes?> AttachedMyJokes;

  @override
  initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {});
    });
    AttachedMyJokes = JokesApiHelper.jokes_api_helper.attach_Jokes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
        title: const Text(
          'JOKES',
          style: TextStyle(
              letterSpacing: 3,
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences sharedPre =
                    await SharedPreferences.getInstance();

                await sharedPre.setString('savedJokes', "");

                Navigator.of(context).pushNamed('allJokes');
              },
              icon: const Icon(
                Icons.list,
                color: Colors.green,
                size: 30,
              )),
        ],
        centerTitle: true,
      ),
      body: Container(
        color: Colors.greenAccent,
        height: double.infinity,
        child: FutureBuilder(
          future: AttachedMyJokes,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error : ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              Random_Jokes data = snapshot.data as Random_Jokes;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 70,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.yellowAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const SizedBox(width: 20),
                            const Text(
                              "LAUNCH DATE :  ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              data.launchDate,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            AttachedMyJokes =
                                JokesApiHelper.jokes_api_helper.attach_Jokes();
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "FETCH MY LAUGH",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.green.shade900,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.black,
                                  offset: Offset(6, 6),
                                ),
                              ]),
                          width: 200,
                          height: 70,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        padding: EdgeInsets.all(5),
                        height: 60,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.yellowAccent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const SizedBox(width: 15),
                            const Text(
                              "EDITED DATE :  ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              data.editedDate,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.green.shade900,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            data.myJokes,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.network(
                          "https://images.vexels.com/media/users/3/158191/isolated/lists/c51f6f5a5ef8b2c2fbd65c082111ccaf-simple-crying-laughing-emoticon-face.png",
                          height: 180),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                  child: Stack(
                alignment: Alignment.center,
                children: const [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ],
              ));
            }
          },
        ),
      ),
    );
  }
}
