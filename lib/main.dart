import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:state_provider/dbhelper.dart';
//import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Databasehelper dbhelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbhelper = Databasehelper.instance;
    log(dbhelper.toString());
  }

  void insertdata() async {
    log("Insert Called");
    Map<String, dynamic> row = {
      Databasehelper.columnname: "Sandesh",
      Databasehelper.columnage: "18"
    };
    final id = await dbhelper.insert(row);
    print(id);
  }

  void queryalll() async {
    var allrows = await dbhelper.queryall();
    for (var row in allrows) {
      print(row);
    }
  }

  void queryspecify() async {
    var allrows = await dbhelper.queryspecify(24);
    print(allrows);
  }

  void delete() async {
    var id = await dbhelper.deletedata(8);
    print(id);
  }

  void update() async {
    var row = await dbhelper.update(1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 15),
                      child: Container(
                        color: const Color.fromARGB(255, 199, 182, 182),
                        height: 500,
                        width: double.infinity,
                        child: FutureBuilder(
                          future: dbhelper.queryspecify(18),
                          builder: (context,
                              AsyncSnapshot<List<Map<String, dynamic>>>
                                  snapshot) {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  final responseList =
                                      snapshot.data?.toList(growable: false);

                                  return ListTile(
                                    title: Text(responseList![index]["name"]
                                        .toString()),
                                    subtitle: Text(
                                        responseList[index]["age"].toString()),
                                  );
                                });
                          },
                        ),
                      ),
                    ),
                    // Container(
                    //     child: Center(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     //   crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       TextButton(
                    //         onPressed: insertdata,
                    //         child: Text('Insert'),
                    //       ),
                    //       TextButton(
                    //         onPressed: queryalll,
                    //         child: const Text('QueryAll'),
                    //       ),
                    //       TextButton(
                    //         onPressed: queryspecify,
                    //         child: Text('QuerySpecific'),
                    //       ),
                    //       TextButton(
                    //         onPressed: delete,
                    //         child: const Text('Delete'),
                    //       ),
                    //       TextButton(
                    //         onPressed: update,
                    //         child: Text('Update'),
                    //       ),
                    //     ],
                    //   ),
                    // )),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Stack(children: [
            Positioned(
              //left: 10,
              child: Container(
                height: 180,
                //color: Colors.black12,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton.extended(
                            label: const Text('Insert'),
                            onPressed: insertdata,
                            //child: Icon(Icons.insert_chart),
                            backgroundColor: Colors.pink,
                          ),
                          FloatingActionButton.extended(
                              onPressed: queryalll,
                              // child: Icon(Icons.insert_chart),
                              backgroundColor: Colors.green,
                              label: const Text('QueryAll')),
                          FloatingActionButton.extended(
                            onPressed: queryspecify,
                            //   child: Icon(Icons.insert_chart),
                            label: const Text('Query Spec'),
                            backgroundColor: Colors.purple,
                          ),
                        ]),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton.extended(
                          label: const Text('Delete'),
                          onPressed: delete,
                          //    child: Icon(Icons.insert_chart),
                          backgroundColor: Colors.blue[900],
                        ),
                        FloatingActionButton.extended(
                          label: const Text('Update'),
                          onPressed: update,
                          //  child: Icon(Icons.insert_chart),
                          backgroundColor: Colors.red,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ])
          //  Stack(

          //    fit: StackFit.expand,
          //    alignment: Alignment.center,
          //    children: [
          //      Positioned(
          //        left: 10,
          //        bottom: 20,
          //        child: FloatingActionButton(
          //          onPressed: () {  },
          //          child: const Icon(
          //             Icons.arrow_left,
          //             size: 40,
          //           ),

          //        )),
          //      Positioned(
          //        left: 80,
          //        bottom: 20,
          //        child: FloatingActionButton(
          //          onPressed: () {  },
          //          child: const Icon(
          //             Icons.arrow_left,
          //             size: 40,
          //           ),
          //        )),

          //       Positioned(
          //        left: 150,
          //        bottom: 20,
          //        child: FloatingActionButton(
          //          onPressed: () {  },
          //          child: const Icon(
          //             Icons.arrow_left,
          //             size: 40,
          //           ),
          //        )),
          //       Positioned(
          //        left: 220,
          //        bottom: 20,
          //        child: FloatingActionButton(
          //          onPressed: () {  },
          //          child: const Icon(
          //             Icons.arrow_left,
          //             size: 40,
          //           ),
          //        )),

          //       Positioned(
          //        left: 290,
          //        bottom: 20,
          //        child: FloatingActionButton(
          //          onPressed: () {  },
          //          child: const Icon(
          //             Icons.arrow_left,
          //             size: 40,
          //           ),
          //        )),
          //        ],
          //    ) ,

          ),
    );
  }
}
