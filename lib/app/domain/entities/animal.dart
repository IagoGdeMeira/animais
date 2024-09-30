import 'package:animais/app/domain/dto/animal_dto.dart';
import 'package:animais/app/domain/interface/animal_idao.dart';


class Animal {
  dynamic _id;
  String _status = 'A';
  String? _nome;
  int? _expectativaDeVida;
  String? _urlAvatar;
  String? _descricao;

  AnimalIDAO animalDAO;
  
  Animal({ required this.animalDAO });

  validar({ required AnimalDTO dto }) {
    status = dto.status;
    nome = dto.nome;
    expectativaDeVida = dto.expectativaDeVida;
    descricao = dto.descricao;
    urlAvatar = dto.urlAvatar;
  }

  Future<AnimalDTO> salvar(AnimalDTO dto) async {
    validar(dto: dto);
    return await animalDAO.salvar(dto);
  }

  Future<AnimalDTO> alterar(dynamic id) async {
    this.id = id;
    return await animalDAO.alterar(_id);
  }

  Future<bool> excluir(dynamic id) async {
    this.id = id;
    await animalDAO.alterarStatus(_id);
    return true;
  }

  Future<List<AnimalDTO>> consultar() async {
    return await animalDAO.consultar();
  }



  String? get status => _status;
  String? get nome => _nome;
  int? get expectativaDeVida => _expectativaDeVida;
  String? get descricao => _descricao;
  String? get urlAvatar => _urlAvatar;

  set id(int? id){
    if(id == null) throw Exception('ID não pode ser nulo');
    if(id < 0) throw Exception('ID não pode ser negativo');
    _id = id;
  }

  set status(String? status) {
    if(status == null) throw Exception('Status não pode ser nulo.');
    if(status != 'A' || status != 'I') throw Exception('Status deve ser "A" ou "I".');
    _status = status;
  }

  set nome(String? nome) {
    if(nome == null) throw Exception('Nome não pode ser nulo.');
    if(nome.isEmpty) throw Exception('Nome não pode ser vazio.');
    _nome = nome;
  }

  set expectativaDeVida(int? expectativaDeVida) {
    if(expectativaDeVida == null) throw Exception('Expectativa de vida não pode ser nula.');
    _expectativaDeVida = expectativaDeVida;
  }

  set descricao(String? descricao) {
    if(descricao == null) throw Exception('Nome não pode ser nulo.');
    _descricao = descricao;
  }

  set urlAvatar(String? urlAvatar) {
    if(urlAvatar == null) throw Exception('URL não pode ser nulo.');
    _urlAvatar = urlAvatar;
  }
}