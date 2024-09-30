import 'package:animais/app/domain/dto/vertebrado_dto.dart';
import 'package:animais/app/domain/interface/vertebrado_idao.dart';
import 'package:animais/app/domain/entities/animal.dart';


class Vertebrado extends Animal {
  double? _tamanhoDaColuna;
  VertebradoIDAO vertebradoDAO;

  Vertebrado({ required this.vertebradoDAO, required super.animalDAO });
  
  void validarVertebrado({ required VertebradoDTO dto }) {
    tamanhoDaColuna = dto.tamanhoDaColuna;
  }

  Future<VertebradoDTO> salvarVertebrado(VertebradoDTO dto) async {
    validarVertebrado(dto: dto);
    return await vertebradoDAO.salvar(dto);
  }

  Future<VertebradoDTO> alterarVertebrado(dynamic id) async {
    this.id = id;
    return await vertebradoDAO.alterar(id);
  }

  Future<List<VertebradoDTO>> consultarVertebrado() async {
    return await vertebradoDAO.consultar();
  }

  Future<VertebradoDTO> consultarVertebradoPorId(dynamic id) async {
    this.id = id;
    return await vertebradoDAO.consultarPorId(id);
  }

  double? get tamanhoDaColuna => _tamanhoDaColuna;

  set tamanhoDaColuna(double? valor) {
    if (valor == null) throw Exception('Tamanho da coluna não pode ser nulo.');
    if (valor <= 0) throw Exception('Tamanho da coluna deve ser maior que zero.');
    _tamanhoDaColuna = valor;
  }
}