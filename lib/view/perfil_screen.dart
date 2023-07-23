import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/text_auto_size.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final nomeC = TextEditingController();
  bool editing = false;
  @override
  Widget build(BuildContext context) {
    final credentials = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: credentials?.photoURL != null
                        ? NetworkImage(credentials?.photoURL ?? "")
                        : null,
                    child:
                        credentials?.photoURL == null ? const Text("S") : null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (editing)
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: nomeC,
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        TextAutoSize(
                          credentials?.displayName ?? "Sem nome",
                          minLegth: 7,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w300,
                              ),
                        ),
                      if (editing)
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                await FirebaseAuth.instance.currentUser
                                    ?.updateDisplayName(nomeC.text);
                                setState(() {
                                  editing = false;
                                });
                              } catch (e) {/**/}
                            },
                            icon: const Icon(Icons.save),
                            label: const Text("Salvar"),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                editing = true;
                              });
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
