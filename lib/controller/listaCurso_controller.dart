// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:jsxpro/view/detalhescurso_screen.dart';

class ListaCursoController {
  final BuildContext context;

  ListaCursoController({
    required this.context,
  });

  clickToCurse(Map curse) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, _) {
          return DetalhesCursoScreen(
            cursoInformacoes: curse,
          );
        },
        opaque: false,
      ),
    );
  }
}
