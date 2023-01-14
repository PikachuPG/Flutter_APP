import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:stateful_app/dbm.dart';
class Details extends StatelessWidget {
  Details(
      {Key? key})
      : super(key: key);

  //Query dbref = FirebaseDatabase.instance.ref().child('users');
  //DatabaseReference reference = FirebaseDatabase.instance.ref().child('users');
  List userProfilesList = [];
  @override
  void initState() {
    fetchDatabaseList();
  }
  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();
    {
      //setState
      {
        userProfilesList = resultant;
      }
    }
  }

  updateData(String name, String gender, int score, String userID) async {
    await DatabaseManager().updateUserList(name, gender, score, userID);
    fetchDatabaseList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Users'),
          backgroundColor: Colors.deepPurple,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              return Container(

                padding: EdgeInsets.all(8),
                child: (snapshot.data!.docs.length == 0)
                    ? Center(
                  child: Text('No users found'),
                )
                    : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, int index) {
                      return Center(
                        child: Container(
                          height: 128,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [

                                  SizedBox(
                                    height: 128,
                                    width:
                                    MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('Name: ' +
                                            snapshot.data!.docs[index]
                                            ['name']),
                                        Text('Age: ' +
                                            snapshot
                                                .data!.docs[index]['age']
                                                .toString()),
                                        Text('Education:' +
                                            snapshot.data!.docs[index]
                                            ['size']),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }));
  }







  //   return Scaffold(
  //       appBar: AppBar(
  //         centerTitle: true,
  //         title: const Text(
  //           "Details",
  //         ),
  //         //Pop and navigate to previous screen
  //         leading: IconButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             icon: const Icon(Icons.arrow_back)),
  //       ),
  //       body: Container(
  //         padding: const EdgeInsets.all(4.0),
  //         child: ListView.builder(
  //           itemCount: userProfilesList.length,
  //           children: [
  //             //Dynamic Tile
  //             ListTile(
  //               shape: RoundedRectangleBorder(
  //                   side: BorderSide(width: 1.0, color: Colors.grey.shade300)),
  //               leading: IconButton(
  //                 icon: const Icon(Icons.bookmark_added_rounded,
  //                     color: Colors.blueAccent),
  //                 onPressed: () {},
  //               ),
  //               title: Text(
  //                 productName,
  //                 style: const TextStyle(
  //                     fontWeight: FontWeight.bold, fontSize: 18.0),
  //               ),
  //               subtitle: Text(productDescription),
  //               trailing: const Icon(
  //                 Icons.delete,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //
  //
  //
  //           ],
  //         ),
  //       ));
  // }

}