import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:jsxpro/controller/home_controller.dart';
import 'package:jsxpro/view/eventos_screen.dart';
import 'package:jsxpro/view/listacursos_screen.dart';
import 'package:jsxpro/view/perfil_screen.dart';

import '../components/card_custom.dart';
import '../components/text_auto_size.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    final controller = HomeController(context);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int value) => controller.bottomMenuClick(value, pc),
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Cursos"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Eventos"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
      appBar: AppBar(
        title: const Text(
          "JSXPert",
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
      ),
      body: PageView(
        scrollDirection: Axis.horizontal,
        controller: pc,
        children: const [
          HomeScreenFragment(),
          ListacursosScreen(),
          EventosScreen(),
          PerfilScreen(),
        ],
      ),
    );
  }
}

class HomeScreenFragment extends StatefulWidget {
  const HomeScreenFragment({
    super.key,
  });

  @override
  State<HomeScreenFragment> createState() => _HomeScreenFragmentState();
}

class _HomeScreenFragmentState extends State<HomeScreenFragment> {
  final credentials = FirebaseAuth.instance.currentUser;
  final database = FirebaseDatabase.instance;
  late DatabaseReference userDB;
  String nivel = "Novato";
  bool novoUsuario = false;

  @override
  void initState() {
    super.initState();
    userDB = database.ref("usuarios/${credentials?.uid}");
    fetchData();
  }

  Future<void> fetchData() async {
    final snapshot = await userDB.child("/nivel").get();
    final dataUser = snapshot.value;
    if (dataUser == null) {
      await userDB.update({
        "nivel": "Novato",
        "xp": 0,
        "cursosRecentes": [],
        "ensignias": [
          {
            "nome": "O Começo",
            "data":
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            "hora": "${DateTime.now().hour}:${DateTime.now().minute}",
          }
        ]
      });
      setState(() {
        novoUsuario = true;
      });
    } else {
      setState(() {
        nivel = dataUser as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = HomeController(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      child: Text(credentials?.photoURL ?? "S"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextAutoSize(
                      credentials?.displayName ?? "sem nome",
                      minLegth: 7,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
                Text(
                  "Nivel: $nivel",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Cursos recentes",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 300,
            child: FutureBuilder(
                future: userDB.child("cursosRecentes").get(),
                builder: (context, snapshot) {
                  List? cursosRecentes = snapshot.data?.value as List?;
                  print(cursosRecentes);
                  return cursosRecentes == null
                      ? Container()
                      : PageView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const PageScrollPhysics(),
                          itemCount: cursosRecentes.length,
                          itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CardCustom(
                              porcent: double.parse(index
                                  .toString()
                                  .padLeft(2, "0.")
                                  .replaceAll("10", "1")),
                              titulo: cursosRecentes[index]['nome'],
                              descricao: controller.descricaoReduce(
                                  cursosRecentes[index]["descricao"]),
                              image:
                                  "http://unsplash.it/250/300?random&gravity=center",
                              onPress: () =>
                                  controller.clickCursosRecentes(index),
                            ),
                          ),
                        );
                }),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Eventos Ativos",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 300,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              physics: const PageScrollPhysics(),
              itemCount: 10,
              itemBuilder: (_, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CardCustom(
                  porcent: double.parse(index.toString().padLeft(2, "0.")),
                  titulo: 'Torneio de Javascript',
                  descricao: controller.descricaoReduce(
                      'Pariatur magna irure quis magna tempor. Ex dolore cupidatat quis cupidatat laborum. Tempor proident amet cupidatat esse sint Lorem irure labore. Ea fugiat ullamco velit eiusmod cillum velit consequat fugiat nisi cupidatat.'),
                  image: "http://unsplash.it/240/300?random&gravity=center",
                  onPress: () => controller.clickCursosRecentes(index),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
