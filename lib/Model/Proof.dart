class Proof {
  int? id;
  String? proofCode;
  String? proofId;
  String? proofName;
  String? proof;

  Proof({this.id, this.proofCode, this.proofId, this.proofName, this.proof});

  Proof.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    proofCode = json['proofCode'];
    proofId = json['proofId'];
    proofName = json['proofName'];
    proof = json['proof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['proofCode'] = proofCode;
    data['proofId'] = proofId;
    data['proofName'] = proofName;
    data['proof'] = proof;
    return data;
  }
}