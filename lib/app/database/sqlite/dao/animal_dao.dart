import 'package:animais/app/database/sqlite/connection.dart';
import 'package:animais/app/domain/dto/animal_dto.dart';
import 'package:animais/app/domain/interface/animal_idao.dart';
import 'package:sqflite/sqflite.dart';


class AnimalDAO implements AnimalIDAO {
  late Database _db;

  final inserirSQL = '''
    INSERT INTO animal (nome, expectativa_de_vida, url_avatar, descricao, status)
      VALUES (?, ?, ?, ?, ?);
  ''';

  final alterarSQL = '''
    UPDATE animal SET nome = ?, expectativa_de_vida = ?, url_avatar = ?, descricao = ?, status = ?
      WHERE id = ?;
  ''';

  final alterarStatusSQL = '''
    UPDATE animal SET status = 'I'
      WHERE id = ?;
  ''';

  final consultarPorIdSQL = '''
    SELECT * FROM animal WHERE id = ?;
  ''';

  final consultarSQL = '''
    SELECT * FROM animal;
  ''';

  @override
  Future<AnimalDTO> salvar(AnimalDTO dto) async {
    _db = await Connection.iniciar();
    dto.id = await _db.rawInsert(inserirSQL, [
      dto.nome,
      dto.expectativaDeVida,
      dto.urlAvatar,
      dto.descricao,
      dto.status
    ]);
    
    return dto;
  }

  @override
  Future<AnimalDTO> alterar(AnimalDTO dto) async {
    _db = await Connection.iniciar();
    await _db.rawUpdate(alterarSQL, [
      dto.nome,
      dto.expectativaDeVida,
      dto.urlAvatar,
      dto.descricao,
      dto.status,
      dto.id
    ]);

    return dto;
  }

  @override
  Future<bool> alterarStatus(int id) async {
    _db = await Connection.iniciar();
    await _db.rawUpdate(alterarStatusSQL, [id]);

    return true;
  }

  @override
  Future<List<AnimalDTO>> consultar() async {
    _db = await Connection.iniciar();
    var resultado = await _db.rawQuery(consultarSQL);

    List<AnimalDTO> animais = List.generate(resultado.length, (i) {
      var linha = resultado[i];

      return AnimalDTO(
        id: linha['id'], 
        nome: linha['nome'].toString(), 
        descricao: linha['descricao'].toString(), 
        expectativaDeVida: int.parse(linha['expectativa_de_vida'].toString()), 
        urlAvatar: linha['url_avatar'].toString(), 
        status: linha['status'].toString()
      );
    });

    return animais;
  }

  @override
  Future<AnimalDTO> consultarPorId(int id) async {
    _db = await Connection.iniciar();
    var resultado = (await _db.rawQuery(consultarPorIdSQL,[id])).first;

    return AnimalDTO(
      id: resultado['id'], 
      nome: resultado['nome'].toString(), 
      descricao: resultado['descricao'].toString(), 
      expectativaDeVida: int.parse(resultado['expectativa_de_vida'].toString()),
      urlAvatar: resultado['url_avatar'].toString(), 
      status: resultado['status'].toString()
    );
  }
}