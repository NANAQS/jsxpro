import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../components/piechart_custom.dart';

class DetalhesCursoScreen extends StatefulWidget {
  final Map cursoInformacoes;

  const DetalhesCursoScreen({super.key, required this.cursoInformacoes});

  @override
  State<DetalhesCursoScreen> createState() => _DetalhesCursoScreenState();
}

class _DetalhesCursoScreenState extends State<DetalhesCursoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 1000),
        builder: (context, value, child) {
          return ShaderMask(
            shaderCallback: (rect) {
              return RadialGradient(
                radius: value * 5,
                colors: const [
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                  Colors.transparent
                ],
                stops: const [0, 0.55, 0.6, 1],
                center: const FractionalOffset(0.95, 0.9),
              ).createShader(rect);
            },
            child: DetalheScreen(
              cursoInformacoes: widget.cursoInformacoes,
            ),
          );
        },
        child: DetalheScreen(
          cursoInformacoes: widget.cursoInformacoes,
        ),
      ),
    );
  }
}

class DetalheScreen extends StatefulWidget {
  final Map cursoInformacoes;
  const DetalheScreen({
    super.key,
    required this.cursoInformacoes,
  });

  @override
  State<DetalheScreen> createState() => _DetalheScreenState();
}

class _DetalheScreenState extends State<DetalheScreen> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: .7);
    pageController.addListener(
      () {
        setState(() {
          pageOffset = pageController.page!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final colors = Theme.of(context).colorScheme;
    final storageRef = FirebaseStorage.instance.ref().child("cursos");

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              IndexedStack(
                index: 0,
                children: [
                  ShaderMask(
                    blendMode: BlendMode.dstIn,
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(
                          Rect.fromLTRB(0, 0, bounds.width, bounds.height));
                    },
                    child: FutureBuilder(
                        future: storageRef
                            .child("${widget.cursoInformacoes['foto']}.png")
                            .getDownloadURL(),
                        builder: (context, snapshot) {
                          return Image.network(
                            snapshot.data ??
                                'https://dummyimage.com/400x400/ffffff/ff0000.png?text=Erro%20ao%20Carregar',
                            width: size.width,
                            height: 400,
                            fit: BoxFit.cover,
                          );
                        }),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "${widget.cursoInformacoes['nome']}",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: colors.primary.withAlpha(150),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: colors.primary,
                          ),
                          Text(
                            "150h",
                            style: theme.textTheme.headlineSmall?.copyWith(
                                color: colors.primary.withAlpha(200),
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    '"${widget.cursoInformacoes["descricao"]}"',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors.inversePrimary,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            height: 400,
            padding: const EdgeInsets.only(bottom: 30),
            child: PageView.builder(
              itemCount: 3,
              controller: pageController,
              itemBuilder: (context, index) {
                return Transform.scale(
                  scale: 1,
                  child: Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            "http://unsplash.it/1000/100$index?random&gravity=center",
                            height: 370,
                            fit: BoxFit.cover,
                            alignment:
                                Alignment(-pageOffset.abs() + (index + .5), 0),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          bottom: 20,
                          right: 10,
                          child: Text(
                            "Aula 1",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          right: 10,
                          child: Text(
                            "Commodo Lorem pariatur magna eiusmod ex. Nostrud reprehenderit consequat velit aliqua culpa laboris cupidatat Lorem. Cillum laborum ipsum voluptate excepteur mollit qui nisi ad consectetur consectetur excepteur excepteur eiusmod. Labore ad velit officia ad elit ipsum aliqua sint ut tempor eiusmod excepteur.",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
