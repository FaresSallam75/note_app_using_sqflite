import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlflite/addnotes.dart';
import 'package:sqlflite/login.dart';

import 'package:sqlflite/viewnotes.dart';

//SqlDatabase sqlDatabase = SqlDatabase();
SharedPreferences? sharedPreferences;
void main() async {
  //sqlDatabase.db;
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // ignore: prefer_const_constructors
      home: sharedPreferences!.getString("id") != null ? ViewNotes() : SignIn(),
      routes: {
        "addnotes": (context) => const AddNotes(),
        //"editnotes": (context) => const EditNotes() ,
      },
    );
  }
}
