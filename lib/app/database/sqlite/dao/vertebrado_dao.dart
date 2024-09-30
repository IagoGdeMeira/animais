import 'package:animais/app/database/sqlite/connection.dart';
import 'package:animais/app/domain/dto/vertebrado_dto.dart';
import 'package:animais/app/domain/interface/vertebrado_idao.dart';
import 'package:sqflite/sqflite.dart';


class VertebradoDAO implements VertebradoIDAO {
  late Database _db;

  final inserirSQL = '''
    INSERT INTO vertebrado (animal_id, tamanho_da_coluna)
      VALUES (?, ?);
  ''';

  final alterarSQL = '''
    UPDATE vertebrado SET tamanho_da_coluna = ?
      WHERE animal_id = ?;
  ''';

  final consultarSQL = '''
    SELECT
      a.id,
      a.nome,
      a.expectativa_de_vida,
      a.url_avatar,
      a.descricao,
      a.status,
      v.tamanho_da_coluna
    FROM animal a
    INNER JOIN vertebrado v ON a.id = v.animal_id;
  ''';

  final consultarPorIdSQL = '''
    SELECT
      a.id,
      a.nome,
      a.expectativa_de_vida,
      a.url_avatar,
      a.descricao,
      a.status,
      v.tamanho_da_coluna
    FROM animal a
    INNER JOIN vertebrado v ON a.id = v.animal_id
    WHERE v.animal_id = ?;
  ''';

  @override
  Future<VertebradoDTO> salvar(VertebradoDTO dto) async {
    _db = await Connection.iniciar();
    dto.animalId = await _db.rawInsert(inserirSQL, [
      dto.animalId,
      dto.tamanhoDaColuna
    ]);
    
    return dto;
  }

  @override
  Future<VertebradoDTO> alterar(VertebradoDTO dto) async {
    _db = await Connection.iniciar();
    await _db.rawUpdate(alterarSQL, [
      dto.tamanhoDaColuna,
      dto.animalId
    ]);

    return dto;
  }
  
  @override
  Future<List<VertebradoDTO>> consultar() async {
    _db = await Connection.iniciar();
    var resultado = await _db.rawQuery(consultarSQL);

    List<VertebradoDTO> vertebrados = List.generate(resultado.length, (i) {
      var linha = resultado[i];

      return VertebradoDTO(
        animalId: linha['id'],
        tamanhoDaColuna: double.parse(linha['tamanho_da_coluna'].toString())
      );
    });

    return vertebrados;
  }
  
  @override
  Future<VertebradoDTO> consultarPorId(int id) async {
    _db = await Connection.iniciar();
    var resultado = (await _db.rawQuery(consultarPorIdSQL, [id])).first;

    return VertebradoDTO(
      animalId: resultado['id'],
      tamanhoDaColuna: double.parse(resultado['tamanho_da_coluna'].toString())
    );
  }
}