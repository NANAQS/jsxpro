import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jsxpro/controller/listaCurso_controller.dart';

class ListacursosScreen extends StatelessWidget {
  const ListacursosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Query db = FirebaseDatabase.instance.ref().child("cursos").limitToFirst(10);
    final storageRef = FirebaseStorage.instance.ref().child("cursos");
    final controller = ListaCursoController(context: context);

    return Scaffold(
      body: FirebaseAnimatedList(
        query: db,
        itemBuilder: (context, snapshot, animation, index) {
          Map cursos = snapshot.value as Map;
          return ListTile(
            onTap: () => controller.clickToCurse(cursos),
            title: Text(cursos["nome"]),
            subtitle: Text(cursos["descricao"]),
            trailing: IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.arrow_forward_ios_outlined)),
            leading: FutureBuilder(
                future:
                    storageRef.child("${cursos['foto']}.png").getDownloadURL(),
                builder: (context, snapshotFoto) {
                  return CircleAvatar(
                      backgroundImage: NetworkImage(snapshotFoto.data ??
                          "https://dummyimage.com/400x400/ffffff/ff0000.png?text=Erro%20ao%20Carregar"),
                      child: snapshotFoto.data == null
                          ? Text(cursos["nome"])
                          : null);
                }),
          );
        },
      ),
    );
  }
}
