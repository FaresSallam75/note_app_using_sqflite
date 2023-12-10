import 'package:flutter/material.dart';
import 'package:sqlflite/sqlflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqlDatabase sqlDatabase = SqlDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () async {
                int response = await sqlDatabase.insertData(
                    "insert into notes ('notes') values ('Note One')  ");
                print("response : $response");
              },
              child: const Text("Insert Data"),
            ),
            MaterialButton(
              color: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () async {
                List<Map> response =
                    await sqlDatabase.readData("select  * from notes ");
                print("response : $response");
              },
              child: const Text("View Data"),
            ),
            MaterialButton(
              color: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () async {
                int response = await sqlDatabase
                    .deleteData("delete from notes where id = 3  ");
                print("response : $response");
              },
              child: const Text("Delete Data"),
            ),
            MaterialButton(
              color: Colors.redAccent,
              textColor: Colors.white,
              onPressed: () async {
                int response = await sqlDatabase.insertData(
                    "update notes set notes = 'Note Two'  where id = 2    ");
                print("response : $response");
              },
              child: const Text("Update Data"),
            )
          ],
        ),
      ),
    );
  }
}
