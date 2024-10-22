import 'package:doctor_1/SQL_DB/db/notes_database.dart';
import 'package:doctor_1/SQL_DB/model/note.dart';
import 'package:doctor_1/SQL_DB/page/note_detail_page.dart';
import 'package:flutter/material.dart';

class SearchNotes extends SearchDelegate<Note> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage(
      //         'lib/Images/back-wave.jpg'), // Replace with your image path
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'lib/Images/back-wave.jpg'), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
    ); // Implement your search results UI here
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'lib/Images/fec5c09c63c23f5143be3e6382f58a7c.jpg'), // Replace with your image path
          fit: BoxFit.cover,
        ),
      ),
      child: FutureBuilder<List<Note>>(
        future: searchNotesByTitle(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No results found'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final note = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    // Open the NoteDetailPage when a search result is tapped
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NoteDetailPage(noteId: note.id!),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color.fromARGB(172, 255, 255, 255),
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        note.title,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Replace with your actual function to search notes by title
  Future<List<Note>> searchNotesByTitle(String titleQuery) async {
    final db = await NotesDatabase.instance.database;
    final result = await db.query(
      NotesDatabase.tableNotes,
      where: '${NoteFields.title} LIKE ?',
      whereArgs: ['%$titleQuery%'],
      orderBy: '${NoteFields.time} ASC',
    );
    return result.map((json) => Note.fromJson(json)).toList();
  }
}
