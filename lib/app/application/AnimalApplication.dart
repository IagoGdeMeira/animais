import 'package:animais/app/database/sqlite/dao/animal_dao.dart';
import 'package:animais/app/domain/dto/animal_dto.dart';
import 'package:animais/app/domain/interface/animal_idao.dart';
import 'package:animais/app/domain/entities/animal.dart';

class AnimalApplication {
  late AnimalIDAO dao;
  late Animal domain;

  AnimalApplication() {
    dao = AnimalDAO();
    domain = Animal(animalDAO: dao);
  }

  Future<AnimalDTO> salvar(AnimalDTO dto) async {
    return await domain.salvar(dto);
  }

  Future<AnimalDTO> alterar(dynamic id) async {
    return await domain.alterar(id);
  }

  Future<bool> excluir(dynamic id) async {
    await domain.excluir(id);
    return true;
  }

  Future<List<AnimalDTO>> consultar() async {
    return await domain.consultar();
  }
}
