import 'package:animais/app/domain/dto/animal_dto.dart';


abstract class AnimalIDAO {
  Future<AnimalDTO> salvar(AnimalDTO dto);
  Future<AnimalDTO> alterar(AnimalDTO dto);
  Future<bool> alterarStatus(int id);
  Future<AnimalDTO> consultarPorId(int id);
  Future<List<AnimalDTO>> consultar();
}