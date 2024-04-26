import 'package:firebase_database/firebase_database.dart';
import 'package:utfpr/src/solicitacoes_feature/solicitacao_item.dart';

class SolicitacoesService {
  Future<String?> insert(Solicitacao solicitacao) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref("solicitacoes");
      DatabaseReference newPostRef = ref.push();

      await newPostRef.set(solicitacao.toJson());

      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> update(Solicitacao solicitacao) async {
    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("solicitacoes/${solicitacao.id}");

      await ref.update(solicitacao.toJson());

      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Solicitacao>> fetch() async {
    try {
      var solicitacoes = List<Solicitacao>.empty(growable: true);
      final document =
          await FirebaseDatabase.instance.ref('solicitacoes').get();

      for (var child in document.children) {
        final map = Map<String, dynamic>.from(child.value as Map);
        solicitacoes.add(Solicitacao.fromJson(map, child.key ?? ""));
      }

      return solicitacoes;
    } catch (e) {
      return List<Solicitacao>.empty();
    }
  }

  Future<String> delete(Solicitacao solicitacao) async {
    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("solicitacoes/${solicitacao.id}");

      await ref.remove();

      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }
}
