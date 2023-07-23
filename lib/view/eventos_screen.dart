import 'package:flutter/material.dart';
import 'package:jsxpro/controller/eventos_controller.dart';

import '../components/card_custom.dart';

class EventosScreen extends StatelessWidget {
  const EventosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EventosController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: Icon(
                    Icons.javascript,
                    color: Colors.black,
                    size: 50,
                  ),
                ),
                Text(
                  "Javascript",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 300,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                physics: const PageScrollPhysics(),
                itemCount: 11,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CardCustom(
                    titulo: 'Curso de Javascript $index',
                    descricao: controller.descricaoReduce(
                        'Pariatur magna irure quis magna tempor. Ex dolore cupidatat quis cupidatat laborum. Tempor proident amet cupidatat esse sint Lorem irure labore. Ea fugiat ullamco velit eiusmod cillum velit consequat fugiat nisi cupidatat.'),
                    image: "http://unsplash.it/250/300?random&gravity=center",
                    onPress: () {},
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    "TS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "Typescript",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 300,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                physics: const PageScrollPhysics(),
                itemCount: 11,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CardCustom(
                    titulo: 'Curso de Javascript $index',
                    descricao: controller.descricaoReduce(
                        'Pariatur magna irure quis magna tempor. Ex dolore cupidatat quis cupidatat laborum. Tempor proident amet cupidatat esse sint Lorem irure labore. Ea fugiat ullamco velit eiusmod cillum velit consequat fugiat nisi cupidatat.'),
                    image: "http://unsplash.it/250/300?random&gravity=center",
                    onPress: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
