import 'dart:convert';
import 'dart:typed_data';

import 'package:agentappproof/Model/Proof.dart';
import 'package:agentappproof/Service/HTTPService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddProof.dart';

class ProofView extends StatefulWidget {
  const ProofView({Key? key}) : super(key: key);

  @override
  State<ProofView> createState() => _ProofViewState();
}

class _ProofViewState extends State<ProofView> {

  ProofService serviceApi = ProofService();
  String? proofCode;
  String? proofId;
  String? proofName;
  String? proof;

  @override
  Widget build(BuildContext context) {
    serviceApi.getAllProof();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agent Proof Details"),

      ),
      body: FutureBuilder(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return  ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context , int index){
              serviceApi.getAllProof();
              return InkWell(
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("Id: ${snapshot.data[index].id}"),
                          Text("Proof Code: ${snapshot.data[index].proofCode}"),
                          Text("Proof Id: ${snapshot.data[index].proofId}"),
                          Text("Proof Name: ${snapshot.data[index].proofName}"),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),


                      Row(
                        children: [
                          SizedBox(
                            child: IconButton(
                                onPressed: () {
                                  String uri = 'data:image/gif;base64,${snapshot.data[index].proof}';
                                  Uint8List _bytes;
                                  _bytes = base64.decode(uri.split(',').last);
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Proof Image'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children:  <Widget>[
                                              GestureDetector(
                                                onTap: () {

                                                },
                                                child: Container(
                                                  height: 300,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.purple),
                                                    borderRadius: BorderRadius.circular(25.0),
                                                  ), //             <--- BoxDecoration here
                                                  child: Container(
                                                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                                                    width: 500.0,
                                                    height: 800.0,
                                                    child: Image.memory(_bytes),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Back'),
                                            onPressed: () {
                                              // Fluttertoast.showToast(
                                              //     msg: "You have deleted the record successfully",
                                              //     toastLength: Toast.LENGTH_SHORT,
                                              //     gravity: ToastGravity.CENTER,
                                              //     timeInSecForIosWeb: 1,
                                              //     backgroundColor: Colors.red,
                                              //     textColor: Colors.white,
                                              //     fontSize: 16.0
                                              // );
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.view_agenda_outlined)),
                          ),
                          SizedBox(
                            child: IconButton(
                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Update Proof"),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children:  <Widget>[
                                              TextFormField(
                                                initialValue:'${snapshot.data[index].proofCode}',

                                                onChanged: (e){
                                                  setState(() {
                                                    proofCode=e;
                                                  });
                                                },
                                                decoration: const InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: "Proof Code"
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                initialValue:'${snapshot.data[index].proofId}',

                                                onChanged: (e){
                                                  setState(() {
                                                    proofId=e;
                                                  });
                                                },

                                                decoration: const InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: "Proof Id"
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                initialValue:'${snapshot.data[index].proofName}',

                                                onChanged: (e){
                                                  setState(() {
                                                    proofName=e;
                                                  });
                                                },

                                                decoration: const InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: "Proof Name"
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextFormField(
                                                initialValue:'${snapshot.data[index].proof}',

                                                onChanged: (e){
                                                  setState(() {
                                                    proof=e;
                                                  });
                                                },

                                                decoration: const InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    labelText: "Proof "
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Back'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Save'),
                                            onPressed: () {
                                              serviceApi.updateProof(snapshot.data[index].id, Proof(
                                                proofCode: proofCode,
                                                proofId: proofId,
                                                proofName: proofName,
                                                proof: proof,
                                              ));
                                              serviceApi.getAllProof();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  setState(() {
                                    serviceApi.getAllProof();
                                  });
                                },
                                icon: const Icon(Icons.edit_note_outlined)),
                          ),
                          SizedBox(
                            child: IconButton(
                                onPressed: () {
                                  serviceApi.deleteProof(snapshot.data[index].id);
                                  setState(() {
                                    serviceApi.getAllProof();
                                  });
                                },
                                icon: const Icon(Icons.delete_forever)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }

        );
      },
        future: serviceApi.getAllProof(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddProofDetails()));
        },
        tooltip: "route to second page",
        child: const Icon(Icons.add),
      ),
    );
  }
}
