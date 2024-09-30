import 'package:animais/app/domain/dto/vertebrado_dto.dart';


abstract class VertebradoIDAO {
  Future<VertebradoDTO> salvar(VertebradoDTO dto);
  Future<VertebradoDTO> alterar(VertebradoDTO dto);
  Future<VertebradoDTO> consultarPorId(int id);
  Future<List<VertebradoDTO>> consultar();
}