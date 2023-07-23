class EventosController {
  String descricaoReduce(String descricao) {
    String newStr = '';
    if (descricao.length > 100) {
      newStr = "${descricao.substring(0, 100)} ler mais...";
    }
    return newStr;
  }
}
