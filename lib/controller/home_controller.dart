import 'package:flutter/material.dart';
import 'package:jsxpro/view/detalhescurso_screen.dart';

class HomeController {
  final BuildContext context;

  HomeController(this.context);

  bottomMenuClick(int value, PageController pc) {
    pc.animateToPage(value,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubicEmphasized);
  }

  String descricaoReduce(String descricao) {
    String newStr = '';
    if (descricao.length >= 100) {
      newStr = "${descricao.substring(0, 100)} ler mais...";
    } else {
      newStr = descricao;
    }
    return newStr;
  }

  clickCursosRecentes(int id) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, _) {
          return DetalhesCursoScreen(
            cursoInformacoes: {},
          );
        },
        opaque: false,
      ),
    );
  }
}
