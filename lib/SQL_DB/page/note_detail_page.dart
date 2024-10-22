import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/notes_database.dart';
import '../model/note.dart';
import '../page/edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    super.key,
    required this.noteId,
  });

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    note = await NotesDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 73, 119),
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'lib/Images/fec5c09c63c23f5143be3e6382f58a7c.jpg'), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    children: [
                      const SizedBox(height: 18),
                      Card(
                        color: const Color.fromARGB(40, 255, 255, 255),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            DateFormat.yMMMd().format(note.createdTime),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      buildInfoCard('Title:', note.title),
                      const SizedBox(height: 18),
                      // buildInfoCard(
                      //     'Hospital: Black Lion Hospital', note.description),
                      // const SizedBox(height: 18),
                      // buildInfoCard('AGE:', note.age),
                      // const SizedBox(height: 18),
                      buildInfoCard('Note:', note.description),
                    ],
                  ),
                ),
              ),
      );

  Widget buildInfoCard(String title, String value) {
    return Card(
      color: const Color.fromARGB(202, 1, 23, 41),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_rounded),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);

          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
        },
      );
}
