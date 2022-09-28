// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final myController = TextEditingController();

  List<String> Notes = [];
  List<String> Notes2 = [];
  List<String> Notes3 = [];
  var CheckCmplt = List<bool>.filled(100, false, growable: true);
  bool all = true, pending = false, completed = false;
  int n = 0, i = 0;
  void checking() {
    int j = 0, l = 0;
    for (i = 0; i < Notes.length; i++) {
      if (CheckCmplt[i] == false) {
        this.Notes2.add(Notes[i]);
      } else {
        this.Notes3.add(Notes[i]);
      }
    }
  }

  int findindex(String note) {
    for (i = 0; i < Notes.length; i++) {
      if (note == Notes[i]) {
        break;
      }
    }
    return i;
  }

  Widget NoteTemplate(note) {
    return Card(
      color: Colors.grey[400],
      margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 1, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Done"),
                Checkbox(
                  activeColor: Colors.green,
                  value: this.CheckCmplt[findindex(note)],
                  onChanged: (newvalue) {
                    setState(
                      () {
                        for (i = 0; i < Notes.length; i++) {
                          if (note == Notes[i]) {
                            this.CheckCmplt[i] = !this.CheckCmplt[i];
                          }
                        }
                        if (pending) {
                          Notes2.remove(note);
                          Notes3.add(note);
                        } else if (completed) {
                          Notes2.add(note);
                          Notes3.remove(note);
                        }
                      },
                    );
                  },
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (all) {
                          for (i = 0; i < Notes.length; i++) {
                            if (note == Notes[i]) {
                              this.CheckCmplt[i] = false;
                            }
                          }
                          Notes.remove(note);
                        } else if (pending) {
                          for (i = 0; i < Notes.length; i++) {
                            if (note == Notes[i]) {
                              Notes.remove(note);
                              this.CheckCmplt[i] == false;
                            }
                          }
                          Notes2.remove(note);
                        } else {
                          for (i = 0; i < Notes.length; i++) {
                            if (note == Notes[i]) {
                              Notes.remove(note);
                              this.CheckCmplt[i] == false;
                            }
                          }
                          Notes3.remove(note);
                        }
                      });
                    },
                    icon: Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.grey[400],
                            title: Text('Edit task'),
                            content: Container(
                              height: 200,
                              width: 200,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                controller: myController..text = note,
                                autofocus: false,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    myController.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        String value2 = myController.text;
                                        for (i = 0; i < Notes.length; i++) {
                                          if (note == Notes[i]) {
                                            Notes[i] = value2;
                                          }
                                        }
                                        if (pending) {
                                          for (i = 0; i < Notes2.length; i++) {
                                            if (note == Notes2[i]) {
                                              Notes2[i] = value2;
                                            }
                                          }
                                        } else if (completed) {
                                          for (i = 0; i < Notes3.length; i++) {
                                            if (note == Notes3[i]) {
                                              Notes3[i] = value2;
                                            }
                                          }
                                        }
                                        myController.clear();
                                      },
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ))
                            ],
                          ),
                        );
                      });
                    },
                    icon: Icon(Icons.edit))
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                note,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget select() {
    if (all) {
      return Column(
        children: Notes.map((e) => NoteTemplate(e)).toList(),
      );
    } else if (pending) {
      return Column(
        children: Notes2.map((e) => NoteTemplate(e)).toList(),
      );
    } else {
      return Column(
        children: Notes3.map((e) => NoteTemplate(e)).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: (all)
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: Colors.grey[400],
                          title: Text('New Note'),
                          content: Container(
                            height: 200,
                            width: 200,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: myController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'What are you planning?'),
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  myController.clear();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    String Value = myController.text;

                                    Notes.add(Value);
                                    myController.clear();
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Create',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ))
                          ],
                        ));
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.grey,
            )
          : null,
      body: ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  setState(() {
                    all = true;
                    pending = false;
                    completed = false;
                  });
                },
                child: Text("All"),
                color: (all) ? Colors.grey : Colors.grey[200],
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  setState(() {
                    Notes2.clear();
                    all = false;
                    pending = true;
                    completed = false;
                    checking();
                  });
                },
                child: Text("Pending"),
                color: (pending) ? Colors.grey : Colors.grey[200],
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  setState(() {
                    Notes3.clear();
                    all = false;
                    pending = false;
                    completed = true;
                    checking();
                  });
                },
                child: Text("Completed"),
                color: (completed) ? Colors.grey : Colors.grey[200],
              )
            ],
          ),
          select(),
        ],
      ),
    );
  }
}
