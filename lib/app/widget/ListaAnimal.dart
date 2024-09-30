import 'package:flutter/material.dart';
import 'package:animais/app/application/AnimalApplication.dart';
import 'package:animais/app/domain/dto/animal_dto.dart';

class ListaAnimal extends StatelessWidget {
  const ListaAnimal({super.key});

  CircleAvatar circleAvatar(String? url) {
    var avatar = const CircleAvatar(child: Icon(Icons.pets));
    if (url != null) {
      var uri = Uri.tryParse(url);
      if (uri != null && uri.isAbsolute) {
        avatar = CircleAvatar(backgroundImage: NetworkImage(url));
      }
    }
    return avatar;
  }

  Widget iconEditButton(VoidCallback onPressed) {
    return IconButton(icon: const Icon(Icons.edit), color: Colors.orange, onPressed: onPressed);
  }

  Widget iconRemoveButton(BuildContext context, VoidCallback remove) {
    return IconButton(
      icon: const Icon(Icons.delete),
      color: Colors.red,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Excluir'),
            content: const Text('Confirma a exclusão?'),
            actions: [
              TextButton(
                child: const Text('Não'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: remove,
                child: const Text('Sim'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var apAnimal = APAnimal();
    var lista = apAnimal.consultar();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Animais'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navegar para o formulário de adicionar novo animal
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: lista,
        builder: (BuildContext context, AsyncSnapshot<List<AnimalDTO>> futuro) {
          if (!futuro.hasData || futuro.data == null) {
            return const CircularProgressIndicator();
          } else {
            List<AnimalDTO> lista = futuro.data!;
            return ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, i) {
                var animal = lista[i];
                return ListTile(
                  leading: circleAvatar(animal.urlAvatar),
                  title: Text(animal.nome),
                  subtitle: Text(animal.descricao ?? ''),
                  onTap: () {
                    // Navegar para detalhes do animal
                  },
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        iconEditButton(() {
                          // Editar o animal
                        }),
                        iconRemoveButton(context, () {
                          // Remover o animal
                        }),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
