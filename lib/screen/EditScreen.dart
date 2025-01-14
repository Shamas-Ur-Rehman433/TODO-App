import 'package:flutter/material.dart';
import 'package:todo/Model/NotesModel.dart';
import 'package:todo/const/colors.dart';
import 'package:todo/data/firestor.dart';
class EditScreen extends StatefulWidget {
  Note _note;
  EditScreen(this._note,{super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  int indexx=0;
  TextEditingController? title;
  TextEditingController? subtitle;

  FocusNode _focusNode1=FocusNode();
  FocusNode _focusNode2=FocusNode();

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title=TextEditingController(text: widget._note.title);
    subtitle=TextEditingController(text: widget._note.subtitle);
    _focusNode1.addListener((){setState(() {

    });});

    super.initState();
    _focusNode2.addListener((){setState(() {

    });});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Title(),
              SizedBox(height: 20,),
              Subtitle(),
              SizedBox(height: 10,),
              Imagess(),
              SizedBox(height: 20,),
              Buttons(),
            ],
          ),
        ),
      ),
    );
  }

  Padding Buttons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                Firestore_Datasource().Update_Note(widget._note.id, indexx, title!.text, subtitle!.text);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: custom_green
                ),
                child: Text('Add Task',style: TextStyle(fontSize: 20),),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Expanded(
            child: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red
                ),
                child: Text('Cancel',style: TextStyle(fontSize: 20,color: Colors.white),),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container Imagess() {
    return Container(
      height: 200,
      child: ListView.builder(itemCount: 4,scrollDirection: Axis.horizontal,itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
            setState(() {
              indexx=index;
            });
          },
          child: Container(
            width: 150,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color:indexx==index? custom_green:Colors.grey,
                    width: 4)
            ),
            child: Column(children: [
              Image.asset('images/${index}.png',),
            ],),
          ),
        );
      }),
    );
  }

  Padding Subtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          maxLines: 3,
          controller: subtitle,
          focusNode: _focusNode2,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(

              contentPadding:
              EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText: 'Subtitle',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color(0xffc5c5c5),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: custom_green,
                  width: 2.0,
                ),
              )),
        ),
      ),
    );
  }

  Padding Title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: title,
          focusNode: _focusNode1,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(

              contentPadding:
              EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText: 'Title',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color(0xffc5c5c5),
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: custom_green,
                  width: 2.0,
                ),
              )),
        ),
      ),
    );
  }
}
