import 'dart:convert';
import 'dart:io';

import 'package:agentappproof/Model/Proof.dart';
import 'package:http/http.dart';

class ProofService{
  Future<List<Proof>> getAllProof() async{
    Response res = await get(Uri.parse("http://192.168.1.12:9199/getActiveProof"));
    if(res.statusCode == 200){
      List<dynamic> body = jsonDecode(res.body);
      List<Proof> proof = body.map((e) => Proof.fromJson(e)).toList();
      return proof;
    }
    throw Exception("Data Not Found");
  }

  Future<Proof> createProof(Proof proof) async{
    final response = await post(
        Uri.parse("http://192.168.1.12:9199/uploadProof"),
            headers: {
          'Content-Type':'application/json; charset=UTF-8',
            },
        body:jsonEncode({
          "id": proof.id,
          "proofCode":proof.proofCode,
          "proofId":proof.proofId,
          "proofName":proof.proofName,
          "proof":proof.proof,

        }),
    );
    return Proof.fromJson(jsonDecode(response.body));
  }

  Future<Proof> updateProof(id, Proof proof) async{
    final response = await patch(
      Uri.parse('http://192.168.1.12:9199/updateProof/$id'),
      headers: {
        'Content-Type':'application/json; charset=UTF-8',
      },
      body:jsonEncode({
        "id": proof.id,
        "proofCode":proof.proofCode,
        "proofId":proof.proofId,
        "proofName":proof.proofName,
        "proof":proof.proof,

      }),
    );
    return Proof.fromJson(jsonDecode(response.body));
  }

  void deleteProof(id) async{
    final response = await patch(Uri.parse('http://192.168.1.12:9199/softDelete/$id'));
    print("response");
  }

}