class Poli {
  int? id;
  String namaPoli;

  Poli({this.id, required this.namaPoli});

  factory Poli.fromJson(Map<String, dynamic> json) {
    int? parsedId;
    if (json['id'] is String) {
      parsedId = int.tryParse(json['id']);
    } else {
      parsedId = json['id'];
    }

    return Poli(
      id: parsedId,
      namaPoli: json['nama_poli'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_poli': namaPoli,
    };
  }
}
