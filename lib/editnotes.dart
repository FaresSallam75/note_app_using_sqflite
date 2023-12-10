import 'package:flutter/material.dart';
import 'package:sqlflite/sqlflite.dart';
import 'package:sqlflite/viewnotes.dart';

class EditNotes extends StatefulWidget {
  final String title;
  final String note;
  final String color;
  final String noteId;

  const EditNotes({
    super.key,
    required this.title,
    required this.note,
    required this.color,
    required this.noteId,
  });

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    title.text = widget.title;
    note.text = widget.note;
    color.text = widget.color;

    super.initState();
  }

  SqlDatabase sqlDatabase = SqlDatabase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Notes", style: TextStyle(color: Colors.white)),
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
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed: () async {
                      /*  int response = await sqlDatabase.updateData(''' 
                         update notes set 
                         title = "${title.text}" , 
                         notes = "${note.text}",
                         color = "${color.text}"
                      where id = ${widget.noteId}
                        '''); */
                      int response = await sqlDatabase.update(
                          "notes",
                          {
                            "title": title.text,
                            "notes": note.text,
                            "color": color.text,
                          },
                          "id = ${widget.noteId}");

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
                    child: const Text("Edit Notes"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class $ {}
