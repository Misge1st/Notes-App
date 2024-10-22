import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/notes_database.dart';
import '../model/note.dart';
import '../page/edit_note_page.dart';
import '../page/note_detail_page.dart';
import '../page/search_case.dart';

enum MenuAction {
  logout,
  addPatient, // Add more actions as needed
}

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Notes App',
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchNotes());
              },
              icon: const Icon(Icons.search_rounded),
            ),
            // PopupMenuButton<MenuAction>(
            //   onSelected: (action) {
            //     switch (action) {
            //       case MenuAction.logout:
            //         // Handle logout action
            //         break;
            //       case MenuAction.addPatient:
            //         Navigator.of(context)
            //             .push(
            //               MaterialPageRoute(
            //                 builder: (context) => const AddEditNotePage(),
            //               ),
            //             )
            //             .then((_) => refreshNotes());
            //         break;
            //     }
            //   },
            //   itemBuilder: (context) => const [
            //     PopupMenuItem(
            //       value: MenuAction.addPatient,
            //       child: Text('Add Patient'),
            //     ),
            //     PopupMenuItem(
            //       value: MenuAction.logout,
            //       child: Text('Logout', style: TextStyle(color: Colors.red)),
            //     ),
            //   ],
            // ),
          ],
          backgroundColor: Colors.orangeAccent,
        ),
        body: Container(
          color: Colors.white70,
          child: Column(
            children: [
              // Your header widgets here

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Container(
                  //   color: Colors.orangeAccent,
                  //   child: IconButton(
                  //     icon: const Icon(
                  //       Icons.location_on,
                  //     ),
                  //     onPressed: () {
                  //       // Add your search functionality here
                  //     },
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  // Expanded(
                  //   child: Container(
                  //     color: Colors.white,
                  //     child: const TextField(
                  //         decoration: InputDecoration(
                  //       hintText: '     Search Event here ...',
                  //     )),
                  //   ),
                  // ),
                  // Container(
                  //   color: Colors.orangeAccent,
                  //   child: IconButton(
                  //     icon: const Icon(Icons.search),
                  //     onPressed: () {
                  //       // Add your filter functionality here
                  //     },
                  //   ),
                  // ),
                ],
              ),

              // const Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     SizedBox(
              //       height: 50,
              //     ),
              //     Icon(
              //       Icons.local_movies_outlined,
              //       color: Colors.orangeAccent,
              //       size: 30,
              //     ),
              //     Text(' Entertainment   ',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 15,
              //         )),
              //     Icon(
              //       Icons.forest,
              //       color: Colors.orangeAccent,
              //       size: 30,
              //     ),
              //     Text(' Environmental   ',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 15,
              //         )),
              //     Icon(
              //       Icons.local_movies,
              //       color: Colors.orangeAccent,
              //       size: 30,
              //     ),
              //     Text(' Expo ',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 15,
              //         )),
              //   ],
              // ),
              // const Row(
              //   children: [
              //     Text(
              //       'Featured Events',
              //       style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              //     )
              //   ],
              // ),

              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    mainAxisSpacing: 14, // Spacing between columns
                    crossAxisSpacing: 6, // Spacing between rows
                    childAspectRatio: 0.6, // Aspect ratio of each card
                  ),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    final isLeftAligned = index.isEven; // Alternate alignment

                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NoteDetailPage(noteId: note.id!),
                                ),
                              )
                              .then((_) => refreshNotes());
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            alignment: isLeftAligned
                                ? Alignment.centerLeft
                                : Alignment.centerRight, // Set alignment
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'lib/Images/fec5c09c63c23f5143be3e6382f58a7c.jpg', // Replace 'image_name.png' with your actual image asset path
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover, // Adjust the fit as needed
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  note.birthPlace,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  note.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const Text(
                                  'Tomorrow',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 0, 255, 8)),
                                ),
                                const SizedBox(height: 8),
                                // Text(
                                //   note.description,
                                //   maxLines: 3,
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                                Text(
                                  note.age,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  DateFormat.yMMMd().format(note.createdTime),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          // tooltip: 'Add New Patient',
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => const AddEditNotePage(),
                  ),
                )
                .then((_) => refreshNotes());
          },
          child: const Icon(Icons.add),
        ),
      );
}
