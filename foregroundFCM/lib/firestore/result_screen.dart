// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'document_view.dart';
//
// class ResultScreen extends StatefulWidget {
//   final String index;
//   ResultScreen(this.index);
//   @override
//   _ResultScreenState createState() => _ResultScreenState();
// }
//
// class _ResultScreenState extends State<ResultScreen> {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   Stream<QuerySnapshot> currentStream;
//   List<String> menuIndex = ["see all","already purchased", "price<20000"];
//   @override  void initState() {
//     super.initState();
//     switch(widget.index){
//       case "all" :{
//         currentStream = firestore.collection("Temperature").snapshots();
//         break;
//       }
//       case "pre" :{
//         currentStream = firestore.collection("Humidity").where("pre?", isEqualTo: true).snapshots();
//         break;
//       }
//       case "value" :{
//         currentStream = firestore.collection("Co2").where("value", isLessThan: 20000).snapshots();
//         break;
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("dashboard"),
//         actions: <Widget>[
//           PopupMenuButton<String>(
//             onSelected: (String choice){
//               if(choice == "see all") Navigator.pushNamed(context, '/');
//               else if(choice == "value")
//                 Navigator.pushNamed(context, 'a');
//               else Navigator.pushNamed(context, 'b');
//             },
//             itemBuilder: (BuildContext context) {
//               return menuIndex.map((choice) => PopupMenuItem(value: choice, child: Text(choice))).toList();
//             },
//           ),
//         ],
//       ),
//       body: StreamBuilder(
//         stream: currentStream,
//         builder: (context, snapshot){
//           if(!snapshot.hasData){
//             return CircularProgressIndicator();
//           }
//           List<DocumentSnapshot> documents = snapshot.data.documents;
//           return ListView(
//             padding:EdgeInsets.only(top: 20.0),
//             children: documents.map((eachDocument) => DocumentView(eachDocument)).toList(),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(       label : Text("ADD"),
//         icon : Icon(Icons.add),
//         onPressed: (){
//           Navigator.pushNamed(context, 'c');
//         },
//       ),
//     );
//   }
// }