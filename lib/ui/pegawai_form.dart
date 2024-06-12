import 'package:flutter/material.dart';
import 'package:klinik_app/model/pegawai.dart';
import 'package:klinik_app/ui/pegawai_detail.dart'; // Pastikan path impor ini benar
import '../service/pegawai_service.dart'; // Pastikan path impor ini benar

class PegawaiForm extends StatefulWidget {
  const PegawaiForm({Key? key}) : super(key: key);

  @override
  _PegawaiFormState createState() => _PegawaiFormState();
}

class _PegawaiFormState extends State<PegawaiForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPegawaiCtrl = TextEditingController();
  final _nIPCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Pegawai")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _fieldNamaPegawai(),
                _fieldNIP(),
                _fieldTanggalLahir(),
                _fieldNomorTelepon(),
                _fieldEmail(),
                _fieldPassword(),
                const SizedBox(height: 20),
                _tombolSimpan(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldNamaPegawai() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Pegawai"),
      controller: _namaPegawaiCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama Pegawai tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _fieldNIP() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "NIP"),
      controller: _nIPCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'NIP tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _fieldTanggalLahir() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tanggal Lahir"),
      controller: _tanggalLahirCtrl,
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (selectedDate != null) {
          setState(() {
            _tanggalLahirCtrl.text =
                "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
          });
        }
      },
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tanggal Lahir tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _fieldNomorTelepon() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nomor Telepon"),
      controller: _nomorTeleponCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nomor Telepon tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _fieldEmail() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      controller: _emailCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _fieldPassword() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      controller: _passwordCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          Pegawai pegawai = Pegawai(
            nip: _nIPCtrl.text,
            nama: _namaPegawaiCtrl.text,
            tanggalLahir: DateTime.parse(_tanggalLahirCtrl.text),
            nomorTelepon: _nomorTeleponCtrl.text,
            email: _emailCtrl.text,
            password: _passwordCtrl.text,
          );
          await PegawaiService().simpan(pegawai).then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PegawaiDetail(
                    pegawai: value), // Pastikan PegawaiDetail benar
              ),
            );
          });
        }
      },
      child: const Text("Simpan"),
    );
  }
}
