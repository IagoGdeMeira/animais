class AnimalDTO {
  dynamic id;
  final String status;
  final String nome;
  final int expectativaDeVida;
  final String? urlAvatar;
  final String? descricao;

  AnimalDTO({
    this.id,
    required this.status,
    required this.nome,
    required this.expectativaDeVida,
    this.urlAvatar,
    this.descricao
  });
}