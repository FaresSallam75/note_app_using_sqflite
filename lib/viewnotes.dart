import 'package:flutter/material.dart';
import 'package:sqlflite/editnotes.dart';
import 'package:sqlflite/login.dart';
import 'package:sqlflite/main.dart';
import 'package:sqlflite/sqlflite.dart';

class ViewNotes extends StatefulWidget {
  const ViewNotes({super.key});

  @override
  State<ViewNotes> createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  SqlDatabase sqlDatabase = SqlDatabase();
  List listNotes = [];
  bool isLoading = true;

  Future getAllData() async {
    //List<Map> response = await sqlDatabase.readData("select  * from notes ");
    List<Map> response = await sqlDatabase.read("notes");
    listNotes.addAll(response);
    isLoading = false;
    // ignore: unnecessary_this
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "View Notes",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () async {
                await sharedPreferences!.clear();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const SignIn()),
                    (route) => false);
              },
              icon: const Icon(
                Icons.exit_to_app_outlined,
                color: Colors.white,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.redAccent,
              ),
            )
          : Container(
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  /* MaterialButton(
              onPressed: () async {
                await sqlDatabase.deleteAllDataBase();
              },
              child: const Text("Delete Database"),
            ), */

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listNotes.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            // ignore: prefer_const_constructors
                            builder: (context) => EditNotes(
                              title: listNotes[index]['title'],
                              note: listNotes[index]['notes'],
                              color: listNotes[index]['color'],
                              noteId: listNotes[index]['id'].toString(),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Dismissible(
                          key: ValueKey(listNotes[index]['id']),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) async {
                            int response = await sqlDatabase.delete(
                                "notes", "id =  ${listNotes[index]['id']}");
                            print("response : ====== $response");
                            if (response > 0) {
                              // ignore: use_build_context_synchronously
                              listNotes.removeWhere((element) =>
                                  element["id"] == listNotes[index]['id']);
                              setState(() {});
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  child: Image.asset(
                                "assets/note.png",
                                color: Colors.redAccent,
                                height: 100,
                                width: double.infinity,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.scaleDown,
                              )),
                              Expanded(
                                flex: 3,
                                child: ListTile(
                                  title: Text(
                                    "${listNotes[index]['title']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text("${listNotes[index]['notes']}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  trailing: Text("${listNotes[index]['color']}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold)),
                                  /* trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          /*   int response = await sqlDatabase.deleteData(
                                                "delete from notes where id =  ${listNotes[index]['id']}  "); */
                                          int response = await sqlDatabase.delete(
                                              "notes",
                                              "id =  ${listNotes[index]['id']}");
                                          print("response : ====== $response");
                                          if (response > 0) {
                                            // ignore: use_build_context_synchronously
                                            listNotes.removeWhere((element) =>
                                                element["id"] ==
                                                listNotes[index]['id']);
                                            setState(() {});
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      /*  IconButton(
                                        onPressed: () async {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              // ignore: prefer_const_constructors
                                              builder: (context) => EditNotes(
                                                title: listNotes[index]['title'],
                                                note: listNotes[index]['notes'],
                                                color: listNotes[index]['color'],
                                                noteId: listNotes[index]['id']
                                                    .toString(),
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.redAccent,
                                        ),
                                      ), */
                                    ],
                                  ), */
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
