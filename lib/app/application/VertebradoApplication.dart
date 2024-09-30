import 'package:animais/app/database/sqlite/dao/animal_dao.dart';
import 'package:animais/app/database/sqlite/dao/vertebrado_dao.dart';
import 'package:animais/app/domain/dto/vertebrado_dto.dart';
import 'package:animais/app/domain/interface/vertebrado_idao.dart';
import 'package:animais/app/domain/entities/vertebrado.dart';


class VertebradoApplication {
  late VertebradoIDAO dao;
  late Vertebrado domain;

  VertebradoApplication() {
    dao = VertebradoDAO();
    domain = Vertebrado(vertebradoDAO: dao, animalDAO: AnimalDAO());
  }

  Future<VertebradoDTO> salvar(VertebradoDTO dto) async {
    return await domain.salvarVertebrado(dto);
  }

  Future<VertebradoDTO> alterar(dynamic id) async {
    return await domain.alterarVertebrado(id);
  }

  Future<List<VertebradoDTO>> consultar() async {
    return await domain.consultarVertebrado();
  }

  Future<VertebradoDTO> consultarPorId(int id) async {
    return await domain.consultarVertebradoPorId(id);
  }
}