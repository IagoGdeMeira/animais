const createTables = [
  '''
    CREATE TABLE animal(
      id INTEGER NOT NULL PRIMARY KEY,
      nome VARCHAR(200) NOT NULL,
      expectativa_de_vida INTEGER NOT NULL,
      url_avatar VARCHAR(300) NULL,
      descricao TEXT NULL,
      status CHAR(1) NOT NULL
    );
  ''',

  '''
    CREATE TABLE vertebrado(
      animal_id INTEGER NOT NULL PRIMARY KEY,
      tamanho_da_coluna REAL NOT NULL,
      FOREIGN KEY (animal_id) REFERENCES animal(id) ON DELETE CASCADE
    );
  '''
];

const insertions = [
  '''
    INSERT INTO animal (nome, expectativa_de_vida, url_avatar, descricao, status)
    VALUES ('Elefante', 70, 'https://example.com/elefante.png', 'O maior mamífero terrestre', 'A');
  ''',

  '''
    INSERT INTO vertebrado (animal_id, tamanho_da_coluna)
    VALUES (LAST_INSERT_ROWID(), 3.0);
  ''',

  '''
    INSERT INTO animal (nome, expectativa_de_vida, url_avatar, descricao, status)
    VALUES ('Crocodilo', 40, 'https://example.com/crocodilo.png', 'Um predador antigo', 'A');
  ''',

  '''
    INSERT INTO vertebrado (animal_id, tamanho_da_coluna)
    VALUES (LAST_INSERT_ROWID(), 4.5);
  '''
];