import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:agentappproof/Model/Proof.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'Service/HTTPService.dart';

class AddProofDetails extends StatefulWidget {
  const AddProofDetails({Key? key}) : super(key: key);

  @override
  State<AddProofDetails> createState() => _AddProofDetailsState();
}

class _AddProofDetailsState extends State<AddProofDetails> {

  ProofService serviceApi = ProofService();
 // TextEditingController id = TextEditingController();
  TextEditingController proofCode = TextEditingController();
  TextEditingController proofId = TextEditingController();
  TextEditingController proofName = TextEditingController();
  TextEditingController proof = TextEditingController();

  String images = "";
  File? local_images;
  ImagePicker imagePicker = ImagePicker();

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.local_images = image;

      images = basename(image.path);

      final encode = base64Encode(local_images!.readAsBytesSync());
      images = "data:image/jpeg;base64,$encode";
    });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("welcome to add proof "),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: proofCode,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Proof Code"
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: proofId,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "proof Id"
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: proofName,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Proof Name"
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: proof,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Proof"
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                    serviceApi.createProof(Proof(
                        proofCode: proofCode.text,
                        proofId: proofId.text,
                        proofName: proofName.text,
                        proof: proof.text,
                    ));
                    setState(() {
                      serviceApi.getAllProof();
                    });
                  },
                  child: Text("submit", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
