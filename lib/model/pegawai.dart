// class Pegawai {
//   String? id; // Ubah tipe id menjadi String
//   String nip;
//   String nama;
//   DateTime tanggalLahir;
//   String nomorTelepon;
//   String email;
//   String password;

//   Pegawai({
//     this.id,
//     required this.nip,
//     required this.nama,
//     required this.tanggalLahir,
//     required this.nomorTelepon,
//     required this.email,
//     required this.password,
//   });

//   factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
//         id: json["id"], // Pastikan id diambil sebagai String dari JSON
//         nip: json["nip"],
//         nama: json["nama"],
//         tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
//         nomorTelepon: json["nomor_telepon"],
//         email: json["email"],
//         password: json["password"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id, // Sertakan id dalam konversi ke JSON
//         "nip": nip,
//         "nama": nama,
//         "tanggal_lahir": tanggalLahir.toIso8601String(),
//         "nomor_telepon": nomorTelepon,
//         "email": email,
//         "password": password,
//       };
// }

class Pegawai {
  String? id;
  String nip;
  String nama;
  DateTime tanggalLahir;
  String nomorTelepon;
  String email;
  String password;

  Pegawai({
    this.id,
    required this.nip,
    required this.nama,
    required this.tanggalLahir,
    required this.nomorTelepon,
    required this.email,
    required this.password,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id: json["id"],
      nip: json["nip"],
      nama: json["nama"],
      tanggalLahir:
          _parseTanggalLahir(json["tanggal_lahir"]), // Parsing tanggal khusus
      nomorTelepon: json["nomor_telepon"],
      email: json["email"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nip": nip,
      "nama": nama,
      "tanggal_lahir":
          "${tanggalLahir.day} ${_getBulanName(tanggalLahir.month)} ${tanggalLahir.year}", // Ubah format tanggal sesuai kebutuhan
      "nomor_telepon": nomorTelepon,
      "email": email,
      "password": password,
    };
  }

  static DateTime _parseTanggalLahir(String tanggalString) {
    final parts = tanggalString.split(' ');
    final tanggal = int.parse(parts[0]);
    final bulan = _getBulanIndex(parts[1]);
    final tahun = int.parse(parts[2]);
    return DateTime(tahun, bulan, tanggal);
  }

  static int _getBulanIndex(String bulan) {
    switch (bulan.toLowerCase()) {
      case 'januari':
        return 1;
      case 'februari':
        return 2;
      case 'maret':
        return 3;
      case 'april':
        return 4;
      case 'mei':
        return 5;
      case 'juni':
        return 6;
      case 'juli':
        return 7;
      case 'agustus':
        return 8;
      case 'september':
        return 9;
      case 'oktober':
        return 10;
      case 'november':
        return 11;
      case 'desember':
        return 12;
      default:
        throw FormatException('Format bulan tidak valid: $bulan');
    }
  }

  static String _getBulanName(int bulan) {
    switch (bulan) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        throw FormatException('Bulan tidak valid: $bulan');
    }
  }
}
