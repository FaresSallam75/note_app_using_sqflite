import 'package:flutter/material.dart';
import 'package:sqlflite/sqlflite.dart';
import 'package:sqlflite/viewnotes.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  // TextEditingController id = TextEditingController();

  SqlDatabase sqlDatabase = SqlDatabase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Title",
                  ),
                  controller: title,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "note",
                  ),
                  controller: note,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "color",
                  ),
                  controller: color,
                ),
                /*  TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: "Id",
                  ),
                  controller: id,
                ), */
                MaterialButton(
                  onPressed: () async {
                    /*   int response = await sqlDatabase.insertData(
                        '''insert into notes ('notes', 'title', 'color') 
                         values( '${note.text}' , 
                        '${title.text}' ,
                         '${color.text}'  )  '''); */

                    int response = await sqlDatabase.insert("notes", {
                      " notes": note.text,
                      " title": title.text,
                      " color": color.text,
                    });

                    if (response > 0) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const ViewNotes()),
                          (route) => false);
                    }
                  },
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  child: const Text("Add Notes"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
