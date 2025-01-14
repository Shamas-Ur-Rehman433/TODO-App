import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/Wdget/TaskWidget.dart';
import 'package:todo/data/firestor.dart';

class StreemNote extends StatefulWidget {
  bool isdone;
  StreemNote(this.isdone, {super.key});

  @override
  State<StreemNote> createState() => _StreemNoteState();
}

class _StreemNoteState extends State<StreemNote> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore_Datasource().stream(widget.isdone),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final notelist = Firestore_Datasource().getNotes(snapshot);

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: notelist.length,
          itemBuilder: (context, index) {
            final note = notelist[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add padding
              child: Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  Firestore_Datasource().Delete_Note(note.id);
                },
                child: TaskWidget(note), // Ensure Task_Widget is also constrained
              ),
            );
          },
        );
      },
    );
  }
}
