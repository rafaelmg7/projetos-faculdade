USE campeonato_brasileiro;

CREATE TABLE campeonato(
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    codigo_campeonato INT NOT NULL AUTO_INCREMENT,
    
    PRIMARY KEY (codigo_campeonato)
);

CREATE TABLE clube(
	codigo_time INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    
    PRIMARY KEY (codigo_time)
);

CREATE TABLE jogo(
	codigo_jogo INT NOT NULL AUTO_INCREMENT,
    data_jogo DATE NOT NULL,
    horario TIME NOT NULL,
    estadio VARCHAR(100) NOT NULL,
    rodada INT NOT NULL,
    codigo_mandante INT NOT NULL,
    codigo_visitante INT NOT NULL,
    gols_mandante INT NOT NULL,
    gols_visitante INT NOT NULL,
    
    PRIMARY KEY (codigo_jogo),
    FOREIGN KEY (codigo_mandante) REFERENCES
		clube(codigo_time) ON DELETE RESTRICT,
    FOREIGN KEY (codigo_visitante) REFERENCES 
		clube(codigo_time) ON DELETE RESTRICT
);

CREATE TABLE funcionario(
	codigo_funcionario BIGINT NOT NULL,
    codigo_time INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    idade INT,
    salario DOUBLE NOT NULL,
    nacionalidade VARCHAR(50),
    data_nascimento DATE NOT NULL,
    altura DOUBLE,
    peso DOUBLE,
    posicao VARCHAR(3),
    eTecnico INT NOT NULL,
    
    PRIMARY KEY(codigo_funcionario),
    FOREIGN KEY (codigo_time) REFERENCES clube(codigo_time) ON DELETE RESTRICT,
    
    CHECK ((eTecnico = 0 or eTecnico = 1)
        AND ((altura IS NOT NULL and peso IS NOT NULL AND posicao IS NOT NULL and eTecnico = 0))
            OR (altura IS NULL AND peso IS NULL AND posicao IS NULL AND eTecnico = 1))
);

CREATE TABLE participacao_time_campeonato(
    codigo_time INT NOT NULL,
    codigo_campeonato INT NOT NULL,
    pontos INT NOT NULL,
    vitorias INT NOT NULL,
    derrotas INT NOT NULL,
    empates INT NOT NULL,
    gols_pro INT NOT NULL,
    gols_contra INT NOT NULL,
    cartoes_amarelo INT,
    cartoes_vermelho INT,
    
	PRIMARY KEY (codigo_time, codigo_campeonato),
    FOREIGN KEY (codigo_time) REFERENCES clube(codigo_time),
    FOREIGN KEY (codigo_campeonato) REFERENCES campeonato(codigo_campeonato) ON DELETE RESTRICT,
    
    CHECK (vitorias + empates + derrotas = 38),
    
    CHECK (pontos = (vitorias * 3) + empates)
);

CREATE TABLE patrocinador(
	CNPJ VARCHAR(11) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    codigo_time INT NOT NULL,
    valor_patrocinio DOUBLE NOT NULL,
    ano_inicio YEAR NOT NULL,
    ano_fim YEAR NOT NULL,
    
    PRIMARY KEY (CNPJ, codigo_time),
    FOREIGN KEY (codigo_time) REFERENCES clube(codigo_time) ON DELETE CASCADE
);

CREATE TABLE titulo(
    codigo_titulo INT NOT NULL,
    ano INT NOT NULL,
    nome_titulo VARCHAR(50) NOT NULL,
    codigo_time INT NOT NULL,

    PRIMARY KEY (codigo_titulo),
    FOREIGN KEY (codigo_time) REFERENCES clube(codigo_time) ON DELETE RESTRICT
);

-- CHECK (FORALL (SELECT codigo_clube, COUNT(*) AS count
--               FROM participacao_time_campeonato
--               GROUP BY codigo_clube
--               HAVING count > 1)
--       NO ROWS);
       
-- CHECK (FORALL (SELECT codigo_campeonato
--               FROM jogo
--               WHERE codigo_campeonato NOT IN (SELECT codigo_campeonato FROM campeonato))
--       NO ROWS);
       
-- CHECK (FORALL (SELECT codigo_funcionario, COUNT(*) AS count
--               FROM clube
--               GROUP BY codigo_funcionario
--               HAVING count > 1)
--       NO ROWS);

-- INSERÇÃO DE CAMPEONATO:
INSERT INTO campeonato(data_inicio, data_fim) VALUES ('2023-04-30', '2023-12-15');

-- INSERÇÃO DE CLUBES:
INSERT INTO clube VALUES (1, 'Sion Futebol Clube', 'ES');
INSERT INTO clube VALUES (2, 'Bonfim Esporte Clube', 'MT');
INSERT INTO clube VALUES (3, 'Santa Esporte Clube', 'SP');
INSERT INTO clube VALUES (4, 'Cônego Esporte Clube', 'MG');
INSERT INTO clube VALUES (5, 'Vila Futebol Clube', 'RJ');
INSERT INTO clube VALUES (6, 'Marajó Esporte Clube', 'PE');
INSERT INTO clube VALUES (7, 'Planalto Esporte Clube', 'AM');
INSERT INTO clube VALUES (8, 'Marieta Futebol Clube', 'AM');
INSERT INTO clube VALUES (9, 'Vila Futebol Clube', 'DF');
INSERT INTO clube VALUES (10, 'Vila Esporte Clube', 'AC');
INSERT INTO clube VALUES (11, 'Conjunto Futebol Clube', 'RJ');
INSERT INTO clube VALUES (12, 'Vila Esporte Clube', 'AP');
INSERT INTO clube VALUES (13, 'Minas Futebol Clube', 'MS');
INSERT INTO clube VALUES (14, 'Jardim Futebol Clube', 'AL');
INSERT INTO clube VALUES (15, 'Vila Esporte Clube', 'MG');
INSERT INTO clube VALUES (16, 'Araguaia Esporte Clube', 'ES');
INSERT INTO clube VALUES (17, 'Conjunto Futebol Clube', 'MA');
INSERT INTO clube VALUES (18, 'Fernão Futebol Clube', 'MA');
INSERT INTO clube VALUES (19, 'Vila Futebol Clube', 'RR');
INSERT INTO clube VALUES (20, 'São Futebol Clube', 'SE');

SELECT * FROM clube;

-- INSERÇÃO DE JOGOS:
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-18', '08:00:36', 'Estádio Eum Sit', 1, 1, 2, 2, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-23', '05:04:01', 'Estádio Eius Maxime', 2, 1, 3, 5, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-22', '09:18:44', 'Estádio Provident Nisi', 3, 1, 4, 3, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-25', '02:51:35', 'Estádio Placeat Quia', 4, 1, 5, 7, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-30', '17:21:20', 'Estádio Qui Provident', 5, 1, 6, 6, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-19', '08:38:57', 'Estádio Molestias Tenetur', 6, 1, 7, 1, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-02', '06:20:30', 'Estádio Voluptatibus Dolorem', 7, 1, 8, 7, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-18', '05:39:45', 'Estádio Nisi Rem', 8, 1, 9, 8, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-06', '21:23:40', 'Estádio Amet Facilis', 9, 1, 10, 2, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-28', '03:57:50', 'Estádio Aspernatur Placeat', 10, 1, 11, 8, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-27', '10:48:28', 'Estádio Accusantium Sequi', 11, 1, 12, 8, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-20', '14:07:16', 'Estádio Praesentium In', 12, 1, 13, 7, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-04', '23:59:02', 'Estádio A Tenetur', 13, 1, 14, 3, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-17', '11:22:36', 'Estádio Soluta Eum', 14, 1, 15, 0, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-02', '09:00:46', 'Estádio Quibusdam Praesentium', 15, 1, 16, 6, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-14', '06:57:44', 'Estádio Repudiandae Veniam', 16, 1, 17, 7, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-26', '23:04:52', 'Estádio Animi Quod', 17, 1, 18, 5, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-08', '21:15:47', 'Estádio Amet Ad', 18, 1, 19, 8, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-10', '12:06:55', 'Estádio Assumenda Similique', 19, 1, 20, 8, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-03', '04:25:59', 'Estádio Expedita Magnam', 20, 2, 1, 1, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-03', '19:47:01', 'Estádio Quo Provident', 1, 2, 3, 8, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-30', '05:13:15', 'Estádio Cupiditate Laborum', 2, 2, 4, 5, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-30', '05:38:17', 'Estádio Odit Dolorem', 3, 2, 5, 4, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-08', '00:08:08', 'Estádio Cumque Rem', 4, 2, 6, 0, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-23', '01:25:37', 'Estádio Optio Consequuntur', 5, 2, 7, 1, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-23', '06:13:33', 'Estádio Quas Reprehenderit', 6, 2, 8, 7, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-25', '08:53:03', 'Estádio Quos Voluptatum', 7, 2, 9, 8, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-10', '16:26:41', 'Estádio Quod Consectetur', 8, 2, 10, 4, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-13', '14:35:48', 'Estádio In Laborum', 9, 2, 11, 0, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-02', '09:53:52', 'Estádio Hic Odit', 10, 2, 12, 7, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-01', '07:08:50', 'Estádio Optio Iste', 11, 2, 13, 6, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-18', '00:07:59', 'Estádio Sit Facere', 12, 2, 14, 2, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-25', '08:29:16', 'Estádio Ipsa Soluta', 13, 2, 15, 6, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-20', '22:00:25', 'Estádio Omnis Ipsa', 14, 2, 16, 5, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-22', '07:58:35', 'Estádio Excepturi Quos', 15, 2, 17, 6, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-20', '22:47:59', 'Estádio Modi Corrupti', 16, 2, 18, 8, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-05', '21:03:27', 'Estádio Suscipit Molestias', 17, 2, 19, 8, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-06', '05:42:43', 'Estádio Accusantium Et', 18, 2, 20, 7, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-08', '14:17:09', 'Estádio Delectus Consequuntur', 19, 3, 1, 0, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-14', '17:35:59', 'Estádio Sint Placeat', 20, 3, 2, 6, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-19', '06:44:26', 'Estádio Adipisci Impedit', 1, 3, 4, 7, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-12', '23:39:24', 'Estádio Occaecati Ea', 2, 3, 5, 4, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-26', '19:54:53', 'Estádio Nemo Non', 3, 3, 6, 3, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-08', '09:12:19', 'Estádio Similique Veniam', 4, 3, 7, 7, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-12', '16:11:50', 'Estádio Quam Omnis', 5, 3, 8, 0, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-26', '13:13:36', 'Estádio Voluptate Veritatis', 6, 3, 9, 4, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-21', '16:35:12', 'Estádio Eveniet Maiores', 7, 3, 10, 4, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-03', '08:03:54', 'Estádio Omnis Excepturi', 8, 3, 11, 4, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-11', '18:55:36', 'Estádio Dolorum Blanditiis', 9, 3, 12, 3, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-31', '22:44:41', 'Estádio Eligendi Placeat', 10, 3, 13, 2, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-10', '08:25:03', 'Estádio Qui Quidem', 11, 3, 14, 0, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-03', '18:09:43', 'Estádio Minus Soluta', 12, 3, 15, 7, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-11', '13:45:55', 'Estádio Laudantium Quis', 13, 3, 16, 8, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-21', '12:44:52', 'Estádio Labore Esse', 14, 3, 17, 1, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-01', '15:10:46', 'Estádio Ad Possimus', 15, 3, 18, 8, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-30', '12:24:49', 'Estádio Fugiat Quaerat', 16, 3, 19, 2, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-17', '07:58:08', 'Estádio Modi Modi', 17, 3, 20, 4, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-24', '15:45:32', 'Estádio Eius Nam', 18, 4, 1, 6, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-25', '08:46:10', 'Estádio Molestiae Exercitationem', 19, 4, 2, 7, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-16', '02:06:43', 'Estádio Iusto Fuga', 20, 4, 3, 2, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-31', '19:34:54', 'Estádio Minima Ratione', 1, 4, 5, 4, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-03', '06:38:57', 'Estádio Cum Excepturi', 2, 4, 6, 8, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-30', '10:21:40', 'Estádio Et Aperiam', 3, 4, 7, 3, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-04', '11:43:20', 'Estádio Dolorum Molestias', 4, 4, 8, 5, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-01', '03:48:43', 'Estádio Ratione Id', 5, 4, 9, 5, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-15', '20:46:23', 'Estádio Nisi Voluptate', 6, 4, 10, 3, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-10', '16:57:20', 'Estádio Consectetur At', 7, 4, 11, 3, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-03', '09:31:11', 'Estádio Reiciendis Laborum', 8, 4, 12, 8, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-18', '08:25:06', 'Estádio Magnam Vel', 9, 4, 13, 2, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-08', '06:39:10', 'Estádio A Soluta', 10, 4, 14, 0, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-10', '12:59:45', 'Estádio Molestiae Consectetur', 11, 4, 15, 3, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-16', '21:46:56', 'Estádio Cumque Consectetur', 12, 4, 16, 4, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-04', '11:16:46', 'Estádio Placeat Quisquam', 13, 4, 17, 0, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-11', '15:35:20', 'Estádio Totam Quaerat', 14, 4, 18, 1, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-14', '20:10:50', 'Estádio Ipsa Quos', 15, 4, 19, 4, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-01', '06:45:10', 'Estádio Enim Maiores', 16, 4, 20, 8, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-19', '02:24:47', 'Estádio Illo Suscipit', 17, 5, 1, 0, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-20', '16:00:33', 'Estádio Architecto Quis', 18, 5, 2, 3, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-05', '06:44:39', 'Estádio Tenetur Sed', 19, 5, 3, 4, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-04', '11:13:18', 'Estádio Voluptate Iure', 20, 5, 4, 4, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-25', '12:34:50', 'Estádio Dolorem Quo', 1, 5, 6, 6, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-01', '02:22:28', 'Estádio Deleniti Saepe', 2, 5, 7, 6, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-10', '04:48:54', 'Estádio Vitae Similique', 3, 5, 8, 4, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-03', '23:30:39', 'Estádio Odit Repellendus', 4, 5, 9, 8, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-28', '19:02:25', 'Estádio Iste Inventore', 5, 5, 10, 8, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-17', '13:18:44', 'Estádio Reiciendis Ipsam', 6, 5, 11, 2, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-28', '10:05:06', 'Estádio Fuga Vitae', 7, 5, 12, 3, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-12', '17:20:51', 'Estádio Labore Vel', 8, 5, 13, 4, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-07', '15:53:31', 'Estádio Quia Cupiditate', 9, 5, 14, 1, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-22', '06:02:55', 'Estádio Deserunt Iusto', 10, 5, 15, 3, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-16', '08:22:28', 'Estádio Dolores Quas', 11, 5, 16, 2, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-04', '01:55:57', 'Estádio In Earum', 12, 5, 17, 3, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-17', '12:57:16', 'Estádio Nihil Veniam', 13, 5, 18, 4, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-27', '03:54:58', 'Estádio Modi Iusto', 14, 5, 19, 6, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-10', '15:19:57', 'Estádio Ad Hic', 15, 5, 20, 1, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-09', '03:15:58', 'Estádio Hic Velit', 16, 6, 1, 3, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-31', '01:04:51', 'Estádio Fugit Nisi', 17, 6, 2, 7, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-22', '10:14:48', 'Estádio Debitis Distinctio', 18, 6, 3, 0, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-21', '03:48:18', 'Estádio Voluptas Possimus', 19, 6, 4, 6, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-04', '04:26:45', 'Estádio Expedita Possimus', 20, 6, 5, 6, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-21', '15:42:38', 'Estádio Ratione Voluptates', 1, 6, 7, 3, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-05', '17:34:49', 'Estádio Quos Veritatis', 2, 6, 8, 1, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-21', '16:15:07', 'Estádio Inventore Maxime', 3, 6, 9, 0, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-08', '23:56:56', 'Estádio Quae Aperiam', 4, 6, 10, 3, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-22', '04:58:28', 'Estádio Alias Distinctio', 5, 6, 11, 2, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-08', '16:12:53', 'Estádio Voluptas Ipsam', 6, 6, 12, 3, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-08', '13:56:17', 'Estádio Quo Voluptas', 7, 6, 13, 4, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-12', '00:38:31', 'Estádio Harum Illo', 8, 6, 14, 8, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-14', '02:57:18', 'Estádio Rerum Libero', 9, 6, 15, 3, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-26', '13:37:19', 'Estádio Fugiat Quos', 10, 6, 16, 1, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-23', '09:02:33', 'Estádio Consectetur Natus', 11, 6, 17, 3, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-30', '17:31:35', 'Estádio Sapiente Nulla', 12, 6, 18, 3, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-03', '22:35:21', 'Estádio Soluta Explicabo', 13, 6, 19, 6, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-26', '01:59:58', 'Estádio Illum Optio', 14, 6, 20, 8, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-11', '14:27:13', 'Estádio Dolore Voluptatem', 15, 7, 1, 7, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-03', '17:27:18', 'Estádio Nihil Dignissimos', 16, 7, 2, 6, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-14', '10:28:32', 'Estádio Pariatur Enim', 17, 7, 3, 5, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-02', '03:07:54', 'Estádio Voluptas Nulla', 18, 7, 4, 8, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-17', '06:23:04', 'Estádio Animi Consequuntur', 19, 7, 5, 5, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-10', '05:43:42', 'Estádio Dolor Laboriosam', 20, 7, 6, 8, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-18', '15:57:03', 'Estádio Est Necessitatibus', 1, 7, 8, 7, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-05', '10:35:48', 'Estádio Magnam Soluta', 2, 7, 9, 4, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-16', '11:14:15', 'Estádio Dolore Voluptatem', 3, 7, 10, 7, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-16', '10:37:33', 'Estádio Praesentium Voluptatum', 4, 7, 11, 1, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-19', '04:14:43', 'Estádio Hic Molestias', 5, 7, 12, 5, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-21', '16:40:40', 'Estádio Repellendus Sequi', 6, 7, 13, 3, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-15', '08:02:49', 'Estádio Laboriosam Aperiam', 7, 7, 14, 5, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-07', '19:34:54', 'Estádio Magni Pariatur', 8, 7, 15, 3, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-23', '07:30:40', 'Estádio Distinctio Vero', 9, 7, 16, 5, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-25', '07:02:12', 'Estádio Porro Ad', 10, 7, 17, 7, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-18', '09:44:18', 'Estádio Incidunt Dolorem', 11, 7, 18, 8, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-24', '16:35:43', 'Estádio Reiciendis Incidunt', 12, 7, 19, 6, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-18', '03:15:11', 'Estádio Repudiandae Eveniet', 13, 7, 20, 8, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-04', '03:59:39', 'Estádio Repellendus Laborum', 14, 8, 1, 7, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-22', '12:37:48', 'Estádio Nam Error', 15, 8, 2, 7, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-07', '14:37:59', 'Estádio Molestias Voluptas', 16, 8, 3, 1, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-19', '01:43:31', 'Estádio Nisi Voluptatum', 17, 8, 4, 6, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-06', '02:11:56', 'Estádio Aspernatur Alias', 18, 8, 5, 0, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-08', '06:04:15', 'Estádio Alias Deleniti', 19, 8, 6, 6, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-15', '01:35:06', 'Estádio Vitae Illum', 20, 8, 7, 6, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-09', '16:38:20', 'Estádio At Soluta', 1, 8, 9, 7, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-21', '18:17:06', 'Estádio Porro Voluptatum', 2, 8, 10, 2, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-18', '09:13:02', 'Estádio Quidem Architecto', 3, 8, 11, 8, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-03', '02:59:59', 'Estádio Tempore Sequi', 4, 8, 12, 0, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-04', '03:57:48', 'Estádio Eius Aliquam', 5, 8, 13, 3, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-17', '02:48:53', 'Estádio Quidem Alias', 6, 8, 14, 0, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-16', '02:23:51', 'Estádio Veniam Ipsam', 7, 8, 15, 7, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-12', '15:24:02', 'Estádio Necessitatibus Magnam', 8, 8, 16, 5, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-16', '03:57:04', 'Estádio Deleniti Sint', 9, 8, 17, 0, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-21', '06:38:37', 'Estádio Veritatis Vitae', 10, 8, 18, 6, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-12', '18:23:55', 'Estádio Est Sequi', 11, 8, 19, 8, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-28', '23:02:17', 'Estádio Omnis Illum', 12, 8, 20, 3, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-07', '17:25:33', 'Estádio Vitae Dolor', 13, 9, 1, 3, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-18', '12:38:54', 'Estádio Non Aliquid', 14, 9, 2, 8, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-05', '00:26:07', 'Estádio Molestias Quas', 15, 9, 3, 1, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-11', '07:47:33', 'Estádio Cupiditate Distinctio', 16, 9, 4, 5, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-02', '17:44:46', 'Estádio Alias A', 17, 9, 5, 0, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-19', '17:05:19', 'Estádio Ratione Molestias', 18, 9, 6, 0, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-01', '21:00:58', 'Estádio Ad Officiis', 19, 9, 7, 2, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-22', '20:58:27', 'Estádio Temporibus Sequi', 20, 9, 8, 4, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-19', '12:09:15', 'Estádio Sunt Odio', 1, 9, 10, 2, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-22', '17:25:33', 'Estádio Ipsam Vitae', 2, 9, 11, 6, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-21', '18:25:57', 'Estádio Ut Quae', 3, 9, 12, 5, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-15', '19:03:31', 'Estádio Quo Error', 4, 9, 13, 0, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-01', '05:18:14', 'Estádio Quae Quidem', 5, 9, 14, 8, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-29', '06:38:03', 'Estádio Optio Asperiores', 6, 9, 15, 0, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-25', '08:24:08', 'Estádio Incidunt Dignissimos', 7, 9, 16, 4, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-13', '19:45:47', 'Estádio Architecto Voluptatibus', 8, 9, 17, 5, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-05', '12:43:59', 'Estádio Necessitatibus Qui', 9, 9, 18, 7, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-16', '22:47:40', 'Estádio Sint Aut', 10, 9, 19, 3, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-09', '12:58:34', 'Estádio Cupiditate Rem', 11, 9, 20, 7, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-07', '10:07:01', 'Estádio Consequatur Temporibus', 12, 10, 1, 4, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-26', '18:15:17', 'Estádio Ipsam Atque', 13, 10, 2, 0, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-05', '07:34:58', 'Estádio Repellat Asperiores', 14, 10, 3, 8, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-08', '16:42:01', 'Estádio Repellat Distinctio', 15, 10, 4, 8, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-03', '22:38:29', 'Estádio Ipsa Iure', 16, 10, 5, 6, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-13', '17:35:51', 'Estádio Repellendus Dolorum', 17, 10, 6, 1, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-28', '03:59:14', 'Estádio Distinctio Doloremque', 18, 10, 7, 1, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-09', '16:09:49', 'Estádio Commodi Eaque', 19, 10, 8, 4, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-19', '02:53:59', 'Estádio Amet Sint', 20, 10, 9, 4, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-11', '11:28:33', 'Estádio Impedit Cumque', 1, 10, 11, 1, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-27', '00:40:48', 'Estádio Pariatur Necessitatibus', 2, 10, 12, 7, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-16', '21:36:23', 'Estádio Id Omnis', 3, 10, 13, 0, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-15', '16:32:51', 'Estádio Provident Delectus', 4, 10, 14, 0, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-26', '18:21:36', 'Estádio Eos Delectus', 5, 10, 15, 8, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-29', '02:31:05', 'Estádio Accusamus Voluptatibus', 6, 10, 16, 0, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-07', '14:01:49', 'Estádio Nulla Nesciunt', 7, 10, 17, 1, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-06', '13:51:52', 'Estádio Sunt Cumque', 8, 10, 18, 6, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-03', '17:51:01', 'Estádio Repellendus Quam', 9, 10, 19, 5, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-13', '23:10:14', 'Estádio Expedita Dicta', 10, 10, 20, 3, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-16', '03:54:48', 'Estádio Quia Illum', 11, 11, 1, 6, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-12', '20:51:34', 'Estádio Rerum Vel', 12, 11, 2, 8, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-10', '19:14:25', 'Estádio Officiis Libero', 13, 11, 3, 2, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-18', '07:12:58', 'Estádio Doloribus Velit', 14, 11, 4, 5, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-31', '19:04:45', 'Estádio Quos Est', 15, 11, 5, 0, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-01', '04:28:25', 'Estádio Veniam Aliquid', 16, 11, 6, 0, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-20', '03:48:40', 'Estádio Vitae Vel', 17, 11, 7, 2, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-07', '13:38:39', 'Estádio Iste Quidem', 18, 11, 8, 3, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-02', '00:57:37', 'Estádio Molestiae Numquam', 19, 11, 9, 3, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-08', '08:21:49', 'Estádio Vel Cum', 20, 11, 10, 6, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-29', '20:47:06', 'Estádio Ea Facere', 1, 11, 12, 7, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-05', '10:53:39', 'Estádio Inventore Nulla', 2, 11, 13, 0, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-12', '05:31:35', 'Estádio Ex Quibusdam', 3, 11, 14, 1, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-11', '11:47:07', 'Estádio Cupiditate Aperiam', 4, 11, 15, 5, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-10', '07:49:02', 'Estádio Debitis Repellat', 5, 11, 16, 6, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-10', '21:02:36', 'Estádio Enim Dicta', 6, 11, 17, 6, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-01', '11:24:49', 'Estádio Velit Suscipit', 7, 11, 18, 6, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-05', '10:25:38', 'Estádio Sit Mollitia', 8, 11, 19, 4, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-13', '15:42:09', 'Estádio Officia Explicabo', 9, 11, 20, 6, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-20', '02:57:52', 'Estádio Reiciendis Dicta', 10, 12, 1, 1, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-21', '01:50:04', 'Estádio Dolore Itaque', 11, 12, 2, 6, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-07', '21:37:18', 'Estádio Quidem Possimus', 12, 12, 3, 2, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-24', '02:43:02', 'Estádio Vero Neque', 13, 12, 4, 2, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-13', '02:36:05', 'Estádio Consequuntur Error', 14, 12, 5, 6, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-08', '06:47:36', 'Estádio Esse Qui', 15, 12, 6, 2, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-06', '07:02:28', 'Estádio Libero Error', 16, 12, 7, 8, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-15', '02:16:04', 'Estádio Occaecati Eius', 17, 12, 8, 4, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-17', '02:40:17', 'Estádio Incidunt Assumenda', 18, 12, 9, 4, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-08', '18:56:00', 'Estádio Voluptatum Fugiat', 19, 12, 10, 3, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-31', '02:09:23', 'Estádio Consequuntur Asperiores', 20, 12, 11, 8, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-09', '23:54:32', 'Estádio Officiis Deleniti', 1, 12, 13, 1, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-11', '13:55:46', 'Estádio Quidem Facilis', 2, 12, 14, 2, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-02', '18:19:03', 'Estádio Expedita Harum', 3, 12, 15, 5, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-04', '02:29:05', 'Estádio Vel Nostrum', 4, 12, 16, 6, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-16', '11:41:15', 'Estádio Cum Ullam', 5, 12, 17, 3, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-03', '20:36:38', 'Estádio Est Totam', 6, 12, 18, 4, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-04', '08:13:26', 'Estádio Molestias Minus', 7, 12, 19, 6, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-28', '15:28:36', 'Estádio Natus Ipsa', 8, 12, 20, 1, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-04', '22:30:08', 'Estádio Ducimus Dolore', 9, 13, 1, 1, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-16', '08:32:37', 'Estádio Magnam Neque', 10, 13, 2, 8, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-02', '23:32:25', 'Estádio Perferendis Molestiae', 11, 13, 3, 0, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-03', '02:58:58', 'Estádio Maxime Consectetur', 12, 13, 4, 6, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-23', '04:50:34', 'Estádio Debitis Laborum', 13, 13, 5, 4, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-28', '12:38:56', 'Estádio Excepturi Consequatur', 14, 13, 6, 0, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-09', '05:20:17', 'Estádio Debitis Repudiandae', 15, 13, 7, 6, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-26', '22:47:57', 'Estádio Nisi Molestias', 16, 13, 8, 0, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-14', '17:10:58', 'Estádio Incidunt Ullam', 17, 13, 9, 6, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-20', '19:37:59', 'Estádio Tempora Exercitationem', 18, 13, 10, 5, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-10', '22:19:09', 'Estádio Quis Quo', 19, 13, 11, 4, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-21', '10:27:05', 'Estádio Porro Magnam', 20, 13, 12, 7, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-30', '20:46:10', 'Estádio Dignissimos Sit', 1, 13, 14, 8, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-02', '05:27:02', 'Estádio Qui Voluptatibus', 2, 13, 15, 1, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-03', '16:39:37', 'Estádio Ut Reiciendis', 3, 13, 16, 7, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-21', '23:20:02', 'Estádio Laborum Quae', 4, 13, 17, 8, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-18', '19:21:31', 'Estádio Expedita Assumenda', 5, 13, 18, 0, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-12', '07:41:32', 'Estádio Totam Labore', 6, 13, 19, 0, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-08', '14:43:25', 'Estádio Totam Neque', 7, 13, 20, 1, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-11', '17:15:11', 'Estádio Dolor Quod', 8, 14, 1, 6, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-11', '21:39:23', 'Estádio Fugit Quas', 9, 14, 2, 2, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-18', '06:29:14', 'Estádio Praesentium Velit', 10, 14, 3, 4, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-03', '17:54:49', 'Estádio Amet Doloremque', 11, 14, 4, 3, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-24', '13:24:40', 'Estádio Sint Autem', 12, 14, 5, 3, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-02', '21:07:21', 'Estádio Error Optio', 13, 14, 6, 0, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-01', '23:20:43', 'Estádio Dicta Et', 14, 14, 7, 3, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-15', '18:54:46', 'Estádio Ad Id', 15, 14, 8, 7, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-23', '05:39:39', 'Estádio Accusamus Explicabo', 16, 14, 9, 4, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-23', '13:36:15', 'Estádio Iste Quae', 17, 14, 10, 3, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-15', '07:15:43', 'Estádio Dignissimos Enim', 18, 14, 11, 0, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-08', '06:10:40', 'Estádio Consequuntur Quidem', 19, 14, 12, 8, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-21', '22:36:51', 'Estádio Quisquam Tenetur', 20, 14, 13, 8, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-01', '16:39:24', 'Estádio Ducimus Accusamus', 1, 14, 15, 6, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-15', '04:27:07', 'Estádio Optio Dolor', 2, 14, 16, 8, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-03', '18:13:36', 'Estádio Eos Quisquam', 3, 14, 17, 5, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-13', '19:56:01', 'Estádio Accusantium Temporibus', 4, 14, 18, 0, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-27', '06:06:25', 'Estádio Ut Occaecati', 5, 14, 19, 1, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-20', '00:48:32', 'Estádio Alias Aliquid', 6, 14, 20, 8, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-11', '07:03:11', 'Estádio Nisi Dolores', 7, 15, 1, 3, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-06', '18:40:36', 'Estádio Quo Ipsa', 8, 15, 2, 7, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-11', '04:40:35', 'Estádio Ipsa Vitae', 9, 15, 3, 1, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-11', '22:42:37', 'Estádio Culpa Ipsam', 10, 15, 4, 2, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-14', '02:22:01', 'Estádio Ea Officiis', 11, 15, 5, 3, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-23', '20:44:12', 'Estádio Sunt Praesentium', 12, 15, 6, 7, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-04', '06:17:12', 'Estádio Dolor Animi', 13, 15, 7, 2, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-13', '13:31:47', 'Estádio Temporibus Quidem', 14, 15, 8, 5, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-01', '08:42:37', 'Estádio Est Soluta', 15, 15, 9, 4, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-15', '07:21:29', 'Estádio Doloribus Quaerat', 16, 15, 10, 3, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-24', '16:22:42', 'Estádio Hic Maxime', 17, 15, 11, 2, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-14', '22:42:20', 'Estádio Ipsum Recusandae', 18, 15, 12, 8, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-28', '17:49:42', 'Estádio Aspernatur Ab', 19, 15, 13, 4, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-05', '07:33:52', 'Estádio Alias Quam', 20, 15, 14, 0, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-23', '22:59:33', 'Estádio Ratione Hic', 1, 15, 16, 5, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-02', '18:59:29', 'Estádio Quidem Quibusdam', 2, 15, 17, 2, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-22', '22:38:20', 'Estádio Repudiandae Adipisci', 3, 15, 18, 2, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-12', '03:37:55', 'Estádio Harum Mollitia', 4, 15, 19, 0, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-16', '01:17:03', 'Estádio Nostrum Corrupti', 5, 15, 20, 5, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-15', '14:21:53', 'Estádio Quas Tempora', 6, 16, 1, 6, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-25', '01:49:04', 'Estádio Odio Cupiditate', 7, 16, 2, 6, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-20', '16:39:43', 'Estádio Voluptas Temporibus', 8, 16, 3, 3, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-01', '07:42:30', 'Estádio Illum Cum', 9, 16, 4, 0, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-14', '18:29:19', 'Estádio Cum Cumque', 10, 16, 5, 6, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-14', '14:11:12', 'Estádio Illo Possimus', 11, 16, 6, 7, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-28', '00:14:38', 'Estádio Magnam Quis', 12, 16, 7, 4, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-14', '10:57:49', 'Estádio Modi Blanditiis', 13, 16, 8, 4, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-27', '23:19:24', 'Estádio Dolores Delectus', 14, 16, 9, 3, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-28', '23:06:56', 'Estádio Eligendi Dolore', 15, 16, 10, 1, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-01', '06:50:05', 'Estádio Dignissimos Asperiores', 16, 16, 11, 0, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-14', '09:49:00', 'Estádio Officia Similique', 17, 16, 12, 3, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-10', '09:17:52', 'Estádio Delectus Explicabo', 18, 16, 13, 7, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-28', '10:48:32', 'Estádio Voluptate Consectetur', 19, 16, 14, 1, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-10', '09:43:19', 'Estádio Debitis Quae', 20, 16, 15, 6, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-20', '01:19:18', 'Estádio Aut Officia', 1, 16, 17, 3, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-17', '11:11:02', 'Estádio Eius Odit', 2, 16, 18, 2, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-14', '03:08:16', 'Estádio Quisquam Quam', 3, 16, 19, 0, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-21', '03:25:20', 'Estádio Beatae Porro', 4, 16, 20, 7, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-15', '05:22:56', 'Estádio Sed Provident', 5, 17, 1, 1, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-25', '02:13:46', 'Estádio Quas Corporis', 6, 17, 2, 5, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-23', '13:25:41', 'Estádio Ipsam Doloremque', 7, 17, 3, 0, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-03', '19:39:42', 'Estádio Est Error', 8, 17, 4, 7, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-26', '05:36:07', 'Estádio Cumque Expedita', 9, 17, 5, 4, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-05', '07:56:47', 'Estádio Nesciunt Doloremque', 10, 17, 6, 8, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-25', '14:50:26', 'Estádio Libero Temporibus', 11, 17, 7, 4, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-09', '05:52:46', 'Estádio Molestiae Ab', 12, 17, 8, 0, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-05', '20:50:05', 'Estádio Dolorem Deleniti', 13, 17, 9, 2, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-08', '13:52:11', 'Estádio Est Maxime', 14, 17, 10, 2, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-26', '16:50:28', 'Estádio Porro Iusto', 15, 17, 11, 8, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-18', '21:52:09', 'Estádio Cumque Maxime', 16, 17, 12, 0, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-24', '09:09:56', 'Estádio Culpa Asperiores', 17, 17, 13, 6, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-19', '01:10:13', 'Estádio Neque Expedita', 18, 17, 14, 4, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-23', '17:32:36', 'Estádio Laudantium Suscipit', 19, 17, 15, 8, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-06', '15:33:50', 'Estádio Esse Sunt', 20, 17, 16, 7, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-19', '11:10:26', 'Estádio Nulla Eius', 1, 17, 18, 2, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-07', '14:05:51', 'Estádio Veritatis Veritatis', 2, 17, 19, 6, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-04', '04:44:15', 'Estádio Delectus Odio', 3, 17, 20, 2, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-04', '20:14:47', 'Estádio Vero Atque', 4, 18, 1, 2, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-25', '14:15:02', 'Estádio Architecto Cumque', 5, 18, 2, 7, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-14', '12:26:54', 'Estádio Eveniet Laudantium', 6, 18, 3, 8, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-20', '15:12:30', 'Estádio Perferendis Quam', 7, 18, 4, 8, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-14', '12:27:41', 'Estádio Officiis Sunt', 8, 18, 5, 0, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-01', '08:27:51', 'Estádio Ipsam Deserunt', 9, 18, 6, 4, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-14', '11:02:46', 'Estádio A Unde', 10, 18, 7, 7, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-13', '02:07:43', 'Estádio Iste Itaque', 11, 18, 8, 0, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-29', '00:38:40', 'Estádio Voluptates Perferendis', 12, 18, 9, 7, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-16', '14:32:27', 'Estádio Iusto Sapiente', 13, 18, 10, 8, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-13', '05:48:20', 'Estádio Atque Eos', 14, 18, 11, 7, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-14', '11:22:35', 'Estádio Eum Beatae', 15, 18, 12, 0, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-22', '02:45:02', 'Estádio Sed Quis', 16, 18, 13, 0, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-14', '22:04:29', 'Estádio Nihil Adipisci', 17, 18, 14, 2, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-17', '17:28:10', 'Estádio Officia Excepturi', 18, 18, 15, 4, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-12', '12:17:14', 'Estádio Sint Corporis', 19, 18, 16, 0, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-07', '07:19:31', 'Estádio Ratione Adipisci', 20, 18, 17, 3, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-21', '13:51:00', 'Estádio Eos Repellat', 1, 18, 19, 5, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-28', '21:51:24', 'Estádio Aliquam Pariatur', 2, 18, 20, 4, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-07', '17:47:33', 'Estádio Sapiente Autem', 3, 19, 1, 6, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-19', '12:14:57', 'Estádio Nemo Suscipit', 4, 19, 2, 3, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-08', '14:18:12', 'Estádio Nam Vitae', 5, 19, 3, 0, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-02', '21:19:06', 'Estádio Neque Esse', 6, 19, 4, 2, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-05', '08:25:32', 'Estádio Maiores Rem', 7, 19, 5, 7, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-02', '15:10:55', 'Estádio Reprehenderit Quo', 8, 19, 6, 6, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-23', '20:17:36', 'Estádio Inventore Quaerat', 9, 19, 7, 7, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-26', '16:31:56', 'Estádio Cum Corporis', 10, 19, 8, 4, 5);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-07-14', '11:19:07', 'Estádio Recusandae Maiores', 11, 19, 9, 7, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-23', '15:45:25', 'Estádio Aliquid Laudantium', 12, 19, 10, 3, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-13', '00:37:50', 'Estádio Aliquid Reprehenderit', 13, 19, 11, 2, 8);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-23', '03:52:32', 'Estádio Vero Quae', 14, 19, 12, 4, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-25', '08:07:21', 'Estádio Rem Voluptas', 15, 19, 13, 3, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-25', '13:19:34', 'Estádio Labore Ea', 16, 19, 14, 8, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-17', '21:32:17', 'Estádio Quia Sequi', 17, 19, 15, 8, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-22', '10:21:55', 'Estádio Quaerat Quasi', 18, 19, 16, 6, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-09-24', '14:56:46', 'Estádio Modi Cum', 19, 19, 17, 3, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-21', '13:21:57', 'Estádio Corrupti Explicabo', 20, 19, 18, 1, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-08', '16:06:26', 'Estádio Quibusdam Beatae', 1, 19, 20, 4, 2);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-02', '00:09:52', 'Estádio Minus Officiis', 2, 20, 1, 3, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-03', '18:30:07', 'Estádio Accusantium Tenetur', 3, 20, 2, 2, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-15', '23:09:58', 'Estádio Ratione Necessitatibus', 4, 20, 3, 0, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-23', '14:05:36', 'Estádio Nemo Ab', 5, 20, 4, 3, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-29', '10:08:43', 'Estádio Rerum Saepe', 6, 20, 5, 7, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-14', '00:35:26', 'Estádio Eveniet Neque', 7, 20, 6, 8, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-03', '16:47:18', 'Estádio Hic Quas', 8, 20, 7, 7, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-04-27', '05:17:04', 'Estádio Sed Modi', 9, 20, 8, 2, 0);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-13', '12:39:46', 'Estádio Eum Voluptatem', 10, 20, 9, 0, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-01-07', '06:48:19', 'Estádio Repellat Ab', 11, 20, 10, 2, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-02-17', '16:06:53', 'Estádio Minus Voluptates', 12, 20, 11, 1, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-08-26', '10:17:48', 'Estádio Labore Rerum', 13, 20, 12, 6, 1);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-03-14', '18:59:38', 'Estádio Veritatis Reprehenderit', 14, 20, 13, 3, 3);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-12-17', '04:33:18', 'Estádio Eligendi Magnam', 15, 20, 14, 8, 4);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-05-20', '11:26:05', 'Estádio Porro Quas', 16, 20, 15, 1, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-19', '01:16:44', 'Estádio Consequatur Assumenda', 17, 20, 16, 3, 6);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-06-08', '16:58:28', 'Estádio Quidem Dolore', 18, 20, 17, 0, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-11-24', '21:40:53', 'Estádio Aperiam Beatae', 19, 20, 18, 4, 7);
INSERT INTO jogo(data_jogo, horario, estadio, rodada, codigo_mandante, codigo_visitante, gols_mandante, gols_visitante) VALUES ('2023-10-21', '01:15:03', 'Estádio Amet Assumenda', 20, 20, 19, 0, 0);

-- INSERCAO DE TITULOS
INSERT INTO titulo VALUES (885155, 2000, 'BRASILEIRAO', 1);
INSERT INTO titulo VALUES (255206, 2001, 'BRASILEIRAO', 2);
INSERT INTO titulo VALUES (135064, 2002, 'BRASILEIRAO', 3);
INSERT INTO titulo VALUES (305006, 2003, 'BRASILEIRAO', 4);
INSERT INTO titulo VALUES (745325, 2004, 'BRASILEIRAO', 5);
INSERT INTO titulo VALUES (983722, 2005, 'BRASILEIRAO', 6);
INSERT INTO titulo VALUES (900448, 2006, 'BRASILEIRAO', 7);
INSERT INTO titulo VALUES (760044, 2007, 'BRASILEIRAO', 8);
INSERT INTO titulo VALUES (284455, 2008, 'BRASILEIRAO', 9);
INSERT INTO titulo VALUES (104777, 2009, 'BRASILEIRAO', 10);
INSERT INTO titulo VALUES (378945, 2010, 'BRASILEIRAO', 1);
INSERT INTO titulo VALUES (479370, 2011, 'BRASILEIRAO', 2);
INSERT INTO titulo VALUES (827105, 2012, 'BRASILEIRAO', 3);
INSERT INTO titulo VALUES (838876, 2013, 'BRASILEIRAO', 4);
INSERT INTO titulo VALUES (171402, 2014, 'BRASILEIRAO', 5);
INSERT INTO titulo VALUES (974024, 2015, 'BRASILEIRAO', 6);
INSERT INTO titulo VALUES (411365, 2016, 'BRASILEIRAO', 7);
INSERT INTO titulo VALUES (407285, 2017, 'BRASILEIRAO', 8);
INSERT INTO titulo VALUES (241912, 2018, 'BRASILEIRAO', 9);
INSERT INTO titulo VALUES (811430, 2019, 'BRASILEIRAO', 10);

-- INSERCAO DE FUNCIONARIOS
INSERT INTO funcionario VALUES (59260314860, 1, 'Arthur Ferreira', 75, 2184391.00, 'Taiwan', '1971-04-18', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (31980675295, 1, 'Vinicius Moraes', 42, 197186.00, 'Guiana', '1977-04-02', 1.75, 74.00, 'PD', 0);
INSERT INTO funcionario VALUES (81657230902, 1, 'Vicente da Costa', 57, 1197114.00, 'Etiópia', '1971-09-22', 1.72, 78.00, 'VOL', 0);
INSERT INTO funcionario VALUES (69837251077, 1, 'Paulo Cardoso', 53, 2307293.00, 'Mayotte', '1976-07-05', 1.69, 66.00, 'ATA', 0);
INSERT INTO funcionario VALUES (57248160911, 1, 'Otávio Freitas', 41, 538505.00, 'Belize', '1957-04-15', 1.87, 99.00, 'PD', 0);
INSERT INTO funcionario VALUES (21930657480, 1, 'Nathan Novaes', 48, 2083311.00, 'Antilhas Holandesas', '1964-05-19', 1.85, 70.00, 'GOL', 0);
INSERT INTO funcionario VALUES (76398510259, 1, 'Marcelo Araújo', 74, 1197148.00, 'Andorra', '1954-12-19', 1.95, 84.00, 'PE', 0);
INSERT INTO funcionario VALUES (31496502752, 1, 'Nicolas Fogaça', 59, 367338.00, 'Nauru', '1973-01-25', 1.97, 70.00, 'PE', 0);
INSERT INTO funcionario VALUES (80926314769, 1, 'Paulo Alves', 54, 2421082.00, 'Trindade e Tobago', '1974-03-03', 1.68, 85.00, 'CA', 0);
INSERT INTO funcionario VALUES (73105624880, 1, 'Matheus Santos', 63, 725832.00, 'Sudão', '1965-02-19', 1.89, 71.00, 'LE', 0);
INSERT INTO funcionario VALUES (63875240162, 1, 'Enzo Gabriel Barbosa', 73, 819881.00, 'Estônia', '1969-05-18', 1.60, 92.00, 'ATA', 0);
INSERT INTO funcionario VALUES (96801752359, 1, 'Emanuel Rodrigues', 42, 1534266.00, 'Seicheles', '1961-08-18', 1.69, 67.00, 'GOL', 0);
INSERT INTO funcionario VALUES (20316485780, 1, 'Lucas Mendes', 47, 952379.00, 'Costa do Marfim', '1965-07-20', 1.92, 74.00, 'LE', 0);
INSERT INTO funcionario VALUES (64132789004, 1, 'João Gabriel Freitas', 54, 1839300.00, 'São Tomé e Príncipe', '1951-11-09', 1.74, 82.00, 'VOL', 0);
INSERT INTO funcionario VALUES (17408952314, 1, 'Nicolas Moraes', 57, 2104641.00, 'Granada', '1977-08-04', 1.93, 84.00, 'GOL', 0);
INSERT INTO funcionario VALUES (43092571606, 1, 'Paulo Correia', 40, 155935.00, 'Eslovênia', '1966-11-28', 1.72, 83.00, 'LD', 0);
INSERT INTO funcionario VALUES (89451623051, 1, 'João Lucas Rezende', 42, 395069.00, 'Eritreia', '1968-04-09', 1.95, 69.00, 'VOL', 0);
INSERT INTO funcionario VALUES (13504798610, 1, 'Kaique Santos', 52, 588975.00, 'Roménia', '1977-07-22', 1.63, 76.00, 'PE', 0);
INSERT INTO funcionario VALUES (85960213451, 1, 'Luigi Monteiro', 70, 2451572.00, 'Arábia Saudita', '1973-02-12', 1.62, 82.00, 'MEI', 0);
INSERT INTO funcionario VALUES (53984216700, 1, 'Gustavo Henrique da Luz', 70, 1589462.00, 'Honduras', '1981-12-19', 1.94, 74.00, 'LE', 0);
INSERT INTO funcionario VALUES (26183059730, 1, 'João Gabriel Araújo', 54, 1459413.00, 'Coral Sea Islands', '1949-05-31', 1.82, 72.00, 'VOL', 0);
INSERT INTO funcionario VALUES (17594826337, 1, 'Rafael Costa', 66, 124688.00, 'Tokelau', '1972-09-14', 1.65, 80.00, 'PE', 0);
INSERT INTO funcionario VALUES (95172436855, 1, 'Bruno Cunha', 58, 729580.00, 'Ilha Bouvet', '1975-05-31', 1.77, 95.00, 'ATA', 0);
INSERT INTO funcionario VALUES (91862453764, 1, 'Juan Duarte', 71, 209625.00, 'Moldávia', '1980-12-04', 1.98, 65.00, 'MEI', 0);
INSERT INTO funcionario VALUES (34516702916, 1, 'Carlos Eduardo Costa', 60, 615233.00, 'Sri Lanka', '1963-11-26', 1.63, 66.00, 'ATA', 0);
INSERT INTO funcionario VALUES (23184905624, 1, 'Cauê Campos', 53, 1638511.00, 'Mongólia', '1950-09-18', 1.94, 95.00, 'PD', 0);
INSERT INTO funcionario VALUES (9425831750, 1, 'Isaac Peixoto', 53, 1205380.00, 'China', '1974-02-20', 1.83, 78.00, 'PD', 0);
INSERT INTO funcionario VALUES (81430692570, 1, 'Leonardo Lima', 52, 545775.00, 'Moçambique', '1963-10-25', 1.92, 78.00, 'LD', 0);
INSERT INTO funcionario VALUES (28749653083, 1, 'Gustavo Henrique Jesus', 68, 2026284.00, 'Quênia', '1950-11-18', 1.98, 95.00, 'GOL', 0);
INSERT INTO funcionario VALUES (26159378040, 1, 'Anthony Novaes', 50, 2490922.00, 'Paraguai', '1977-04-02', 1.67, 69.00, 'VOL', 0);
INSERT INTO funcionario VALUES (32817590414, 1, 'Davi Lucas Gonçalves', 47, 2273884.00, 'Monserrate', '1950-02-25', 1.67, 65.00, 'MEI', 0);
INSERT INTO funcionario VALUES (96501437261, 2, 'Davi Lucas da Costa', 72, 1025489.00, 'Barbados', '1967-06-10', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (38702916568, 2, 'Luiz Henrique Rocha', 59, 180323.00, 'China', '1964-10-29', 1.63, 100.00, 'LD', 0);
INSERT INTO funcionario VALUES (26347590107, 2, 'Marcelo da Conceição', 75, 2134666.00, 'Burundi', '1964-07-19', 1.63, 83.00, 'LD', 0);
INSERT INTO funcionario VALUES (87132946013, 2, 'Vinicius da Paz', 40, 202963.00, 'Quiribáti', '1973-05-30', 1.83, 97.00, 'PE', 0);
INSERT INTO funcionario VALUES (2861345780, 2, 'Calebe Nogueira', 41, 1878320.00, 'Butão', '1962-08-24', 1.71, 79.00, 'PD', 0);
INSERT INTO funcionario VALUES (47902583197, 2, 'Gustavo Henrique da Mata', 55, 900889.00, 'Camboja', '1983-08-24', 1.90, 69.00, 'LD', 0);
INSERT INTO funcionario VALUES (47035189297, 2, 'Thiago Silva', 60, 1912428.00, 'Somália', '1969-04-02', 1.86, 90.00, 'VOL', 0);
INSERT INTO funcionario VALUES (96752014876, 2, 'Bryan Fernandes', 53, 613181.00, 'Malásia', '1958-03-02', 1.68, 81.00, 'PD', 0);
INSERT INTO funcionario VALUES (53682794182, 2, 'Luiz Felipe Vieira', 46, 308206.00, 'Santa Helena', '1961-05-19', 1.67, 74.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (95637821003, 2, 'Thomas Castro', 42, 2460115.00, 'Áustria', '1966-09-16', 1.95, 87.00, 'PD', 0);
INSERT INTO funcionario VALUES (28539607492, 2, 'Miguel Oliveira', 58, 879110.00, 'Ilha Norfolk', '1963-04-08', 1.83, 69.00, 'LD', 0);
INSERT INTO funcionario VALUES (62984357191, 2, 'Cauã Nogueira', 67, 911026.00, 'Birmânia', '1981-06-02', 1.65, 95.00, 'CA', 0);
INSERT INTO funcionario VALUES (97208435197, 2, 'Otávio Cunha', 64, 842373.00, 'Polônia', '1974-05-23', 1.92, 75.00, 'LD', 0);
INSERT INTO funcionario VALUES (42679310543, 2, 'Enrico Ribeiro', 52, 1546465.00, 'Gana', '1970-04-01', 1.95, 76.00, 'GOL', 0);
INSERT INTO funcionario VALUES (59431260743, 2, 'Marcelo da Costa', 51, 249811.00, 'Mongólia', '1975-06-14', 1.87, 71.00, 'MEI', 0);
INSERT INTO funcionario VALUES (10524396833, 2, 'Paulo Novaes', 47, 1557993.00, 'Ilhas Caiman', '1971-02-11', 1.83, 73.00, 'CA', 0);
INSERT INTO funcionario VALUES (56792180467, 2, 'Luigi da Costa', 50, 1161569.00, 'Chile', '1976-07-11', 1.88, 76.00, 'PE', 0);
INSERT INTO funcionario VALUES (53427089665, 2, 'Calebe Pereira', 62, 2109119.00, 'Ilha Bouvet', '1951-03-13', 1.71, 81.00, 'CA', 0);
INSERT INTO funcionario VALUES (46283915728, 2, 'Raul da Conceição', 74, 1207398.00, 'França', '1968-08-11', 1.71, 68.00, 'PE', 0);
INSERT INTO funcionario VALUES (87039461269, 2, 'Diego Ramos', 42, 1078926.00, 'Peru', '1954-11-29', 1.79, 90.00, 'MEI', 0);
INSERT INTO funcionario VALUES (65731240817, 2, 'Vitor da Rocha', 74, 1510923.00, 'Bermudas', '1964-01-02', 1.75, 85.00, 'LE', 0);
INSERT INTO funcionario VALUES (32179864078, 2, 'Leandro Moraes', 52, 531713.00, 'Santa Helena', '1968-12-30', 1.93, 98.00, 'LE', 0);
INSERT INTO funcionario VALUES (62451973099, 2, 'Cauã da Luz', 48, 696388.00, 'Paraguai', '1965-12-28', 1.60, 77.00, 'MEI', 0);
INSERT INTO funcionario VALUES (21803457635, 2, 'Breno Freitas', 44, 1536568.00, 'Libéria', '1956-10-30', 1.97, 100.00, 'CA', 0);
INSERT INTO funcionario VALUES (92051384797, 2, 'Caio Castro', 73, 2092148.00, 'Egito', '1963-06-13', 1.65, 87.00, 'GOL', 0);
INSERT INTO funcionario VALUES (53021769470, 2, 'Vitor Gabriel Ferreira', 69, 1145552.00, 'Índia', '1978-12-08', 1.85, 85.00, 'ATA', 0);
INSERT INTO funcionario VALUES (7816325444, 2, 'Enrico Melo', 64, 671788.00, 'Paquistão', '1972-12-05', 1.95, 67.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (57168234080, 2, 'Vitor Hugo Pires', 40, 1953829.00, 'Uganda', '1963-02-01', 1.83, 83.00, 'LD', 0);
INSERT INTO funcionario VALUES (75604932892, 2, 'Gustavo Henrique Cavalcanti', 65, 1171759.00, 'Porto Rico', '1969-10-04', 1.68, 69.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (18265309406, 2, 'Juan Campos', 62, 2182634.00, 'Finlândia', '1961-05-31', 1.94, 93.00, 'PD', 0);
INSERT INTO funcionario VALUES (7483629592, 2, 'Benício Gomes', 53, 2191003.00, 'Jan Mayen', '1966-03-04', 1.63, 93.00, 'ATA', 0);
INSERT INTO funcionario VALUES (83670524126, 3, 'Kevin Correia', 70, 1710687.00, 'Aruba', '1983-06-05', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (24658179300, 3, 'Pedro Miguel Nascimento', 49, 454579.00, 'Singapura', '1955-01-19', 1.90, 67.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (84270963131, 3, 'Vicente Aragão', 43, 1134621.00, 'Serra Leoa', '1970-09-28', 1.89, 75.00, 'LE', 0);
INSERT INTO funcionario VALUES (98673210577, 3, 'Thales Martins', 45, 110964.00, 'Vietnam', '1962-03-21', 1.82, 100.00, 'LD', 0);
INSERT INTO funcionario VALUES (23041569833, 3, 'Alexandre Fogaça', 74, 514832.00, 'Ilhas Cook', '1967-12-29', 1.72, 67.00, 'LD', 0);
INSERT INTO funcionario VALUES (74625109876, 3, 'Luiz Otávio Nogueira', 59, 1685467.00, 'Barbados', '1978-07-07', 1.82, 98.00, 'LE', 0);
INSERT INTO funcionario VALUES (19783402650, 3, 'André Moraes', 46, 400902.00, 'Mauritânia', '1957-04-21', 1.88, 70.00, 'MEI', 0);
INSERT INTO funcionario VALUES (45780692149, 3, 'Bernardo Vieira', 51, 989058.00, 'Barbados', '1956-10-01', 1.63, 82.00, 'VOL', 0);
INSERT INTO funcionario VALUES (7524986149, 3, 'Renan da Luz', 63, 810227.00, 'Usbequistão', '1954-01-26', 1.86, 66.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (21938567455, 3, 'Gabriel Cavalcanti', 62, 110009.00, 'México', '1970-12-21', 1.78, 94.00, 'PD', 0);
INSERT INTO funcionario VALUES (20935871497, 3, 'João Felipe Araújo', 67, 1547137.00, 'Haiti', '1950-01-22', 1.98, 73.00, 'MEI', 0);
INSERT INTO funcionario VALUES (24916570820, 3, 'Pedro Rodrigues', 45, 1567660.00, 'Paquistão', '1958-09-26', 1.91, 99.00, 'VOL', 0);
INSERT INTO funcionario VALUES (81209745658, 3, 'Rodrigo Costela', 53, 103168.00, 'Jersey', '1965-11-30', 1.70, 88.00, 'VOL', 0);
INSERT INTO funcionario VALUES (97526813446, 3, 'André Ferreira', 52, 1237546.00, 'Malávi', '1983-11-01', 1.84, 94.00, 'PD', 0);
INSERT INTO funcionario VALUES (20796583102, 3, 'Bernardo Araújo', 46, 1597720.00, 'Venezuela', '1954-06-05', 1.73, 71.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (43258190704, 3, 'Guilherme Dias', 51, 2468333.00, 'Iran', '1961-10-29', 1.80, 100.00, 'GOL', 0);
INSERT INTO funcionario VALUES (68239710450, 3, 'João Vitor Lopes', 60, 312771.00, 'Brasil', '1977-05-22', 1.90, 77.00, 'ATA', 0);
INSERT INTO funcionario VALUES (41720985685, 3, 'Henrique Dias', 57, 1886608.00, 'Niue', '1959-10-12', 1.91, 85.00, 'PE', 0);
INSERT INTO funcionario VALUES (92056718359, 3, 'Alexandre Oliveira', 73, 2002904.00, 'Líbano', '1962-07-18', 1.67, 76.00, 'ATA', 0);
INSERT INTO funcionario VALUES (57329401897, 3, 'Kevin Freitas', 71, 1850804.00, 'Cuba', '1981-08-13', 1.87, 66.00, 'CA', 0);
INSERT INTO funcionario VALUES (62380491704, 3, 'Kaique Mendes', 67, 1061282.00, 'Camarões', '1964-10-24', 1.64, 100.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (53780412608, 3, 'Vinicius Costa', 40, 2239299.00, 'Congo-Brazzaville', '1980-07-17', 1.87, 78.00, 'PD', 0);
INSERT INTO funcionario VALUES (1462783996, 3, 'Bruno Viana', 48, 789302.00, 'Ashmore and Cartier Islands', '1965-03-04', 1.96, 68.00, 'PD', 0);
INSERT INTO funcionario VALUES (5361478253, 3, 'Juan Fernandes', 51, 1222609.00, 'Peru', '1978-06-23', 1.70, 99.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (42903685738, 3, 'Luiz Fernando Nascimento', 59, 2125772.00, 'Estônia', '1957-10-25', 1.95, 92.00, 'LE', 0);
INSERT INTO funcionario VALUES (78592341060, 3, 'Yuri Moraes', 69, 2251723.00, 'Níger', '1971-09-11', 1.71, 65.00, 'VOL', 0);
INSERT INTO funcionario VALUES (51749286076, 3, 'Matheus Pinto', 64, 669193.00, 'Costa do Marfim', '1961-10-19', 1.89, 75.00, 'PD', 0);
INSERT INTO funcionario VALUES (72103946561, 3, 'Igor Santos', 43, 2180035.00, 'Serra Leoa', '1959-07-19', 1.97, 94.00, 'PE', 0);
INSERT INTO funcionario VALUES (68392705483, 3, 'Juan Rodrigues', 58, 1038213.00, 'Maldivas', '1976-03-06', 1.91, 87.00, 'PD', 0);
INSERT INTO funcionario VALUES (96247531800, 3, 'Vitor Gabriel Monteiro', 51, 1994368.00, 'Antilhas Holandesas', '1966-05-27', 1.74, 68.00, 'GOL', 0);
INSERT INTO funcionario VALUES (10746238940, 3, 'Enzo Gabriel da Mata', 56, 780334.00, 'Jersey', '1949-07-05', 1.68, 78.00, 'LD', 0);
INSERT INTO funcionario VALUES (79310485205, 4, 'Fernando Novaes', 41, 2365448.00, 'Jamaica', '1979-05-24', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (54218703914, 4, 'Luiz Felipe Dias', 60, 2258276.00, 'Antilhas Holandesas', '1958-03-10', 1.62, 92.00, 'LD', 0);
INSERT INTO funcionario VALUES (79804325683, 4, 'Pedro Miguel Costa', 49, 159021.00, 'Nicarágua', '1966-07-07', 1.71, 95.00, 'GOL', 0);
INSERT INTO funcionario VALUES (68175420308, 4, 'João Nunes', 58, 1488647.00, 'Taiwan', '1970-12-21', 1.76, 85.00, 'VOL', 0);
INSERT INTO funcionario VALUES (53680729456, 4, 'Levi Silva', 73, 1278251.00, 'Malta', '1950-12-10', 1.91, 68.00, 'LE', 0);
INSERT INTO funcionario VALUES (87143260940, 4, 'Heitor Cavalcanti', 68, 1028934.00, 'Burquina Faso', '1969-07-22', 1.85, 90.00, 'PD', 0);
INSERT INTO funcionario VALUES (98214605776, 4, 'Kevin Silva', 59, 620987.00, 'Índia', '1983-07-09', 1.81, 82.00, 'MEI', 0);
INSERT INTO funcionario VALUES (35967842128, 4, 'Enzo Nogueira', 62, 1758496.00, 'Dhekelia', '1983-10-05', 1.62, 65.00, 'MEI', 0);
INSERT INTO funcionario VALUES (78143596001, 4, 'Alexandre da Rosa', 53, 1758441.00, 'Serra Leoa', '1967-11-13', 1.60, 66.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (34670891278, 4, 'Caio da Cruz', 47, 1111647.00, 'Zimbabué', '1950-10-29', 1.63, 76.00, 'PE', 0);
INSERT INTO funcionario VALUES (92467105334, 4, 'Isaac Teixeira', 68, 1750181.00, 'Ilhas Salomão', '1976-01-27', 1.74, 79.00, 'MEI', 0);
INSERT INTO funcionario VALUES (53798426074, 4, 'Pietro Teixeira', 56, 524069.00, 'Cabo Verde', '1978-04-25', 1.71, 65.00, 'LD', 0);
INSERT INTO funcionario VALUES (98145762391, 4, 'Matheus Moreira', 45, 600957.00, 'Suazilândia', '1968-08-24', 1.87, 65.00, 'PD', 0);
INSERT INTO funcionario VALUES (39612875464, 4, 'Luiz Felipe da Mata', 59, 1072848.00, 'Equador', '1964-06-25', 1.62, 67.00, 'VOL', 0);
INSERT INTO funcionario VALUES (82157036407, 4, 'Igor Fogaça', 75, 1987481.00, 'Iran', '1981-01-07', 1.98, 82.00, 'PD', 0);
INSERT INTO funcionario VALUES (8123976496, 4, 'Luigi Fogaça', 46, 1962489.00, 'Birmânia', '1976-04-14', 1.83, 97.00, 'LD', 0);
INSERT INTO funcionario VALUES (50436792125, 4, 'Bernardo Martins', 43, 1778323.00, 'Jan Mayen', '1968-06-15', 1.89, 98.00, 'VOL', 0);
INSERT INTO funcionario VALUES (65029187359, 4, 'Lucas Gabriel Caldeira', 52, 1842334.00, 'Lesoto', '1948-04-13', 1.67, 72.00, 'CA', 0);
INSERT INTO funcionario VALUES (75891324032, 4, 'João Araújo', 72, 206852.00, 'Jamaica', '1962-04-22', 1.77, 90.00, 'VOL', 0);
INSERT INTO funcionario VALUES (4125763925, 4, 'Igor Fogaça', 68, 1118589.00, 'Venezuela', '1949-11-03', 1.85, 76.00, 'ATA', 0);
INSERT INTO funcionario VALUES (23016784580, 4, 'Daniel da Mata', 66, 1590622.00, 'Egito', '1954-03-22', 1.83, 82.00, 'PD', 0);
INSERT INTO funcionario VALUES (97654018339, 4, 'Enzo Lopes', 43, 1688450.00, 'Tanzânia', '1966-12-13', 1.61, 100.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (4289173560, 4, 'Kevin Nogueira', 50, 887782.00, 'Iraque', '1951-02-16', 1.93, 70.00, 'CA', 0);
INSERT INTO funcionario VALUES (47398201613, 4, 'Danilo Almeida', 74, 1333333.00, 'Colômbia', '1960-01-16', 1.84, 75.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (29508163470, 4, 'Paulo Alves', 70, 262701.00, 'Peru', '1955-07-31', 1.67, 71.00, 'CA', 0);
INSERT INTO funcionario VALUES (92681570395, 4, 'Enzo Carvalho', 69, 1025275.00, 'Iran', '1971-12-01', 1.87, 84.00, 'LD', 0);
INSERT INTO funcionario VALUES (67241893573, 4, 'Pedro Miguel Pereira', 70, 160281.00, 'Wake Island', '1948-05-22', 1.71, 70.00, 'PD', 0);
INSERT INTO funcionario VALUES (89460753256, 4, 'Nathan Correia', 56, 360907.00, 'Tanzânia', '1951-12-27', 1.92, 99.00, 'LE', 0);
INSERT INTO funcionario VALUES (50468139710, 4, 'Enzo Gabriel Melo', 61, 929570.00, 'Salvador', '1974-04-11', 1.73, 99.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (36921507840, 4, 'Guilherme da Paz', 60, 2365163.00, 'Jordânia', '1977-10-17', 1.71, 80.00, 'ATA', 0);
INSERT INTO funcionario VALUES (56318970401, 4, 'Benjamin Souza', 60, 1630072.00, 'Espanha', '1980-06-01', 1.91, 78.00, 'CA', 0);
INSERT INTO funcionario VALUES (10942863542, 5, 'Enzo Ferreira', 64, 1864318.00, 'Santa Lúcia', '1977-05-10', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (85740162335, 5, 'Levi Monteiro', 54, 153770.00, 'Nova Caledónia', '1963-03-08', 1.61, 82.00, 'CA', 0);
INSERT INTO funcionario VALUES (74329560143, 5, 'Erick Santos', 50, 552197.00, 'Madagáscar', '1949-09-20', 1.62, 74.00, 'GOL', 0);
INSERT INTO funcionario VALUES (86972405300, 5, 'Pedro Lucas Souza', 69, 491195.00, 'Ucrânia', '1967-01-23', 1.64, 92.00, 'PD', 0);
INSERT INTO funcionario VALUES (31624987087, 5, 'Marcos Vinicius Ribeiro', 58, 1389904.00, 'Palau', '1963-05-28', 1.91, 70.00, 'LD', 0);
INSERT INTO funcionario VALUES (70984615202, 5, 'Raul da Cruz', 42, 1144024.00, 'Território Britânico do Oceano Índico', '1956-08-17', 1.78, 84.00, 'GOL', 0);
INSERT INTO funcionario VALUES (26931407813, 5, 'Igor Ramos', 40, 2464134.00, 'Santa Helena', '1963-12-19', 1.82, 70.00, 'LE', 0);
INSERT INTO funcionario VALUES (30651249805, 5, 'Luiz Gustavo Lima', 57, 1784925.00, 'Somália', '1966-10-29', 1.94, 97.00, 'VOL', 0);
INSERT INTO funcionario VALUES (79352680456, 5, 'Lucca da Costa', 65, 745809.00, 'Catar', '1980-07-19', 1.62, 74.00, 'LD', 0);
INSERT INTO funcionario VALUES (47536291043, 5, 'Levi Dias', 59, 1842745.00, 'México', '1958-06-19', 1.78, 79.00, 'ATA', 0);
INSERT INTO funcionario VALUES (71405682353, 5, 'Eduardo Mendes', 66, 521872.00, 'Egito', '1955-04-11', 1.98, 71.00, 'GOL', 0);
INSERT INTO funcionario VALUES (36859104775, 5, 'Murilo da Paz', 52, 437198.00, 'Guam', '1980-09-25', 1.91, 69.00, 'MEI', 0);
INSERT INTO funcionario VALUES (20493617850, 5, 'João Lucas Barros', 44, 2386507.00, 'Navassa Island', '1979-02-14', 1.66, 92.00, 'MEI', 0);
INSERT INTO funcionario VALUES (97126580401, 5, 'Leonardo da Cruz', 64, 1382446.00, 'Andorra', '1966-11-04', 1.65, 81.00, 'ATA', 0);
INSERT INTO funcionario VALUES (12350976416, 5, 'Pietro da Costa', 41, 1106396.00, 'Nepal', '1969-10-27', 1.69, 92.00, 'ATA', 0);
INSERT INTO funcionario VALUES (45037298610, 5, 'Matheus Campos', 62, 184455.00, 'Nauru', '1980-05-28', 1.65, 90.00, 'LD', 0);
INSERT INTO funcionario VALUES (74189562319, 5, 'Samuel Sales', 68, 683535.00, 'Suécia', '1962-10-10', 1.71, 68.00, 'LD', 0);
INSERT INTO funcionario VALUES (74285913682, 5, 'João Gabriel Araújo', 74, 782012.00, 'Tajiquistão', '1977-01-27', 1.87, 71.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (90416573207, 5, 'Levi Teixeira', 56, 1626328.00, 'Argélia', '1954-09-02', 1.64, 66.00, 'LE', 0);
INSERT INTO funcionario VALUES (13678942555, 5, 'João Lucas Moreira', 50, 1953171.00, 'Dhekelia', '1961-02-03', 1.79, 99.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (83426579065, 5, 'Davi Pires', 73, 680303.00, 'Costa do Marfim', '1955-05-18', 1.61, 76.00, 'GOL', 0);
INSERT INTO funcionario VALUES (81275403662, 5, 'Paulo Rezende', 49, 285883.00, 'Navassa Island', '1973-05-17', 1.74, 94.00, 'PE', 0);
INSERT INTO funcionario VALUES (50794813232, 5, 'Ryan Nogueira', 67, 1065316.00, 'Tokelau', '1977-12-18', 1.79, 93.00, 'VOL', 0);
INSERT INTO funcionario VALUES (30621597821, 5, 'Vitor Hugo Costa', 66, 1501455.00, 'Antilhas Holandesas', '1975-10-29', 1.93, 79.00, 'ATA', 0);
INSERT INTO funcionario VALUES (16259830424, 5, 'Davi Lucca Porto', 40, 857512.00, 'Geórgia do Sul e Sandwich do Sul', '1980-07-30', 1.81, 65.00, 'MEI', 0);
INSERT INTO funcionario VALUES (84027315626, 5, 'Luiz Fernando Teixeira', 64, 637382.00, 'Chade', '1979-04-14', 1.75, 92.00, 'MEI', 0);
INSERT INTO funcionario VALUES (6357128902, 5, 'Kaique Dias', 63, 1192524.00, 'Brasil', '1968-10-28', 1.74, 74.00, 'PE', 0);
INSERT INTO funcionario VALUES (35402687153, 5, 'Alexandre Ramos', 75, 211664.00, 'República Dominicana', '1956-11-19', 1.63, 93.00, 'VOL', 0);
INSERT INTO funcionario VALUES (6358741217, 5, 'Vitor Hugo Moreira', 67, 762483.00, 'Trindade e Tobago', '1958-12-21', 1.83, 91.00, 'LE', 0);
INSERT INTO funcionario VALUES (3481572905, 5, 'Rodrigo Carvalho', 70, 1467845.00, 'Lituânia', '1959-11-24', 1.98, 65.00, 'PE', 0);
INSERT INTO funcionario VALUES (30528761471, 5, 'Luiz Henrique Costela', 73, 1684055.00, 'Brasil', '1963-01-27', 1.67, 88.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (17563402853, 6, 'Vicente Monteiro', 61, 1428096.00, 'Comores', '1948-10-13', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (48327165062, 6, 'André Cunha', 41, 1834919.00, 'Vietnam', '1957-05-27', 1.94, 95.00, 'MEI', 0);
INSERT INTO funcionario VALUES (40829673113, 6, 'Breno Rezende', 52, 2290538.00, 'Anguila', '1973-01-21', 1.96, 81.00, 'GOL', 0);
INSERT INTO funcionario VALUES (31586920405, 6, 'Pedro Miguel Costela', 46, 1079412.00, 'Navassa Island', '1963-09-07', 1.72, 78.00, 'VOL', 0);
INSERT INTO funcionario VALUES (67325890168, 6, 'Davi Fogaça', 73, 778999.00, 'Geórgia', '1975-04-12', 1.98, 97.00, 'LE', 0);
INSERT INTO funcionario VALUES (24530891704, 6, 'Otávio Ferreira', 65, 1904385.00, 'Bolívia', '1954-01-21', 1.72, 90.00, 'VOL', 0);
INSERT INTO funcionario VALUES (41908573600, 6, 'Lucas Gabriel Dias', 46, 217672.00, 'Croácia', '1954-05-21', 1.95, 84.00, 'GOL', 0);
INSERT INTO funcionario VALUES (9241658398, 6, 'Diego Mendes', 72, 398665.00, 'Taiwan', '1977-07-20', 1.85, 80.00, 'MEI', 0);
INSERT INTO funcionario VALUES (97146082369, 6, 'Cauê Vieira', 67, 525676.00, 'Costa do Marfim', '1953-01-17', 1.70, 97.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (45278316071, 6, 'João da Costa', 53, 2463425.00, 'Guiné Equatorial', '1965-11-15', 1.94, 78.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (40718326571, 6, 'Calebe da Rocha', 46, 276329.00, 'Wake Island', '1965-11-08', 1.87, 78.00, 'MEI', 0);
INSERT INTO funcionario VALUES (46713095801, 6, 'Benjamin da Conceição', 58, 2232995.00, 'Serra Leoa', '1983-08-15', 1.65, 100.00, 'LD', 0);
INSERT INTO funcionario VALUES (57214983664, 6, 'Vicente da Costa', 70, 608495.00, 'Egito', '1974-11-04', 1.65, 66.00, 'PD', 0);
INSERT INTO funcionario VALUES (42857631928, 6, 'Breno da Cruz', 72, 109333.00, 'Antilhas Holandesas', '1980-02-28', 1.62, 72.00, 'ATA', 0);
INSERT INTO funcionario VALUES (9584713205, 6, 'Levi Gomes', 61, 1681611.00, 'Granada', '1957-12-02', 1.90, 67.00, 'MEI', 0);
INSERT INTO funcionario VALUES (92843150779, 6, 'Miguel Peixoto', 61, 657951.00, 'Ilhas Heard e McDonald', '1973-06-04', 1.71, 95.00, 'LE', 0);
INSERT INTO funcionario VALUES (92805714601, 6, 'Marcelo da Rocha', 64, 600004.00, 'Santa Lúcia', '1952-05-11', 1.73, 90.00, 'PE', 0);
INSERT INTO funcionario VALUES (2497685347, 6, 'Lucas Rezende', 52, 2326017.00, 'Congo-Brazzaville', '1975-12-22', 1.92, 79.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (61307589286, 6, 'Davi da Costa', 72, 239484.00, 'Man, Isle of', '1968-01-15', 1.85, 90.00, 'GOL', 0);
INSERT INTO funcionario VALUES (28154379619, 6, 'Marcos Vinicius da Costa', 51, 1315094.00, 'Burundi', '1953-05-21', 1.89, 80.00, 'GOL', 0);
INSERT INTO funcionario VALUES (2436795800, 6, 'Luiz Henrique Fogaça', 49, 2346710.00, 'Roménia', '1974-07-16', 1.96, 99.00, 'MEI', 0);
INSERT INTO funcionario VALUES (90275413616, 6, 'Nathan Araújo', 40, 1777571.00, 'Congo-Brazzaville', '1971-01-18', 1.62, 70.00, 'CA', 0);
INSERT INTO funcionario VALUES (2791548602, 6, 'Pedro Henrique Martins', 74, 1943232.00, 'Angola', '1954-12-18', 1.75, 67.00, 'ATA', 0);
INSERT INTO funcionario VALUES (21058936786, 6, 'Leandro da Luz', 50, 1063839.00, 'Senegal', '1953-04-22', 1.65, 72.00, 'ATA', 0);
INSERT INTO funcionario VALUES (1275869386, 6, 'Murilo Almeida', 47, 1778541.00, 'Usbequistão', '1976-10-22', 1.92, 76.00, 'CA', 0);
INSERT INTO funcionario VALUES (28760345144, 6, 'Luiz Miguel Cunha', 42, 467905.00, 'Svalbard e Jan Mayen', '1968-03-10', 1.91, 96.00, 'CA', 0);
INSERT INTO funcionario VALUES (15096483215, 6, 'Thales Monteiro', 52, 253972.00, 'Coreia do Norte', '1978-01-22', 1.81, 79.00, 'VOL', 0);
INSERT INTO funcionario VALUES (49683102778, 6, 'João Miguel Araújo', 65, 2185381.00, 'Bolívia', '1954-09-23', 1.80, 72.00, 'PE', 0);
INSERT INTO funcionario VALUES (58179043657, 6, 'Lucas Barros', 47, 1077309.00, 'Congo-Kinshasa', '1962-10-03', 1.63, 70.00, 'LE', 0);
INSERT INTO funcionario VALUES (31846059224, 6, 'Igor Pires', 68, 1957599.00, 'Iraque', '1965-04-04', 1.79, 76.00, 'LE', 0);
INSERT INTO funcionario VALUES (36870429103, 6, 'Caio Alves', 40, 966995.00, 'México', '1977-02-27', 1.63, 86.00, 'PD', 0);
INSERT INTO funcionario VALUES (62340975883, 7, 'João Guilherme da Paz', 43, 762135.00, 'Tanzânia', '1972-12-22', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (97105642343, 7, 'Paulo Costela', 71, 2426975.00, 'Ruanda', '1958-02-02', 1.81, 80.00, 'GOL', 0);
INSERT INTO funcionario VALUES (50321764862, 7, 'Kevin das Neves', 65, 2431267.00, 'Chile', '1957-06-22', 1.63, 71.00, 'LD', 0);
INSERT INTO funcionario VALUES (16925870302, 7, 'Diego Correia', 71, 2115032.00, 'República Centro-Africana', '1975-02-23', 1.77, 99.00, 'LD', 0);
INSERT INTO funcionario VALUES (1328547671, 7, 'Calebe Lima', 58, 701567.00, 'Finlândia', '1968-05-27', 1.94, 78.00, 'PE', 0);
INSERT INTO funcionario VALUES (78126905395, 7, 'Levi Costela', 74, 546192.00, 'Quênia', '1961-02-05', 1.76, 96.00, 'VOL', 0);
INSERT INTO funcionario VALUES (60281574308, 7, 'Ryan Rezende', 73, 2143825.00, 'Território Britânico do Oceano Índico', '1979-11-11', 1.71, 70.00, 'PD', 0);
INSERT INTO funcionario VALUES (38701624903, 7, 'Gustavo Henrique Nogueira', 70, 2051967.00, 'Moldávia', '1971-06-20', 1.94, 82.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (64152793864, 7, 'João Felipe Almeida', 60, 452446.00, 'Bolívia', '1981-02-23', 1.69, 100.00, 'VOL', 0);
INSERT INTO funcionario VALUES (9625437800, 7, 'Matheus Lima', 64, 1867264.00, 'Andorra', '1952-01-27', 1.64, 86.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (36259740107, 7, 'Calebe Cardoso', 75, 545943.00, 'Akrotiri', '1958-06-17', 1.64, 91.00, 'MEI', 0);
INSERT INTO funcionario VALUES (10836925777, 7, 'Davi Luiz Moraes', 44, 2030241.00, 'Birmânia', '1963-02-24', 1.69, 71.00, 'GOL', 0);
INSERT INTO funcionario VALUES (34981072597, 7, 'Luiz Henrique Souza', 56, 2384839.00, 'Uruguai', '1967-08-13', 1.85, 79.00, 'ATA', 0);
INSERT INTO funcionario VALUES (53691820433, 7, 'Guilherme Santos', 50, 458004.00, 'Ashmore and Cartier Islands', '1970-01-25', 1.68, 81.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (34658109700, 7, 'Anthony Cardoso', 46, 1525267.00, 'São Cristóvão e Neves', '1948-10-24', 1.90, 92.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (20863749500, 7, 'Theo Souza', 50, 1936018.00, 'Uganda', '1976-07-10', 1.98, 74.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (27916583437, 7, 'Isaac Mendes', 52, 2091477.00, 'Itália', '1949-04-07', 1.64, 75.00, 'LD', 0);
INSERT INTO funcionario VALUES (7913485205, 7, 'Juan Viana', 73, 2227676.00, 'Papua-Nova Guiné', '1978-08-30', 1.88, 86.00, 'LE', 0);
INSERT INTO funcionario VALUES (23518967002, 7, 'Davi Luiz Cavalcanti', 53, 2133600.00, 'Nauru', '1969-06-18', 1.98, 67.00, 'LD', 0);
INSERT INTO funcionario VALUES (62904578374, 7, 'Gabriel Caldeira', 65, 803000.00, 'Mônaco', '1953-08-26', 1.92, 72.00, 'VOL', 0);
INSERT INTO funcionario VALUES (29380471696, 7, 'Marcos Vinicius Cavalcanti', 73, 2203033.00, 'Maurícia', '1972-06-04', 1.60, 75.00, 'GOL', 0);
INSERT INTO funcionario VALUES (3769825438, 7, 'Gustavo Henrique Jesus', 66, 217450.00, 'Irlanda', '1958-11-24', 1.76, 75.00, 'ATA', 0);
INSERT INTO funcionario VALUES (87234591664, 7, 'Luiz Miguel Jesus', 50, 2384225.00, 'Uganda', '1960-04-22', 1.95, 98.00, 'ATA', 0);
INSERT INTO funcionario VALUES (23784091504, 7, 'Pedro Lucas Costela', 46, 1000400.00, 'Tailândia', '1968-04-30', 1.67, 79.00, 'ATA', 0);
INSERT INTO funcionario VALUES (62405817985, 7, 'Thomas Moura', 59, 1328810.00, 'Espanha', '1965-09-30', 1.72, 73.00, 'LD', 0);
INSERT INTO funcionario VALUES (27961085467, 7, 'Luiz Miguel Pinto', 67, 1486129.00, 'Comores', '1960-03-23', 1.73, 71.00, 'MEI', 0);
INSERT INTO funcionario VALUES (72140385950, 7, 'Emanuel Peixoto', 58, 460816.00, 'Bósnia e Herzegovina', '1973-09-25', 1.88, 90.00, 'MEI', 0);
INSERT INTO funcionario VALUES (2647985383, 7, 'Thales Freitas', 70, 1027476.00, 'Rússia', '1976-05-08', 1.71, 76.00, 'PD', 0);
INSERT INTO funcionario VALUES (62103479831, 7, 'Francisco Gonçalves', 75, 2106818.00, 'Síria', '1974-05-20', 1.88, 84.00, 'CA', 0);
INSERT INTO funcionario VALUES (43982567173, 7, 'Marcelo Jesus', 61, 524203.00, 'Dhekelia', '1955-05-16', 1.74, 76.00, 'LE', 0);
INSERT INTO funcionario VALUES (81674093500, 7, 'Lorenzo Nogueira', 66, 611441.00, 'França', '1976-11-06', 1.62, 87.00, 'LD', 0);
INSERT INTO funcionario VALUES (13458690298, 8, 'Danilo Almeida', 58, 1791252.00, 'Akrotiri', '1965-03-21', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (34750219860, 8, 'Diego das Neves', 75, 2406610.00, 'Luxemburgo', '1978-04-30', 1.92, 92.00, 'CA', 0);
INSERT INTO funcionario VALUES (41862537909, 8, 'João Ramos', 71, 2497763.00, 'Roménia', '1951-03-04', 1.60, 71.00, 'ATA', 0);
INSERT INTO funcionario VALUES (18425903750, 8, 'Bruno Caldeira', 63, 2262233.00, 'Croácia', '1957-07-28', 1.81, 72.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (42319056734, 8, 'Theo Sales', 53, 753902.00, 'Angola', '1964-03-01', 1.71, 72.00, 'GOL', 0);
INSERT INTO funcionario VALUES (97042513860, 8, 'Paulo Ferreira', 58, 756121.00, 'Bélgica', '1970-04-30', 1.78, 98.00, 'LD', 0);
INSERT INTO funcionario VALUES (37245806144, 8, 'Danilo Azevedo', 63, 1743270.00, 'Bielorrússia', '1977-01-14', 1.83, 86.00, 'PD', 0);
INSERT INTO funcionario VALUES (21604873922, 8, 'Daniel Sales', 75, 1391822.00, 'Guatemala', '1964-05-15', 1.92, 92.00, 'VOL', 0);
INSERT INTO funcionario VALUES (1974538214, 8, 'Davi Lucca da Conceição', 71, 248592.00, 'Costa Rica', '1972-07-18', 1.93, 71.00, 'ATA', 0);
INSERT INTO funcionario VALUES (48130625717, 8, 'Davi Luiz Costa', 45, 2094232.00, 'Etiópia', '1967-09-28', 1.95, 81.00, 'MEI', 0);
INSERT INTO funcionario VALUES (24105683780, 8, 'Luiz Felipe Fernandes', 73, 1506840.00, 'Timor Leste', '1975-04-26', 1.67, 75.00, 'CA', 0);
INSERT INTO funcionario VALUES (45867920194, 8, 'Luiz Otávio Aragão', 44, 2015197.00, 'Dinamarca', '1952-09-27', 1.72, 95.00, 'LD', 0);
INSERT INTO funcionario VALUES (42018679350, 8, 'Gabriel Sales', 64, 851718.00, 'Burquina Faso', '1983-11-06', 1.93, 77.00, 'PE', 0);
INSERT INTO funcionario VALUES (17493628564, 8, 'Joaquim Silveira', 70, 1482919.00, 'Cuba', '1957-04-07', 1.63, 66.00, 'LE', 0);
INSERT INTO funcionario VALUES (7218693512, 8, 'Breno Rodrigues', 54, 1802658.00, 'Ilhas Falkland', '1972-02-13', 1.64, 87.00, 'VOL', 0);
INSERT INTO funcionario VALUES (25603814942, 8, 'Pietro Vieira', 65, 1678764.00, 'Suíça', '1958-10-20', 1.63, 86.00, 'ATA', 0);
INSERT INTO funcionario VALUES (9563824792, 8, 'Cauê Costa', 46, 383958.00, 'Ilhas dos Cocos', '1970-05-28', 1.91, 72.00, 'PD', 0);
INSERT INTO funcionario VALUES (47058193223, 8, 'João Vitor Araújo', 55, 2049594.00, 'Namíbia', '1979-07-13', 1.63, 95.00, 'LE', 0);
INSERT INTO funcionario VALUES (78539046148, 8, 'Juan Costela', 56, 2119945.00, 'Pitcairn', '1975-04-17', 1.97, 70.00, 'PE', 0);
INSERT INTO funcionario VALUES (46517238026, 8, 'Calebe Farias', 61, 1921069.00, 'Vanuatu', '1949-07-06', 1.76, 80.00, 'ATA', 0);
INSERT INTO funcionario VALUES (12706945885, 8, 'Nathan Caldeira', 60, 756061.00, 'Gana', '1961-01-05', 1.90, 75.00, 'CA', 0);
INSERT INTO funcionario VALUES (64309152716, 8, 'Caio da Rocha', 66, 1658614.00, 'Bahamas', '1968-04-18', 1.66, 86.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (72954163070, 8, 'Joaquim Alves', 71, 1135309.00, 'Guiana', '1954-12-03', 1.64, 82.00, 'PD', 0);
INSERT INTO funcionario VALUES (39017486287, 8, 'Eduardo Dias', 69, 1683912.00, 'Micronésia', '1963-02-13', 1.96, 84.00, 'LE', 0);
INSERT INTO funcionario VALUES (63859410270, 8, 'Pedro Henrique Pereira', 67, 1440235.00, 'República Dominicana', '1962-04-15', 1.80, 75.00, 'VOL', 0);
INSERT INTO funcionario VALUES (50289673429, 8, 'Luiz Miguel Farias', 40, 1200572.00, 'Bulgária', '1950-07-13', 1.71, 66.00, 'GOL', 0);
INSERT INTO funcionario VALUES (45613279837, 8, 'Caio Farias', 69, 144590.00, 'Lesoto', '1949-07-21', 1.79, 91.00, 'CA', 0);
INSERT INTO funcionario VALUES (91245367846, 8, 'Fernando Barbosa', 63, 1135399.00, 'Faroé', '1951-07-07', 1.60, 82.00, 'VOL', 0);
INSERT INTO funcionario VALUES (5734618993, 8, 'Matheus Nunes', 57, 1551445.00, 'República Dominicana', '1977-08-25', 1.62, 69.00, 'VOL', 0);
INSERT INTO funcionario VALUES (46075218335, 8, 'Alexandre Azevedo', 57, 1767650.00, 'Benim', '1957-10-20', 1.70, 90.00, 'GOL', 0);
INSERT INTO funcionario VALUES (96347851075, 8, 'Anthony Aragão', 67, 142745.00, 'Azerbaijão', '1974-08-12', 1.69, 74.00, 'PE', 0);
INSERT INTO funcionario VALUES (64859173228, 9, 'Luiz Otávio Castro', 54, 582888.00, 'Hungria', '1969-06-10', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (93751486291, 9, 'Vitor Oliveira', 68, 620802.00, 'Kuwait', '1960-12-26', 1.98, 94.00, 'MEI', 0);
INSERT INTO funcionario VALUES (74839061203, 9, 'Emanuel da Mota', 62, 2469422.00, 'Macedónia do Norte', '1967-11-13', 1.84, 74.00, 'MEI', 0);
INSERT INTO funcionario VALUES (42816309703, 9, 'Nathan das Neves', 57, 1643367.00, 'Espanha', '1971-05-29', 1.64, 91.00, 'GOL', 0);
INSERT INTO funcionario VALUES (47082163517, 9, 'João Lucas Araújo', 66, 1104522.00, 'República Checa', '1968-05-29', 1.61, 67.00, 'LE', 0);
INSERT INTO funcionario VALUES (28103546933, 9, 'Arthur Nunes', 72, 2239907.00, 'Croácia', '1954-03-24', 1.64, 66.00, 'PE', 0);
INSERT INTO funcionario VALUES (47253091680, 9, 'Breno Correia', 59, 1119565.00, 'Micronésia', '1954-03-05', 1.79, 66.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (82637194537, 9, 'Guilherme Cunha', 68, 1864467.00, 'Estados Unidos', '1968-12-19', 1.96, 100.00, 'LD', 0);
INSERT INTO funcionario VALUES (39687540184, 9, 'Luiz Otávio Barros', 58, 631719.00, 'São Tomé e Príncipe', '1958-09-02', 1.67, 87.00, 'PD', 0);
INSERT INTO funcionario VALUES (35901782640, 9, 'Davi Lucas Nascimento', 60, 1593734.00, 'Nauru', '1980-04-26', 1.64, 73.00, 'PD', 0);
INSERT INTO funcionario VALUES (53801697401, 9, 'Danilo Viana', 69, 2283147.00, 'Albânia', '1967-07-18', 1.62, 95.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (20693187530, 9, 'Daniel Ramos', 47, 1839625.00, 'Azerbaijão', '1964-03-30', 1.63, 96.00, 'LD', 0);
INSERT INTO funcionario VALUES (95067421380, 9, 'Levi Santos', 43, 505843.00, 'Guam', '1956-02-11', 1.66, 92.00, 'MEI', 0);
INSERT INTO funcionario VALUES (20784163987, 9, 'Vitor Alves', 55, 889463.00, 'Samoa', '1956-09-05', 1.74, 92.00, 'ATA', 0);
INSERT INTO funcionario VALUES (92367018413, 9, 'Otávio Mendes', 64, 1451650.00, 'Belize', '1967-06-26', 1.65, 88.00, 'MEI', 0);
INSERT INTO funcionario VALUES (10682394769, 9, 'Lucas Gabriel Melo', 59, 1557788.00, 'Ilhas Marshall', '1952-07-25', 1.94, 80.00, 'PD', 0);
INSERT INTO funcionario VALUES (76582930168, 9, 'Vitor Gabriel Martins', 73, 825417.00, 'Kuwait', '1982-11-25', 1.88, 99.00, 'PD', 0);
INSERT INTO funcionario VALUES (56287430117, 9, 'Vitor das Neves', 56, 709033.00, 'Bahamas', '1963-01-04', 1.75, 97.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (74529013804, 9, 'Levi Ramos', 68, 785383.00, 'Quiribáti', '1956-09-22', 1.68, 70.00, 'LE', 0);
INSERT INTO funcionario VALUES (90843675292, 9, 'Kevin Nascimento', 71, 981672.00, 'Líbano', '1975-04-14', 1.70, 73.00, 'LD', 0);
INSERT INTO funcionario VALUES (28476395000, 9, 'Anthony Silveira', 62, 1668807.00, 'Colômbia', '1966-06-09', 1.98, 76.00, 'PD', 0);
INSERT INTO funcionario VALUES (1865397202, 9, 'Igor Mendes', 53, 2081662.00, 'Bermudas', '1968-01-24', 1.92, 72.00, 'VOL', 0);
INSERT INTO funcionario VALUES (62190543851, 9, 'Benício Pinto', 55, 1462768.00, 'Honduras', '1967-06-25', 1.85, 81.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (9437856265, 9, 'Thiago da Mata', 70, 2434180.00, 'Samoa', '1952-04-18', 1.78, 65.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (63285714964, 9, 'Gustavo Henrique Campos', 58, 1434550.00, 'Congo-Kinshasa', '1953-05-16', 1.86, 93.00, 'CA', 0);
INSERT INTO funcionario VALUES (51328790630, 9, 'Rodrigo Nunes', 55, 1162971.00, 'Ilha Bouvet', '1963-06-12', 1.70, 65.00, 'VOL', 0);
INSERT INTO funcionario VALUES (62948531098, 9, 'Danilo da Rocha', 41, 1719993.00, 'Croácia', '1953-11-01', 1.91, 100.00, 'LE', 0);
INSERT INTO funcionario VALUES (50216498333, 9, 'Kaique Caldeira', 54, 847465.00, 'Hungria', '1964-05-28', 1.78, 100.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (16825347900, 9, 'Vinicius Santos', 64, 404190.00, 'Domínica', '1968-09-08', 1.97, 72.00, 'MEI', 0);
INSERT INTO funcionario VALUES (96715304866, 9, 'João Miguel Oliveira', 62, 1979351.00, 'Liechtenstein', '1951-10-02', 1.81, 75.00, 'ATA', 0);
INSERT INTO funcionario VALUES (50694178276, 9, 'Leandro Farias', 53, 1722078.00, 'Ruanda', '1981-05-03', 1.95, 92.00, 'VOL', 0);
INSERT INTO funcionario VALUES (30862759447, 10, 'Thiago Carvalho', 72, 2363580.00, 'Líbia', '1954-10-09', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (15346089233, 10, 'Cauê Cunha', 75, 799520.00, 'Taiwan', '1963-12-26', 1.93, 73.00, 'VOL', 0);
INSERT INTO funcionario VALUES (65073921895, 10, 'Isaac da Conceição', 72, 2203418.00, 'Egito', '1957-09-24', 1.86, 99.00, 'LE', 0);
INSERT INTO funcionario VALUES (95246081702, 10, 'Marcos Vinicius Caldeira', 71, 2282974.00, 'Kuwait', '1960-10-20', 1.76, 91.00, 'VOL', 0);
INSERT INTO funcionario VALUES (62301845915, 10, 'Luiz Otávio Peixoto', 49, 2159618.00, 'Croácia', '1979-10-08', 1.89, 67.00, 'MEI', 0);
INSERT INTO funcionario VALUES (14306957810, 10, 'Danilo da Luz', 42, 199377.00, 'Ucrânia', '1977-01-17', 1.75, 98.00, 'GOL', 0);
INSERT INTO funcionario VALUES (90453726810, 10, 'Renan Ribeiro', 62, 2273823.00, 'Ilhas dos Cocos', '1980-06-09', 1.91, 73.00, 'PE', 0);
INSERT INTO funcionario VALUES (97034152616, 10, 'Thiago Ramos', 45, 314958.00, 'Polinésia Francesa', '1977-12-28', 1.64, 77.00, 'GOL', 0);
INSERT INTO funcionario VALUES (64320517890, 10, 'Raul Ribeiro', 42, 1799668.00, 'Guatemala', '1971-01-10', 1.88, 95.00, 'PE', 0);
INSERT INTO funcionario VALUES (86072954111, 10, 'Breno Rezende', 50, 1968495.00, 'Vanuatu', '1958-08-25', 1.71, 98.00, 'CA', 0);
INSERT INTO funcionario VALUES (93576804110, 10, 'Lucca Martins', 65, 2308902.00, 'Vietnam', '1966-01-29', 1.96, 83.00, 'MEI', 0);
INSERT INTO funcionario VALUES (95402863105, 10, 'Matheus Alves', 74, 644257.00, 'Mayotte', '1978-01-14', 1.91, 76.00, 'LE', 0);
INSERT INTO funcionario VALUES (37618492069, 10, 'Joaquim Araújo', 41, 392157.00, 'Tuvalu', '1976-07-11', 1.72, 98.00, 'LE', 0);
INSERT INTO funcionario VALUES (59342871097, 10, 'Miguel Martins', 41, 598181.00, 'Macedónia do Norte', '1972-09-19', 1.97, 94.00, 'PE', 0);
INSERT INTO funcionario VALUES (82073945104, 10, 'Thales Moreira', 59, 517865.00, 'Ilhas Salomão', '1967-09-30', 1.90, 81.00, 'LD', 0);
INSERT INTO funcionario VALUES (64130298542, 10, 'Paulo Cunha', 56, 662521.00, 'Santa Helena', '1975-09-13', 1.63, 78.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (40513286780, 10, 'Vitor Hugo Nogueira', 53, 1469673.00, 'Vaticano', '1955-01-24', 1.73, 72.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (95361082406, 10, 'Benício Pereira', 70, 1538115.00, 'Sérvia', '1966-09-10', 1.82, 95.00, 'PE', 0);
INSERT INTO funcionario VALUES (9218543741, 10, 'Alexandre Monteiro', 54, 1954016.00, 'Benim', '1975-09-25', 1.79, 84.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (36457280900, 10, 'Yago Almeida', 69, 193887.00, 'Guernsey', '1953-05-21', 1.97, 93.00, 'ATA', 0);
INSERT INTO funcionario VALUES (94761502380, 10, 'João Miguel Lima', 71, 862540.00, 'Alemanha', '1966-06-10', 1.82, 65.00, 'VOL', 0);
INSERT INTO funcionario VALUES (9417356216, 10, 'Antônio Rocha', 60, 183112.00, 'República Checa', '1963-04-12', 1.68, 73.00, 'PE', 0);
INSERT INTO funcionario VALUES (75908624365, 10, 'Pietro Souza', 43, 2307082.00, 'Costa Rica', '1982-06-21', 1.77, 85.00, 'ATA', 0);
INSERT INTO funcionario VALUES (2786935121, 10, 'Igor Lopes', 58, 522150.00, 'Mayotte', '1980-03-22', 1.62, 92.00, 'PD', 0);
INSERT INTO funcionario VALUES (98310724560, 10, 'Breno Rocha', 41, 1156767.00, 'Costa do Marfim', '1978-03-19', 1.80, 90.00, 'ATA', 0);
INSERT INTO funcionario VALUES (49107528620, 10, 'Francisco Rezende', 56, 2380971.00, 'Guiné Equatorial', '1980-04-24', 1.80, 65.00, 'MEI', 0);
INSERT INTO funcionario VALUES (12038746508, 10, 'Guilherme Viana', 58, 640055.00, 'Eslovênia', '1977-01-03', 1.96, 83.00, 'LE', 0);
INSERT INTO funcionario VALUES (26840513726, 10, 'Yuri da Rocha', 62, 583381.00, 'Namíbia', '1949-07-19', 1.74, 94.00, 'CA', 0);
INSERT INTO funcionario VALUES (16294378087, 10, 'João Gabriel Melo', 56, 1249766.00, 'Níger', '1978-11-15', 1.67, 87.00, 'LE', 0);
INSERT INTO funcionario VALUES (74510298676, 10, 'Augusto Barbosa', 70, 1072518.00, 'Angola', '1974-03-13', 1.87, 90.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (25043697865, 10, 'Augusto da Cruz', 59, 1584268.00, 'Svalbard e Jan Mayen', '1973-08-30', 1.64, 85.00, 'GOL', 0);
INSERT INTO funcionario VALUES (29704581360, 11, 'Heitor Castro', 45, 1918550.00, 'Ilhas dos Cocos', '1952-05-02', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (90653748256, 11, 'Levi Freitas', 65, 541465.00, 'Bósnia e Herzegovina', '1976-11-16', 1.67, 99.00, 'CA', 0);
INSERT INTO funcionario VALUES (86095321433, 11, 'Gustavo Henrique Peixoto', 62, 1254424.00, 'Navassa Island', '1965-12-25', 1.70, 96.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (93768140296, 11, 'Murilo Oliveira', 66, 1633292.00, 'Azerbaijão', '1963-11-17', 1.61, 86.00, 'VOL', 0);
INSERT INTO funcionario VALUES (24105837680, 11, 'João Gabriel Fernandes', 57, 2384169.00, 'Croácia', '1960-04-28', 1.94, 95.00, 'ATA', 0);
INSERT INTO funcionario VALUES (72814903640, 11, 'João Pedro Ribeiro', 48, 252340.00, 'Birmânia', '1965-12-12', 1.70, 80.00, 'ATA', 0);
INSERT INTO funcionario VALUES (28679514020, 11, 'Thales Costela', 56, 1297722.00, 'Jibuti', '1963-01-22', 1.66, 67.00, 'PE', 0);
INSERT INTO funcionario VALUES (79430618296, 11, 'Gustavo Carvalho', 56, 1081361.00, 'Ucrânia', '1959-04-06', 1.60, 75.00, 'PD', 0);
INSERT INTO funcionario VALUES (9538174232, 11, 'Antônio Ferreira', 60, 2332610.00, 'Bermudas', '1979-10-25', 1.78, 85.00, 'CA', 0);
INSERT INTO funcionario VALUES (27169438500, 11, 'Theo Almeida', 52, 1732781.00, 'Dinamarca', '1980-06-18', 1.82, 96.00, 'LE', 0);
INSERT INTO funcionario VALUES (1297658485, 11, 'Leandro Silveira', 57, 1188903.00, 'Polônia', '1952-04-29', 1.82, 65.00, 'PE', 0);
INSERT INTO funcionario VALUES (50186274920, 11, 'Luiz Felipe da Cruz', 61, 2071691.00, 'Canadá', '1948-03-16', 1.93, 95.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (16753804226, 11, 'Juan Viana', 44, 2325330.00, 'Equador', '1980-08-24', 1.72, 82.00, 'GOL', 0);
INSERT INTO funcionario VALUES (83620571902, 11, 'Gustavo Nunes', 63, 1487470.00, 'Mauritânia', '1983-09-01', 1.84, 91.00, 'LD', 0);
INSERT INTO funcionario VALUES (25870694167, 11, 'Davi Freitas', 41, 2031081.00, 'Costa do Marfim', '1977-10-19', 1.64, 72.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (74563801208, 11, 'Miguel Sales', 50, 583842.00, 'Sudão', '1977-03-27', 1.64, 87.00, 'CA', 0);
INSERT INTO funcionario VALUES (63914782013, 11, 'Kaique Novaes', 51, 930279.00, 'Moçambique', '1974-06-21', 1.85, 86.00, 'GOL', 0);
INSERT INTO funcionario VALUES (61792485328, 11, 'Raul da Conceição', 42, 2224412.00, 'Bélgica', '1964-07-24', 1.86, 95.00, 'CA', 0);
INSERT INTO funcionario VALUES (25164780380, 11, 'Heitor Fogaça', 65, 1618546.00, 'China', '1953-04-20', 1.79, 77.00, 'MEI', 0);
INSERT INTO funcionario VALUES (4962385151, 11, 'Heitor Gomes', 45, 408510.00, 'Japão', '1963-09-07', 1.89, 68.00, 'CA', 0);
INSERT INTO funcionario VALUES (63190452806, 11, 'Leonardo Oliveira', 69, 1970304.00, 'Líbia', '1962-06-25', 1.63, 90.00, 'MEI', 0);
INSERT INTO funcionario VALUES (65721843071, 11, 'Benício Nogueira', 62, 2132813.00, 'Mauritânia', '1961-11-18', 1.68, 74.00, 'ATA', 0);
INSERT INTO funcionario VALUES (18532679021, 11, 'Luigi Rodrigues', 49, 203804.00, 'Etiópia', '1958-04-10', 1.74, 67.00, 'VOL', 0);
INSERT INTO funcionario VALUES (80473152690, 11, 'Arthur da Paz', 40, 2183510.00, 'Costa do Marfim', '1978-07-11', 1.82, 100.00, 'VOL', 0);
INSERT INTO funcionario VALUES (72890153630, 11, 'Guilherme Lopes', 41, 1376762.00, 'Cazaquistão', '1976-02-09', 1.87, 75.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (25789631002, 11, 'Daniel Silva', 40, 1173697.00, 'Haiti', '1958-07-21', 1.65, 67.00, 'ATA', 0);
INSERT INTO funcionario VALUES (47361952828, 11, 'Matheus Ribeiro', 58, 1895359.00, 'Uganda', '1957-01-11', 1.78, 98.00, 'MEI', 0);
INSERT INTO funcionario VALUES (36749285155, 11, 'Leandro Teixeira', 46, 1142135.00, 'Brasil', '1958-08-11', 1.96, 69.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (75693148084, 11, 'Juan Pires', 42, 748578.00, 'Cazaquistão', '1982-03-31', 1.85, 77.00, 'GOL', 0);
INSERT INTO funcionario VALUES (82015367977, 11, 'Joaquim Silveira', 71, 711776.00, 'Jan Mayen', '1972-04-21', 1.81, 73.00, 'CA', 0);
INSERT INTO funcionario VALUES (80931245605, 11, 'Vitor Gabriel Moraes', 74, 687351.00, 'Catar', '1978-03-29', 1.98, 88.00, 'ATA', 0);
INSERT INTO funcionario VALUES (94812607396, 12, 'Cauê Lima', 41, 996097.00, 'Bolívia', '1983-11-06', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (29085371686, 12, 'Yuri Carvalho', 68, 1683587.00, 'Togo', '1951-06-12', 1.76, 91.00, 'MEI', 0);
INSERT INTO funcionario VALUES (48952107314, 12, 'Enzo Gabriel Nunes', 60, 2288826.00, 'Bahamas', '1979-12-21', 1.83, 65.00, 'CA', 0);
INSERT INTO funcionario VALUES (59348172646, 12, 'Calebe Nogueira', 48, 1474437.00, 'Madagáscar', '1954-02-25', 1.67, 86.00, 'LE', 0);
INSERT INTO funcionario VALUES (49102678322, 12, 'Yuri Santos', 49, 614783.00, 'Suíça', '1953-03-03', 1.76, 80.00, 'ATA', 0);
INSERT INTO funcionario VALUES (50179268368, 12, 'Fernando Santos', 53, 230111.00, 'Maldivas', '1960-10-26', 1.67, 74.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (98367410548, 12, 'João Gabriel Peixoto', 59, 1717275.00, 'Jamaica', '1975-02-15', 1.61, 81.00, 'CA', 0);
INSERT INTO funcionario VALUES (23906581721, 12, 'Ryan Sales', 75, 2118143.00, 'Macedónia do Norte', '1973-07-30', 1.98, 99.00, 'PD', 0);
INSERT INTO funcionario VALUES (84152906324, 12, 'Thiago da Conceição', 44, 662096.00, 'Moçambique', '1983-04-13', 1.73, 76.00, 'PD', 0);
INSERT INTO funcionario VALUES (27843561080, 12, 'Gabriel Rezende', 72, 1115203.00, 'Domínica', '1977-09-12', 1.63, 83.00, 'PE', 0);
INSERT INTO funcionario VALUES (58621703408, 12, 'Miguel Souza', 41, 706596.00, 'Bolívia', '1950-12-22', 1.73, 78.00, 'PE', 0);
INSERT INTO funcionario VALUES (98713560212, 12, 'João Pedro Pinto', 63, 2332617.00, 'Pitcairn', '1953-04-21', 1.87, 76.00, 'ATA', 0);
INSERT INTO funcionario VALUES (50162839405, 12, 'Miguel Farias', 63, 2075529.00, 'Hungria', '1967-10-16', 1.89, 97.00, 'CA', 0);
INSERT INTO funcionario VALUES (86197345200, 12, 'João Pedro Correia', 60, 2147538.00, 'Roménia', '1960-11-21', 1.92, 71.00, 'VOL', 0);
INSERT INTO funcionario VALUES (26143795819, 12, 'Enrico Barbosa', 40, 1532738.00, 'Nepal', '1970-04-27', 1.79, 90.00, 'PE', 0);
INSERT INTO funcionario VALUES (7825931602, 12, 'Luigi Oliveira', 49, 324522.00, 'Coreia do Sul', '1956-03-25', 1.67, 72.00, 'PE', 0);
INSERT INTO funcionario VALUES (39425016860, 12, 'Pietro Gonçalves', 50, 1092605.00, 'Antártica', '1960-11-18', 1.60, 85.00, 'LE', 0);
INSERT INTO funcionario VALUES (94037261561, 12, 'Emanuel da Conceição', 50, 2228488.00, 'Faroé', '1960-05-15', 1.64, 83.00, 'PE', 0);
INSERT INTO funcionario VALUES (45907812397, 12, 'Joaquim Jesus', 60, 1272885.00, 'Territórios Austrais Franceses', '1957-07-11', 1.89, 76.00, 'PE', 0);
INSERT INTO funcionario VALUES (64523789100, 12, 'Diego Moraes', 53, 538644.00, 'Mônaco', '1973-04-24', 1.65, 76.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (23471658955, 12, 'Luiz Henrique Rodrigues', 40, 537442.00, 'Camboja', '1954-02-10', 1.63, 74.00, 'PD', 0);
INSERT INTO funcionario VALUES (54693281042, 12, 'Enzo Gabriel Santos', 66, 2131463.00, 'Nepal', '1966-09-08', 1.63, 79.00, 'MEI', 0);
INSERT INTO funcionario VALUES (43021859704, 12, 'Kaique Moura', 67, 1130020.00, 'Iraque', '1980-03-28', 1.94, 86.00, 'MEI', 0);
INSERT INTO funcionario VALUES (5176894211, 12, 'Anthony Fernandes', 68, 2102343.00, 'Usbequistão', '1956-04-01', 1.69, 69.00, 'CA', 0);
INSERT INTO funcionario VALUES (61928375030, 12, 'Yago Moreira', 47, 1301127.00, 'Suriname', '1962-05-08', 1.88, 92.00, 'CA', 0);
INSERT INTO funcionario VALUES (60243981740, 12, 'Davi Lucas da Cruz', 71, 2367134.00, 'Trindade e Tobago', '1952-01-29', 1.85, 92.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (69358271086, 12, 'Pedro Henrique da Conceição', 71, 1709252.00, 'Guiana', '1956-01-10', 1.86, 68.00, 'MEI', 0);
INSERT INTO funcionario VALUES (70298436140, 12, 'Heitor Sales', 44, 1753044.00, 'Haiti', '1981-09-23', 1.79, 92.00, 'GOL', 0);
INSERT INTO funcionario VALUES (54269073829, 12, 'Danilo Lopes', 64, 1387675.00, 'República Checa', '1948-05-13', 1.88, 88.00, 'LE', 0);
INSERT INTO funcionario VALUES (78410625326, 12, 'Paulo Barros', 61, 1068130.00, 'Índia', '1957-01-25', 1.67, 96.00, 'PE', 0);
INSERT INTO funcionario VALUES (61023478544, 12, 'Raul Alves', 59, 1290668.00, 'Emirados Árabes Unidos', '1964-08-12', 1.94, 68.00, 'PE', 0);
INSERT INTO funcionario VALUES (27365948000, 13, 'Leonardo da Cruz', 55, 1310218.00, 'Tuvalu', '1957-11-03', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (83026145998, 13, 'Guilherme Mendes', 55, 2310317.00, 'Afeganistão', '1980-10-06', 1.78, 81.00, 'ATA', 0);
INSERT INTO funcionario VALUES (8639712530, 13, 'Juan Ramos', 65, 1760505.00, 'Brunei', '1979-11-12', 1.95, 99.00, 'CA', 0);
INSERT INTO funcionario VALUES (4689512370, 13, 'Lucas Silveira', 73, 409354.00, 'Indonésia', '1962-01-18', 1.96, 81.00, 'CA', 0);
INSERT INTO funcionario VALUES (37410285680, 13, 'Benjamin Duarte', 49, 237281.00, 'Cazaquistão', '1969-09-16', 1.97, 84.00, 'PD', 0);
INSERT INTO funcionario VALUES (28650973400, 13, 'Paulo Viana', 66, 1269555.00, 'Azerbaijão', '1976-06-27', 1.91, 85.00, 'VOL', 0);
INSERT INTO funcionario VALUES (3612487507, 13, 'Henrique Barbosa', 58, 1950207.00, 'Argentina', '1963-05-10', 1.61, 66.00, 'GOL', 0);
INSERT INTO funcionario VALUES (39175680475, 13, 'Davi Souza', 68, 1803633.00, 'Papua-Nova Guiné', '1975-07-23', 1.90, 66.00, 'LE', 0);
INSERT INTO funcionario VALUES (10498627322, 13, 'Felipe Moura', 52, 146525.00, 'Filipinas', '1952-05-02', 1.85, 91.00, 'PE', 0);
INSERT INTO funcionario VALUES (46802597365, 13, 'Vitor Hugo Costa', 41, 435746.00, 'Coral Sea Islands', '1958-09-19', 1.62, 98.00, 'LE', 0);
INSERT INTO funcionario VALUES (39480576210, 13, 'Diogo Castro', 42, 751356.00, 'Filipinas', '1970-07-16', 1.89, 76.00, 'LE', 0);
INSERT INTO funcionario VALUES (2916538470, 13, 'Lucas Gabriel Cardoso', 62, 2380149.00, 'Bangladesh', '1963-12-04', 1.78, 72.00, 'LD', 0);
INSERT INTO funcionario VALUES (73504826983, 13, 'Heitor Rodrigues', 52, 912217.00, 'Jordânia', '1950-02-05', 1.63, 89.00, 'PD', 0);
INSERT INTO funcionario VALUES (3849621731, 13, 'Renan Lopes', 70, 1642523.00, 'Akrotiri', '1978-10-07', 1.83, 92.00, 'LE', 0);
INSERT INTO funcionario VALUES (87961405267, 13, 'Luiz Miguel Rezende', 64, 2117882.00, 'Gibraltar', '1955-02-20', 1.92, 79.00, 'LD', 0);
INSERT INTO funcionario VALUES (3246517835, 13, 'Lucas Gabriel da Cunha', 50, 769612.00, 'Domínica', '1977-10-19', 1.65, 85.00, 'MEI', 0);
INSERT INTO funcionario VALUES (21308496524, 13, 'Vitor Pereira', 62, 824381.00, 'Nepal', '1979-05-05', 1.86, 95.00, 'LD', 0);
INSERT INTO funcionario VALUES (7431965893, 13, 'Lucas Azevedo', 40, 1390200.00, 'Quiribáti', '1951-06-23', 1.78, 96.00, 'MEI', 0);
INSERT INTO funcionario VALUES (25986731077, 13, 'Luiz Gustavo Rodrigues', 72, 1011692.00, 'Navassa Island', '1978-01-10', 1.88, 73.00, 'PD', 0);
INSERT INTO funcionario VALUES (36059471234, 13, 'Vitor Gabriel Cardoso', 44, 1605428.00, 'Brasil', '1952-08-22', 1.88, 92.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (61754230890, 13, 'Lucas Castro', 70, 1901613.00, 'Belize', '1983-06-22', 1.88, 74.00, 'GOL', 0);
INSERT INTO funcionario VALUES (5189746267, 13, 'Davi Cunha', 67, 1682306.00, 'Birmânia', '1964-01-24', 1.69, 93.00, 'LD', 0);
INSERT INTO funcionario VALUES (9123486740, 13, 'Isaac da Paz', 49, 615910.00, 'Ilhas Turcas e Caicos', '1981-11-11', 1.91, 76.00, 'LE', 0);
INSERT INTO funcionario VALUES (59462037892, 13, 'Leonardo Rezende', 46, 1939848.00, 'Etiópia', '1972-11-22', 1.76, 92.00, 'PE', 0);
INSERT INTO funcionario VALUES (76094352874, 13, 'Juan Rezende', 75, 958768.00, 'Togo', '1958-06-07', 1.63, 80.00, 'MEI', 0);
INSERT INTO funcionario VALUES (23459610743, 13, 'Luiz Miguel Lima', 67, 247781.00, 'Luxemburgo', '1976-03-31', 1.77, 80.00, 'MEI', 0);
INSERT INTO funcionario VALUES (43679812078, 13, 'Bryan Monteiro', 63, 182922.00, 'Serra Leoa', '1962-08-29', 1.65, 92.00, 'GOL', 0);
INSERT INTO funcionario VALUES (30679452800, 13, 'João Felipe Lopes', 48, 1683188.00, 'Guiné-Bissau', '1960-01-11', 1.72, 93.00, 'LD', 0);
INSERT INTO funcionario VALUES (46150928306, 13, 'Leonardo Pereira', 73, 2035395.00, 'Cuba', '1950-10-08', 1.86, 82.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (19580263442, 13, 'Thales Alves', 71, 1896549.00, 'Tonga', '1962-03-19', 1.73, 99.00, 'MEI', 0);
INSERT INTO funcionario VALUES (7346951875, 13, 'Davi Luiz Souza', 74, 2470382.00, 'Quênia', '1964-12-02', 1.79, 98.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (37542698010, 14, 'Marcelo Farias', 73, 2352483.00, 'Turquia', '1960-05-13', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (93608154205, 14, 'Fernando Vieira', 52, 2397077.00, 'Turquia', '1952-11-13', 1.97, 84.00, 'MEI', 0);
INSERT INTO funcionario VALUES (34280917523, 14, 'Vitor Ribeiro', 54, 313689.00, 'Mauritânia', '1965-11-11', 1.61, 90.00, 'LD', 0);
INSERT INTO funcionario VALUES (64378210940, 14, 'Davi Lucca Freitas', 73, 1229502.00, 'Guiné Equatorial', '1966-07-30', 1.87, 71.00, 'GOL', 0);
INSERT INTO funcionario VALUES (97531802686, 14, 'Calebe Fogaça', 65, 627484.00, 'Nicarágua', '1954-06-24', 1.90, 76.00, 'MEI', 0);
INSERT INTO funcionario VALUES (96714038593, 14, 'Samuel Souza', 62, 501029.00, 'Liechtenstein', '1974-03-07', 1.86, 68.00, 'ATA', 0);
INSERT INTO funcionario VALUES (84302961740, 14, 'Calebe Duarte', 62, 1589115.00, 'Áustria', '1970-03-15', 1.62, 90.00, 'LE', 0);
INSERT INTO funcionario VALUES (23416059824, 14, 'Thales Peixoto', 49, 1673955.00, 'Uganda', '1954-05-11', 1.75, 77.00, 'ATA', 0);
INSERT INTO funcionario VALUES (25869073456, 14, 'Felipe Freitas', 46, 2383610.00, 'Gana', '1980-04-27', 1.95, 90.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (80462175901, 14, 'Davi Lucca Gonçalves', 72, 2334164.00, 'Nigéria', '1965-09-19', 1.93, 87.00, 'VOL', 0);
INSERT INTO funcionario VALUES (9245673170, 14, 'Lucca Rocha', 69, 975040.00, 'Ilhas Virgens Britânicas', '1966-04-28', 1.97, 96.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (46702931840, 14, 'Thomas Peixoto', 58, 1303902.00, 'Chade', '1977-02-26', 1.62, 89.00, 'GOL', 0);
INSERT INTO funcionario VALUES (95267130877, 14, 'Enzo Gabriel da Mota', 71, 1381540.00, 'Bolívia', '1949-12-19', 1.60, 72.00, 'LE', 0);
INSERT INTO funcionario VALUES (53689214033, 14, 'Enrico Teixeira', 73, 1731565.00, 'Malásia', '1976-05-14', 1.71, 93.00, 'MEI', 0);
INSERT INTO funcionario VALUES (92316547052, 14, 'Yuri Cardoso', 61, 899923.00, 'Egito', '1978-09-01', 1.80, 69.00, 'MEI', 0);
INSERT INTO funcionario VALUES (73186054290, 14, 'João Pedro Gomes', 66, 1181847.00, 'Mauritânia', '1979-07-07', 1.74, 81.00, 'LE', 0);
INSERT INTO funcionario VALUES (69342108750, 14, 'Benício Sales', 69, 386112.00, 'Domínica', '1982-03-24', 1.98, 87.00, 'ATA', 0);
INSERT INTO funcionario VALUES (63705491261, 14, 'Henrique Ferreira', 70, 255544.00, 'Wake Island', '1975-06-19', 1.81, 84.00, 'LE', 0);
INSERT INTO funcionario VALUES (84356071271, 14, 'Caio Sales', 52, 1734296.00, 'Moldávia', '1959-06-09', 1.61, 90.00, 'CA', 0);
INSERT INTO funcionario VALUES (65019372803, 14, 'Gustavo Nunes', 72, 2331094.00, 'Trindade e Tobago', '1949-10-13', 1.77, 77.00, 'CA', 0);
INSERT INTO funcionario VALUES (40398751250, 14, 'Pietro Alves', 68, 303325.00, 'Áustria', '1965-09-11', 1.71, 65.00, 'LE', 0);
INSERT INTO funcionario VALUES (49532087141, 14, 'Danilo Porto', 55, 1920110.00, 'Mali', '1950-06-09', 1.64, 66.00, 'MEI', 0);
INSERT INTO funcionario VALUES (98415036205, 14, 'Lucca Moraes', 40, 1856728.00, 'Bolívia', '1949-04-22', 1.76, 78.00, 'PE', 0);
INSERT INTO funcionario VALUES (70613245970, 14, 'Nathan da Mota', 45, 1916722.00, 'Marianas do Norte', '1970-02-13', 1.85, 75.00, 'LD', 0);
INSERT INTO funcionario VALUES (68914730557, 14, 'Lucas Cardoso', 47, 2393495.00, 'São Marinho', '1983-12-23', 1.87, 97.00, 'ATA', 0);
INSERT INTO funcionario VALUES (3951462833, 14, 'Erick Castro', 54, 825804.00, 'Luxemburgo', '1979-01-11', 1.61, 93.00, 'CA', 0);
INSERT INTO funcionario VALUES (68349721022, 14, 'Danilo Castro', 43, 168391.00, 'Chipre', '1969-10-13', 1.76, 89.00, 'MEI', 0);
INSERT INTO funcionario VALUES (50327984600, 14, 'Eduardo Jesus', 46, 447089.00, 'Palau', '1982-07-29', 1.86, 82.00, 'ATA', 0);
INSERT INTO funcionario VALUES (20983154651, 14, 'Vitor Gabriel Pinto', 66, 528072.00, 'Rússia', '1972-12-02', 1.77, 66.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (80762354992, 14, 'Theo Farias', 71, 2198553.00, 'Eslováquia', '1950-10-15', 1.87, 99.00, 'VOL', 0);
INSERT INTO funcionario VALUES (92058143698, 14, 'Matheus Fernandes', 42, 1903033.00, 'Antilhas Holandesas', '1960-06-28', 1.97, 80.00, 'LE', 0);
INSERT INTO funcionario VALUES (27890364113, 15, 'Theo Rezende', 53, 1676299.00, 'Faroé', '1948-06-07', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (17465902380, 15, 'Gustavo Campos', 50, 921449.00, 'Niue', '1959-11-14', 1.82, 81.00, 'ATA', 0);
INSERT INTO funcionario VALUES (73805612435, 15, 'Ian da Mota', 60, 1513869.00, 'Sri Lanka', '1952-05-26', 1.66, 100.00, 'LD', 0);
INSERT INTO funcionario VALUES (62945710811, 15, 'Davi Lucas Costa', 63, 1987362.00, 'Madagáscar', '1971-05-10', 1.77, 89.00, 'GOL', 0);
INSERT INTO funcionario VALUES (6518239433, 15, 'Nathan Pires', 42, 583211.00, 'Vaticano', '1975-04-21', 1.81, 94.00, 'GOL', 0);
INSERT INTO funcionario VALUES (24756908101, 15, 'Noah Cardoso', 59, 437026.00, 'Vaticano', '1976-10-20', 1.71, 77.00, 'VOL', 0);
INSERT INTO funcionario VALUES (28674139582, 15, 'João Miguel Silva', 65, 2259504.00, 'Cabo Verde', '1974-11-26', 1.75, 73.00, 'LD', 0);
INSERT INTO funcionario VALUES (96341275099, 15, 'Marcelo Caldeira', 63, 2228672.00, 'Ilhas Salomão', '1980-10-25', 1.64, 82.00, 'LD', 0);
INSERT INTO funcionario VALUES (53247186026, 15, 'Henrique Santos', 55, 457634.00, 'Coreia do Norte', '1968-12-24', 1.65, 66.00, 'CA', 0);
INSERT INTO funcionario VALUES (62784905365, 15, 'Luiz Miguel Azevedo', 49, 1093148.00, 'Panamá', '1966-03-09', 1.78, 67.00, 'LE', 0);
INSERT INTO funcionario VALUES (39274865155, 15, 'André da Costa', 68, 1816052.00, 'Finlândia', '1961-01-09', 1.70, 83.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (37548109288, 15, 'João Pedro Gomes', 48, 2114996.00, 'Moçambique', '1979-07-09', 1.98, 74.00, 'ATA', 0);
INSERT INTO funcionario VALUES (26159873059, 15, 'Thomas da Paz', 59, 1232749.00, 'Nicarágua', '1969-02-12', 1.79, 74.00, 'PD', 0);
INSERT INTO funcionario VALUES (48715362035, 15, 'Antônio Alves', 67, 681334.00, 'África do Sul', '1960-12-25', 1.63, 84.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (54612790316, 15, 'Marcelo Rocha', 44, 2188063.00, 'Jersey', '1948-08-08', 1.85, 97.00, 'LE', 0);
INSERT INTO funcionario VALUES (81230457941, 15, 'Cauê Aragão', 50, 980491.00, 'São Cristóvão e Neves', '1966-12-17', 1.67, 81.00, 'VOL', 0);
INSERT INTO funcionario VALUES (40217369804, 15, 'Thales Correia', 46, 2256994.00, 'Antilhas Holandesas', '1981-04-04', 1.67, 100.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (54273618982, 15, 'Daniel Castro', 40, 1008858.00, 'Bélgica', '1981-01-09', 1.74, 89.00, 'LE', 0);
INSERT INTO funcionario VALUES (89371245050, 15, 'Pedro Lucas Viana', 71, 1664067.00, 'Irlanda', '1948-05-20', 1.96, 89.00, 'CA', 0);
INSERT INTO funcionario VALUES (19843506766, 15, 'Luiz Felipe Moura', 50, 266047.00, 'Equador', '1967-07-31', 1.98, 67.00, 'ATA', 0);
INSERT INTO funcionario VALUES (25406137999, 15, 'Luigi Sales', 46, 2347421.00, 'Burundi', '1977-06-30', 1.70, 69.00, 'CA', 0);
INSERT INTO funcionario VALUES (70513289640, 15, 'Eduardo Rezende', 75, 2220786.00, 'Dhekelia', '1967-07-14', 1.78, 69.00, 'VOL', 0);
INSERT INTO funcionario VALUES (68243790500, 15, 'Joaquim Mendes', 64, 943366.00, 'Malta', '1949-12-03', 1.91, 91.00, 'PE', 0);
INSERT INTO funcionario VALUES (8456731226, 15, 'Pietro Moura', 50, 203188.00, 'Usbequistão', '1973-06-04', 1.92, 75.00, 'LD', 0);
INSERT INTO funcionario VALUES (2475169370, 15, 'Davi Costa', 53, 940882.00, 'Butão', '1958-03-06', 1.86, 76.00, 'LE', 0);
INSERT INTO funcionario VALUES (83740621931, 15, 'Bernardo Nascimento', 48, 208516.00, 'Letônia', '1962-01-21', 1.77, 99.00, 'ATA', 0);
INSERT INTO funcionario VALUES (20739165895, 15, 'Vitor Gabriel Nunes', 65, 1261383.00, 'Haiti', '1957-01-02', 1.66, 82.00, 'ATA', 0);
INSERT INTO funcionario VALUES (36851794039, 15, 'Luiz Felipe Porto', 52, 1295153.00, 'Bielorrússia', '1949-03-12', 1.90, 94.00, 'VOL', 0);
INSERT INTO funcionario VALUES (57983024150, 15, 'Caio Dias', 70, 682649.00, 'Trindade e Tobago', '1956-03-06', 1.81, 79.00, 'ATA', 0);
INSERT INTO funcionario VALUES (92514867002, 15, 'Lucca Teixeira', 41, 2426350.00, 'Navassa Island', '1954-03-29', 1.75, 100.00, 'PD', 0);
INSERT INTO funcionario VALUES (95210786340, 15, 'Enrico da Mata', 58, 963682.00, 'Mayotte', '1973-04-24', 1.95, 77.00, 'VOL', 0);
INSERT INTO funcionario VALUES (3629158498, 16, 'Enrico Dias', 51, 2069035.00, 'Nova Caledónia', '1983-05-21', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (29867415337, 16, 'Pietro Teixeira', 67, 1106271.00, 'Liechtenstein', '1979-12-20', 1.89, 87.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (83054962792, 16, 'André Carvalho', 49, 1548224.00, 'Iran', '1976-04-06', 1.75, 79.00, 'LE', 0);
INSERT INTO funcionario VALUES (31724058932, 16, 'Leandro Silveira', 67, 2288266.00, 'Paquistão', '1952-03-14', 1.93, 98.00, 'GOL', 0);
INSERT INTO funcionario VALUES (26087153462, 16, 'Pedro Henrique Silveira', 57, 1198818.00, 'Burquina Faso', '1954-01-04', 1.92, 66.00, 'MEI', 0);
INSERT INTO funcionario VALUES (6913257821, 16, 'Leonardo Almeida', 70, 1755214.00, 'República Dominicana', '1973-02-20', 1.98, 84.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (51384297014, 16, 'Diego da Cunha', 66, 988669.00, 'Vaticano', '1960-01-21', 1.61, 100.00, 'PE', 0);
INSERT INTO funcionario VALUES (5164873966, 16, 'Juan Nunes', 47, 2363614.00, 'Croácia', '1958-01-25', 1.72, 76.00, 'PE', 0);
INSERT INTO funcionario VALUES (76480593200, 16, 'João Rodrigues', 74, 2044159.00, 'Venezuela', '1958-05-14', 1.65, 90.00, 'ATA', 0);
INSERT INTO funcionario VALUES (56237091416, 16, 'Rodrigo Rocha', 44, 1363632.00, 'Samoa Americana', '1957-02-21', 1.62, 92.00, 'VOL', 0);
INSERT INTO funcionario VALUES (23045697810, 16, 'Gabriel das Neves', 66, 1850824.00, 'Vietnam', '1959-06-28', 1.63, 70.00, 'MEI', 0);
INSERT INTO funcionario VALUES (83456217919, 16, 'João Lucas Lima', 75, 1900596.00, 'Vietnam', '1965-01-12', 1.69, 91.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (73816549039, 16, 'João Cardoso', 45, 719357.00, 'Suriname', '1967-09-06', 1.60, 87.00, 'MEI', 0);
INSERT INTO funcionario VALUES (56948702392, 16, 'Thomas Cardoso', 66, 209599.00, 'Sérvia', '1958-07-14', 1.90, 86.00, 'VOL', 0);
INSERT INTO funcionario VALUES (6835941251, 16, 'Luiz Henrique Cardoso', 71, 306440.00, 'Nepal', '1975-08-21', 1.87, 83.00, 'PD', 0);
INSERT INTO funcionario VALUES (65403819215, 16, 'Murilo Fernandes', 48, 589995.00, 'Portugal', '1968-03-11', 1.75, 83.00, 'LD', 0);
INSERT INTO funcionario VALUES (46913702850, 16, 'Vicente Caldeira', 52, 2499509.00, 'Alemanha', '1957-03-18', 1.85, 79.00, 'PD', 0);
INSERT INTO funcionario VALUES (36479805100, 16, 'Enzo Gabriel Monteiro', 44, 1755865.00, 'Estados Unidos', '1974-09-12', 1.84, 78.00, 'PD', 0);
INSERT INTO funcionario VALUES (81069742511, 16, 'Lucas Souza', 66, 560785.00, 'Brasil', '1963-04-29', 1.83, 84.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (84356210735, 16, 'Miguel Freitas', 52, 1345044.00, 'Níger', '1978-01-12', 1.61, 65.00, 'MEI', 0);
INSERT INTO funcionario VALUES (16037845271, 16, 'Lucca da Cunha', 63, 1975189.00, 'São Pedro e Miquelon', '1955-06-17', 1.98, 98.00, 'VOL', 0);
INSERT INTO funcionario VALUES (5683297168, 16, 'Theo Carvalho', 46, 1676510.00, 'Polinésia Francesa', '1970-12-04', 1.76, 76.00, 'LE', 0);
INSERT INTO funcionario VALUES (91250463734, 16, 'Enrico Correia', 62, 984041.00, 'Wallis e Futuna', '1976-05-18', 1.77, 67.00, 'LD', 0);
INSERT INTO funcionario VALUES (25736148080, 16, 'Lorenzo Lima', 51, 1894827.00, 'Eslovênia', '1976-07-18', 1.86, 74.00, 'CA', 0);
INSERT INTO funcionario VALUES (12873549637, 16, 'Davi Nunes', 47, 1314272.00, 'Honduras', '1966-08-05', 1.75, 68.00, 'LD', 0);
INSERT INTO funcionario VALUES (47981350620, 16, 'Erick Gomes', 58, 1902137.00, 'União Europeia', '1973-01-12', 1.87, 74.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (97125843646, 16, 'Kevin Peixoto', 56, 541659.00, 'Malta', '1953-05-31', 1.64, 81.00, 'GOL', 0);
INSERT INTO funcionario VALUES (75639041234, 16, 'Juan Silva', 41, 683954.00, 'Cabo Verde', '1980-11-16', 1.65, 99.00, 'GOL', 0);
INSERT INTO funcionario VALUES (62508937177, 16, 'João Pedro Barros', 54, 668816.00, 'Afeganistão', '1981-05-13', 1.63, 71.00, 'MEI', 0);
INSERT INTO funcionario VALUES (92734168022, 16, 'João Guilherme das Neves', 49, 378710.00, 'Uruguai', '1956-01-02', 1.87, 82.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (15367890466, 16, 'Miguel Azevedo', 62, 1578955.00, 'Mali', '1974-05-09', 1.74, 68.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (56289031759, 17, 'Lucca Oliveira', 58, 1298156.00, 'Hong Kong', '1973-03-06', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (20968413722, 17, 'Pedro Lucas Costa', 53, 872083.00, 'Namíbia', '1960-03-01', 1.96, 82.00, 'LE', 0);
INSERT INTO funcionario VALUES (80254913660, 17, 'Henrique Ribeiro', 46, 1819537.00, 'Costa Rica', '1961-01-09', 1.77, 88.00, 'ATA', 0);
INSERT INTO funcionario VALUES (58027193621, 17, 'Leonardo Santos', 59, 848636.00, 'Serra Leoa', '1981-05-23', 1.79, 81.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (91827405341, 17, 'Enzo Gabriel Aragão', 57, 1155963.00, 'Ilhas Cook', '1950-11-11', 1.77, 69.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (25134698015, 17, 'Thomas Souza', 64, 1751273.00, 'Papua-Nova Guiné', '1956-03-01', 1.66, 98.00, 'CA', 0);
INSERT INTO funcionario VALUES (7159842332, 17, 'Fernando Caldeira', 60, 203926.00, 'Iran', '1979-03-01', 1.83, 94.00, 'PD', 0);
INSERT INTO funcionario VALUES (58043261989, 17, 'Pedro Cavalcanti', 61, 2423211.00, 'Timor Leste', '1967-04-21', 1.71, 86.00, 'ATA', 0);
INSERT INTO funcionario VALUES (73542908150, 17, 'Bruno Farias', 55, 2354465.00, 'Cuba', '1951-09-11', 1.70, 85.00, 'VOL', 0);
INSERT INTO funcionario VALUES (6497352180, 17, 'Davi Luiz Rezende', 57, 1774181.00, 'Ilha do Natal', '1959-06-21', 1.86, 92.00, 'PD', 0);
INSERT INTO funcionario VALUES (52704831904, 17, 'João Lucas Farias', 63, 419880.00, 'Dhekelia', '1982-06-26', 1.65, 76.00, 'PE', 0);
INSERT INTO funcionario VALUES (78625094392, 17, 'Isaac Dias', 69, 411941.00, 'Bulgária', '1952-11-09', 1.69, 88.00, 'PE', 0);
INSERT INTO funcionario VALUES (29013465706, 17, 'Emanuel Silveira', 60, 752762.00, 'Honduras', '1949-07-20', 1.73, 72.00, 'PD', 0);
INSERT INTO funcionario VALUES (47532890600, 17, 'Ian Freitas', 50, 1420542.00, 'Monserrate', '1953-03-01', 1.88, 83.00, 'MEI', 0);
INSERT INTO funcionario VALUES (56437928000, 17, 'Vitor Hugo Moreira', 43, 431072.00, 'Aruba', '1980-08-20', 1.86, 77.00, 'LE', 0);
INSERT INTO funcionario VALUES (94321078504, 17, 'Carlos Eduardo Aragão', 56, 291622.00, 'Taiwan', '1956-01-09', 1.81, 82.00, 'LE', 0);
INSERT INTO funcionario VALUES (39108726469, 17, 'Pedro Miguel Cavalcanti', 62, 1322992.00, 'França', '1960-10-31', 1.90, 94.00, 'PE', 0);
INSERT INTO funcionario VALUES (25413087950, 17, 'Lucca Correia', 58, 254535.00, 'Nauru', '1967-10-03', 1.87, 70.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (82543170626, 17, 'Luiz Miguel Nogueira', 72, 501569.00, 'Sérvia', '1962-04-04', 1.83, 65.00, 'GOL', 0);
INSERT INTO funcionario VALUES (97831025405, 17, 'Luiz Fernando Cunha', 59, 1276202.00, 'Moçambique', '1961-06-23', 1.80, 88.00, 'ATA', 0);
INSERT INTO funcionario VALUES (58627149011, 17, 'Renan da Conceição', 58, 102539.00, 'Birmânia', '1970-10-16', 1.95, 88.00, 'LE', 0);
INSERT INTO funcionario VALUES (54318267946, 17, 'Benjamin da Rosa', 40, 350918.00, 'Papua-Nova Guiné', '1964-02-05', 1.95, 79.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (45628791300, 17, 'Vicente Castro', 42, 1771968.00, 'Antilhas Holandesas', '1967-02-23', 1.62, 74.00, 'LD', 0);
INSERT INTO funcionario VALUES (19834706278, 17, 'Matheus da Mata', 72, 1697660.00, 'Tajiquistão', '1953-12-31', 1.79, 75.00, 'GOL', 0);
INSERT INTO funcionario VALUES (12479536882, 17, 'Gustavo Henrique Almeida', 73, 2378654.00, 'Andorra', '1963-01-13', 1.69, 95.00, 'ATA', 0);
INSERT INTO funcionario VALUES (13965428098, 17, 'Luigi Alves', 50, 2117467.00, 'Egito', '1954-09-09', 1.95, 68.00, 'LE', 0);
INSERT INTO funcionario VALUES (94075283160, 17, 'Kaique Pires', 61, 2249474.00, 'Samoa', '1981-08-13', 1.82, 82.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (26890417313, 17, 'Luiz Gustavo Caldeira', 75, 2098548.00, 'Macau', '1951-04-21', 1.94, 76.00, 'MEI', 0);
INSERT INTO funcionario VALUES (80341956775, 17, 'Caio Fogaça', 69, 2222984.00, 'Domínica', '1962-03-13', 1.62, 97.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (47291865085, 17, 'Luiz Gustavo Costa', 50, 1035557.00, 'Guiné', '1966-03-10', 1.64, 87.00, 'CA', 0);
INSERT INTO funcionario VALUES (95061237803, 17, 'João Vitor Silva', 60, 313582.00, 'Guiana', '1970-01-05', 1.93, 73.00, 'PE', 0);
INSERT INTO funcionario VALUES (27430591680, 18, 'Benício Barros', 63, 403661.00, 'Birmânia', '1975-08-24', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (64310927831, 18, 'Ian Ferreira', 52, 1617113.00, 'Tajiquistão', '1957-11-30', 1.98, 84.00, 'VOL', 0);
INSERT INTO funcionario VALUES (78245196002, 18, 'Juan Castro', 62, 542393.00, 'Wake Island', '1955-05-11', 1.92, 81.00, 'CA', 0);
INSERT INTO funcionario VALUES (5687321462, 18, 'Luiz Henrique Almeida', 55, 1355140.00, 'Ilhas Marshall', '1981-12-28', 1.90, 76.00, 'GOL', 0);
INSERT INTO funcionario VALUES (49163520842, 18, 'Cauã Lima', 42, 771904.00, 'Mayotte', '1949-06-08', 1.77, 93.00, 'LE', 0);
INSERT INTO funcionario VALUES (6953821795, 18, 'Vicente Vieira', 67, 1230132.00, 'Congo-Brazzaville', '1979-04-16', 1.73, 70.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (8627314535, 18, 'Calebe Sales', 61, 2377109.00, 'Singapura', '1965-12-31', 1.72, 65.00, 'ATA', 0);
INSERT INTO funcionario VALUES (57481026335, 18, 'Kevin Viana', 62, 1295113.00, 'Azerbaijão', '1974-03-08', 1.85, 75.00, 'VOL', 0);
INSERT INTO funcionario VALUES (23740958600, 18, 'Leonardo da Cunha', 59, 1245564.00, 'Congo-Brazzaville', '1975-11-29', 1.65, 65.00, 'CA', 0);
INSERT INTO funcionario VALUES (98406725176, 18, 'Gabriel Pinto', 69, 624706.00, 'Austrália', '1970-10-08', 1.85, 88.00, 'PE', 0);
INSERT INTO funcionario VALUES (96407385229, 18, 'Calebe Viana', 63, 940752.00, 'Líbia', '1957-08-09', 1.68, 94.00, 'VOL', 0);
INSERT INTO funcionario VALUES (85916423098, 18, 'Lucca Caldeira', 54, 961280.00, 'Guiné', '1972-06-04', 1.97, 91.00, 'CA', 0);
INSERT INTO funcionario VALUES (84061579258, 18, 'Noah Cunha', 52, 2453179.00, 'Gana', '1953-03-02', 1.87, 96.00, 'PD', 0);
INSERT INTO funcionario VALUES (47019628303, 18, 'Guilherme Nascimento', 74, 767569.00, 'Ilha do Natal', '1962-09-13', 1.96, 98.00, 'LD', 0);
INSERT INTO funcionario VALUES (70615389457, 18, 'João Felipe Pereira', 57, 636376.00, 'Alemanha', '1955-10-22', 1.97, 77.00, 'CA', 0);
INSERT INTO funcionario VALUES (81723596400, 18, 'Vitor Gabriel Cardoso', 63, 600397.00, 'Macedónia do Norte', '1955-09-08', 1.62, 90.00, 'CA', 0);
INSERT INTO funcionario VALUES (83194752600, 18, 'Thiago Melo', 42, 2457073.00, 'Jan Mayen', '1974-12-20', 1.79, 67.00, 'PE', 0);
INSERT INTO funcionario VALUES (7384516900, 18, 'Samuel Nunes', 42, 2310465.00, 'Bulgária', '1981-01-14', 1.74, 81.00, 'LD', 0);
INSERT INTO funcionario VALUES (79628310496, 18, 'Joaquim Porto', 71, 1779383.00, 'Vaticano', '1978-04-21', 1.63, 90.00, 'CA', 0);
INSERT INTO funcionario VALUES (40295138670, 18, 'Theo Moreira', 59, 1975079.00, 'Samoa Americana', '1950-10-29', 1.62, 87.00, 'MEI', 0);
INSERT INTO funcionario VALUES (98345276083, 18, 'João Felipe Oliveira', 69, 330872.00, 'Seicheles', '1979-04-14', 1.65, 84.00, 'ATA', 0);
INSERT INTO funcionario VALUES (85601937400, 18, 'Anthony Moraes', 49, 897751.00, 'Belize', '1964-05-13', 1.61, 88.00, 'MEI', 0);
INSERT INTO funcionario VALUES (25061897420, 18, 'Heitor Duarte', 54, 645047.00, 'Território Britânico do Oceano Índico', '1949-10-21', 1.77, 66.00, 'VOL', 0);
INSERT INTO funcionario VALUES (19846305206, 18, 'Thomas Rocha', 73, 1898901.00, 'Uruguai', '1968-08-23', 1.83, 100.00, 'LE', 0);
INSERT INTO funcionario VALUES (41723865044, 18, 'Leandro da Cruz', 70, 141521.00, 'Navassa Island', '1970-07-26', 1.60, 85.00, 'ATA', 0);
INSERT INTO funcionario VALUES (28356940729, 18, 'Felipe Lopes', 71, 2330612.00, 'Pitcairn', '1960-09-16', 1.95, 96.00, 'PD', 0);
INSERT INTO funcionario VALUES (79528046185, 18, 'Vicente Silveira', 51, 512673.00, 'França', '1980-01-25', 1.65, 93.00, 'LE', 0);
INSERT INTO funcionario VALUES (20854639160, 18, 'Murilo Novaes', 50, 1257559.00, 'Camboja', '1973-03-22', 1.87, 77.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (96425738146, 18, 'Danilo Correia', 71, 1826177.00, 'Ilhas Virgens Americanas', '1983-06-27', 1.98, 73.00, 'PE', 0);
INSERT INTO funcionario VALUES (80254163998, 18, 'Gabriel Melo', 57, 1443289.00, 'Kuwait', '1981-05-07', 1.62, 80.00, 'VOL', 0);
INSERT INTO funcionario VALUES (50638471290, 18, 'Antônio Nascimento', 52, 2396587.00, 'Serra Leoa', '1971-10-29', 1.70, 95.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (54132698033, 19, 'Benício Rocha', 47, 2395665.00, 'Polinésia Francesa', '1965-05-03', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (46095382106, 19, 'Gustavo Henrique Duarte', 50, 540994.00, 'Zâmbia', '1956-03-31', 1.78, 73.00, 'GOL', 0);
INSERT INTO funcionario VALUES (24536987029, 19, 'Alexandre Vieira', 49, 1363625.00, 'Tajiquistão', '1973-10-30', 1.97, 91.00, 'LE', 0);
INSERT INTO funcionario VALUES (43867901287, 19, 'Thiago Oliveira', 75, 1070656.00, 'Tuvalu', '1962-10-04', 1.95, 90.00, 'LD', 0);
INSERT INTO funcionario VALUES (45637218919, 19, 'Yuri da Cunha', 53, 1798812.00, 'Ilha Norfolk', '1948-09-13', 1.68, 70.00, 'PE', 0);
INSERT INTO funcionario VALUES (34708152914, 19, 'Murilo Rocha', 52, 2176995.00, 'Jibuti', '1948-10-12', 1.79, 81.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (5493281732, 19, 'Bruno Correia', 52, 2180768.00, 'Nova Caledónia', '1954-07-05', 1.72, 96.00, 'LD', 0);
INSERT INTO funcionario VALUES (7421958649, 19, 'Bernardo Ribeiro', 54, 2231229.00, 'Estados Unidos', '1967-11-02', 1.84, 65.00, 'PD', 0);
INSERT INTO funcionario VALUES (48302567965, 19, 'Samuel da Cruz', 53, 357231.00, 'Nova Caledónia', '1965-03-02', 1.89, 76.00, 'LD', 0);
INSERT INTO funcionario VALUES (61783542900, 19, 'João Felipe Martins', 74, 1215578.00, 'Croácia', '1976-02-06', 1.81, 71.00, 'LD', 0);
INSERT INTO funcionario VALUES (49127856011, 19, 'Enrico Gonçalves', 69, 2457482.00, 'Argélia', '1979-02-16', 1.61, 83.00, 'LE', 0);
INSERT INTO funcionario VALUES (2467985300, 19, 'Marcos Vinicius Lima', 73, 1694099.00, 'Svalbard e Jan Mayen', '1978-01-24', 1.95, 93.00, 'GOL', 0);
INSERT INTO funcionario VALUES (96254708167, 19, 'Cauã Rodrigues', 57, 1851875.00, 'Dinamarca', '1958-03-23', 1.91, 87.00, 'ATA', 0);
INSERT INTO funcionario VALUES (80631597484, 19, 'Calebe Ribeiro', 55, 2386318.00, 'Nicarágua', '1972-05-02', 1.68, 95.00, 'PE', 0);
INSERT INTO funcionario VALUES (59302487610, 19, 'Murilo Porto', 71, 480123.00, 'Antártica', '1972-03-24', 1.86, 98.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (30586174966, 19, 'Carlos Eduardo Fernandes', 72, 2302140.00, 'Bósnia e Herzegovina', '1959-05-05', 1.76, 83.00, 'LD', 0);
INSERT INTO funcionario VALUES (2748156307, 19, 'Calebe Nogueira', 64, 1679511.00, 'Niue', '1959-05-23', 1.78, 67.00, 'PD', 0);
INSERT INTO funcionario VALUES (1765894301, 19, 'Yago Farias', 58, 1036682.00, 'Espanha', '1981-11-23', 1.72, 70.00, 'GOL', 0);
INSERT INTO funcionario VALUES (25798401685, 19, 'Heitor Caldeira', 63, 1512011.00, 'Macedónia do Norte', '1951-09-24', 1.65, 90.00, 'VOL', 0);
INSERT INTO funcionario VALUES (17856923482, 19, 'Francisco Caldeira', 72, 1954851.00, 'Angola', '1978-12-06', 1.63, 100.00, 'GOL', 0);
INSERT INTO funcionario VALUES (62835907130, 19, 'João Vitor Ramos', 54, 1566085.00, 'Tajiquistão', '1962-07-04', 1.88, 95.00, 'GOL', 0);
INSERT INTO funcionario VALUES (41635892791, 19, 'Leandro Lima', 63, 1467603.00, 'Gâmbia', '1954-11-07', 1.77, 70.00, 'PD', 0);
INSERT INTO funcionario VALUES (47936205152, 19, 'Enrico Rezende', 42, 339658.00, 'Lesoto', '1960-09-29', 1.80, 66.00, 'MEI', 0);
INSERT INTO funcionario VALUES (36840591298, 19, 'Bernardo Melo', 43, 1409863.00, 'Países Baixos', '1983-05-27', 1.82, 78.00, 'LE', 0);
INSERT INTO funcionario VALUES (4925376829, 19, 'Ryan Rocha', 59, 1799029.00, 'Cabo Verde', '1956-07-08', 1.74, 76.00, 'GOL', 0);
INSERT INTO funcionario VALUES (31495608298, 19, 'Luiz Otávio Nogueira', 70, 109059.00, 'Guernsey', '1965-04-08', 1.64, 68.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (92157480323, 19, 'Rodrigo da Mata', 40, 913287.00, 'Samoa Americana', '1976-07-28', 1.91, 88.00, 'LD', 0);
INSERT INTO funcionario VALUES (51482376946, 19, 'Yago Porto', 47, 470802.00, 'Grécia', '1957-10-05', 1.88, 91.00, 'VOL', 0);
INSERT INTO funcionario VALUES (52710869411, 19, 'Calebe da Cruz', 40, 1327410.00, 'Rússia', '1966-07-06', 1.87, 99.00, 'ATA', 0);
INSERT INTO funcionario VALUES (1659237416, 19, 'Erick Rezende', 42, 666012.00, 'Rússia', '1963-10-03', 1.70, 74.00, 'CA', 0);
INSERT INTO funcionario VALUES (92834160589, 19, 'André da Costa', 64, 2297374.00, 'Quiribáti', '1951-08-26', 1.85, 73.00, 'ATA', 0);
INSERT INTO funcionario VALUES (30719682568, 20, 'João Porto', 68, 1181841.00, 'Guiné Equatorial', '1951-09-22', NULL, NULL, NULL, 1);
INSERT INTO funcionario VALUES (82357619473, 20, 'Felipe da Paz', 57, 1697155.00, 'Antígua e Barbuda', '1964-12-25', 1.74, 100.00, 'LD', 0);
INSERT INTO funcionario VALUES (47895203665, 20, 'João Vitor Teixeira', 48, 889259.00, 'Samoa Americana', '1970-01-26', 1.70, 95.00, 'VOL', 0);
INSERT INTO funcionario VALUES (62403597180, 20, 'Anthony Costela', 41, 484463.00, 'Honduras', '1971-03-14', 1.65, 99.00, 'PE', 0);
INSERT INTO funcionario VALUES (60841739269, 20, 'Bryan Carvalho', 68, 1985081.00, 'Jamaica', '1960-08-19', 1.63, 70.00, 'LE', 0);
INSERT INTO funcionario VALUES (8321564933, 20, 'Bruno Martins', 52, 1674735.00, 'Eslováquia', '1968-05-17', 1.78, 83.00, 'PD', 0);
INSERT INTO funcionario VALUES (32108457607, 20, 'Pietro Ribeiro', 56, 919375.00, 'Albânia', '1950-04-22', 1.87, 98.00, 'VOL', 0);
INSERT INTO funcionario VALUES (27046819530, 20, 'Rodrigo Mendes', 44, 2303433.00, 'Libéria', '1981-02-06', 1.68, 86.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (94861570301, 20, 'Benício Martins', 44, 1491034.00, 'Mônaco', '1983-07-01', 1.84, 86.00, 'PD', 0);
INSERT INTO funcionario VALUES (53217946855, 20, 'Diego Lopes', 72, 1576489.00, 'Ilhas dos Cocos', '1956-05-02', 1.92, 75.00, 'MEI', 0);
INSERT INTO funcionario VALUES (51709362812, 20, 'Antônio Almeida', 69, 1125198.00, 'Quênia', '1978-05-29', 1.72, 86.00, 'PE', 0);
INSERT INTO funcionario VALUES (62970415399, 20, 'Fernando Gonçalves', 60, 1873289.00, 'Samoa Americana', '1953-02-07', 1.67, 94.00, 'MEI', 0);
INSERT INTO funcionario VALUES (26105879377, 20, 'Yago Cardoso', 48, 592858.00, 'Seicheles', '1977-10-26', 1.60, 84.00, 'VOL', 0);
INSERT INTO funcionario VALUES (21398456764, 20, 'Calebe Cardoso', 60, 1422958.00, 'Ashmore and Cartier Islands', '1963-12-18', 1.98, 77.00, 'ZAG', 0);
INSERT INTO funcionario VALUES (48679253146, 20, 'Bryan Gonçalves', 48, 2010958.00, 'Congo-Kinshasa', '1968-09-11', 1.91, 99.00, 'MEI', 0);
INSERT INTO funcionario VALUES (64920371543, 20, 'Carlos Eduardo da Conceição', 49, 512467.00, 'Kuwait', '1968-09-21', 1.77, 78.00, 'LD', 0);
INSERT INTO funcionario VALUES (71456293800, 20, 'Breno Freitas', 43, 1115744.00, 'Serra Leoa', '1964-07-09', 1.98, 92.00, 'PE', 0);
INSERT INTO funcionario VALUES (18573602490, 20, 'Henrique Alves', 53, 1347306.00, 'Iran', '1971-03-23', 1.94, 87.00, 'CA', 0);
INSERT INTO funcionario VALUES (31206758902, 20, 'Matheus Aragão', 63, 2379336.00, 'Lesoto', '1976-02-06', 1.64, 81.00, 'MEI', 0);
INSERT INTO funcionario VALUES (98207615303, 20, 'Bruno Martins', 49, 688409.00, 'Gabão', '1967-08-19', 1.84, 78.00, 'CA', 0);
INSERT INTO funcionario VALUES (12475869011, 20, 'Augusto Aragão', 59, 723623.00, 'Croácia', '1958-06-05', 1.82, 80.00, 'PE', 0);
INSERT INTO funcionario VALUES (19830472523, 20, 'Emanuel Lopes', 59, 253444.00, 'Suécia', '1974-08-24', 1.76, 92.00, 'LD', 0);
INSERT INTO funcionario VALUES (73641952891, 20, 'Thomas Almeida', 72, 2431233.00, 'Bielorrússia', '1958-07-31', 1.78, 85.00, 'VOL', 0);
INSERT INTO funcionario VALUES (73415802914, 20, 'Nicolas Porto', 61, 2137045.00, 'Vaticano', '1974-02-24', 1.68, 71.00, 'GOL', 0);
INSERT INTO funcionario VALUES (8923145670, 20, 'João Lucas Moraes', 58, 1558218.00, 'Senegal', '1971-02-16', 1.80, 71.00, 'MEI', 0);
INSERT INTO funcionario VALUES (32890756483, 20, 'Luiz Fernando Monteiro', 50, 1872721.00, 'Suécia', '1963-04-18', 1.86, 93.00, 'ATA', 0);
INSERT INTO funcionario VALUES (69128730577, 20, 'Otávio Aragão', 63, 2353627.00, 'Bolívia', '1949-09-30', 1.73, 79.00, 'CA', 0);
INSERT INTO funcionario VALUES (73402951860, 20, 'Luiz Fernando Costa', 69, 498269.00, 'Hong Kong', '1973-10-02', 1.60, 80.00, 'VOL', 0);
INSERT INTO funcionario VALUES (38917604269, 20, 'Caio Pinto', 43, 621250.00, 'Lituânia', '1952-06-25', 1.64, 66.00, 'MEI', 0);
INSERT INTO funcionario VALUES (87542916076, 20, 'Juan Ferreira', 58, 426089.00, 'Bahamas', '1957-02-01', 1.64, 80.00, 'MEI', 0);
INSERT INTO funcionario VALUES (74183605920, 20, 'Alexandre Santos', 53, 2166124.00, 'Serra Leoa', '1955-05-14', 1.67, 82.00, 'PE', 0);

-- INSERÇÃO EM 'participacao_time_campeonato'
INSERT INTO participacao_time_campeonato (codigo_time, codigo_campeonato, pontos, vitorias, derrotas, empates, gols_pro, gols_contra)
SELECT
  codigo_time,
  1,
  SUM(
    CASE
      WHEN gols_mandante > gols_visitante THEN 3
      WHEN gols_mandante < gols_visitante THEN 0
      ELSE 1
    END
  ) AS pontos,
  SUM(
    CASE
      WHEN gols_mandante > gols_visitante THEN 1
      ELSE 0
    END
  ) AS vitorias,
  SUM(
    CASE
      WHEN gols_mandante < gols_visitante THEN 1
      ELSE 0
    END
  ) AS derrotas,
  SUM(
    CASE
      WHEN gols_mandante = gols_visitante THEN 1
      ELSE 0
    END
  ) AS empates,
  SUM(gols_mandante) AS gols_pro,
  SUM(gols_visitante) AS gols_contra
FROM (
  SELECT
    codigo_mandante AS codigo_time,
    gols_mandante,
    gols_visitante
  FROM jogo
  
  UNION ALL
  
  SELECT
    codigo_visitante AS codigo_time,
    gols_visitante,
    gols_mandante
  FROM jogo
) AS subquery
GROUP BY codigo_time;

-- ATUALIZAÇÃO DOS DADOS PARA COLOCAR CARTÕES AMARELOS E VERMELHOS:
UPDATE participacao_time_campeonato SET cartoes_amarelo = 8, cartoes_vermelho = 2 WHERE codigo_time = 1;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 8, cartoes_vermelho = 3 WHERE codigo_time = 2;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 3, cartoes_vermelho = 0 WHERE codigo_time = 3;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 8, cartoes_vermelho = 1 WHERE codigo_time = 4;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 7, cartoes_vermelho = 5 WHERE codigo_time = 5;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 2, cartoes_vermelho = 3 WHERE codigo_time = 6;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 4, cartoes_vermelho = 4 WHERE codigo_time = 7;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 3, cartoes_vermelho = 2 WHERE codigo_time = 8;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 9, cartoes_vermelho = 1 WHERE codigo_time = 9;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 2, cartoes_vermelho = 5 WHERE codigo_time = 10;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 3, cartoes_vermelho = 3 WHERE codigo_time = 11;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 7, cartoes_vermelho = 5 WHERE codigo_time = 12;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 9, cartoes_vermelho = 0 WHERE codigo_time = 13;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 3, cartoes_vermelho = 5 WHERE codigo_time = 14;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 8, cartoes_vermelho = 1 WHERE codigo_time = 15;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 3, cartoes_vermelho = 5 WHERE codigo_time = 16;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 5, cartoes_vermelho = 3 WHERE codigo_time = 17;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 9, cartoes_vermelho = 3 WHERE codigo_time = 18;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 3, cartoes_vermelho = 2 WHERE codigo_time = 19;
UPDATE participacao_time_campeonato SET cartoes_amarelo = 5, cartoes_vermelho = 5 WHERE codigo_time = 20;

-- INSERÇÃO DE PATROCINADORES
INSERT INTO patrocinador VALUES (54668168118, 'Casa de Apostas Illo Dolor', 1, 1780944.00, 2021, 2024);
INSERT INTO patrocinador VALUES (83431481221, 'Supermercados Illo Cupiditate', 2, 227484.00, 2021, 2027);
INSERT INTO patrocinador VALUES (32815042404, 'Casa de Apostas Quas Delectus', 3, 2191314.00, 2020, 2023);
INSERT INTO patrocinador VALUES (72326503304, 'Casa de Apostas Harum Praesentium', 4, 856963.00, 2020, 2025);
INSERT INTO patrocinador VALUES (38937652934, 'Supermercados Tempore Blanditiis', 5, 1978095.00, 2023, 2024);
INSERT INTO patrocinador VALUES (74055539626, 'Empresas At Cum', 6, 1612439.00, 2021, 2027);
INSERT INTO patrocinador VALUES (88459140007, 'Empresas Deleniti Dignissimos', 7, 1490009.00, 2020, 2023);
INSERT INTO patrocinador VALUES (88034646287, 'Empresas Eius Ea', 8, 1397004.00, 2023, 2026);
INSERT INTO patrocinador VALUES (30153857501, 'Banco Pariatur Perferendis', 9, 1927117.00, 2022, 2023);
INSERT INTO patrocinador VALUES (79830239774, 'Casa de Apostas Facilis Ducimus', 10, 1384722.00, 2023, 2026);
INSERT INTO patrocinador VALUES (49948804815, 'Casa de Apostas Eaque Quibusdam', 11, 404527.00, 2020, 2025);
INSERT INTO patrocinador VALUES (65889114819, 'Banco Voluptas Suscipit', 12, 2457801.00, 2021, 2027);
INSERT INTO patrocinador VALUES (54655372221, 'Casa de Apostas Assumenda Nihil', 13, 2311989.00, 2022, 2024);
INSERT INTO patrocinador VALUES (62285671842, 'Empresas Consequatur Esse', 14, 2062032.00, 2021, 2028);
INSERT INTO patrocinador VALUES (1707094462, 'Casa de Apostas Ipsa At', 15, 281548.00, 2021, 2028);
INSERT INTO patrocinador VALUES (32102295690, 'Empresas Illum Eum', 16, 2269825.00, 2020, 2028);
INSERT INTO patrocinador VALUES (24239806338, 'Casa de Apostas Perferendis Officiis', 17, 139452.00, 2021, 2023);
INSERT INTO patrocinador VALUES (39111677742, 'Casa de Apostas Nostrum Aliquid', 18, 1180764.00, 2023, 2024);
INSERT INTO patrocinador VALUES (53076722661, 'Empresas Hic Assumenda', 19, 208476.00, 2020, 2026);
INSERT INTO patrocinador VALUES (77639979087, 'Banco Dolores Iste', 20, 2387412.00, 2021, 2023);
INSERT INTO patrocinador VALUES (74997928049, 'Supermercados Itaque Deleniti', 7, 1623797.00, 2022, 2026);
INSERT INTO patrocinador VALUES (1426489426, 'Banco Magnam Tenetur', 1, 1515222.00, 2020, 2025);
INSERT INTO patrocinador VALUES (40373489368, 'Casa de Apostas Exercitationem Tempora', 2, 1729006.00, 2023, 2028);
INSERT INTO patrocinador VALUES (67359500037, 'Supermercados Facere Cupiditate', 3, 1574711.00, 2021, 2028);
INSERT INTO patrocinador VALUES (87462731204, 'Banco Ab Eligendi', 4, 1920181.00, 2021, 2026);
INSERT INTO patrocinador VALUES (72214721156, 'Casa de Apostas Tempore Consequatur', 5, 1718701.00, 2023, 2027);
INSERT INTO patrocinador VALUES (22024405561, 'Supermercados Ratione Similique', 6, 101353.00, 2023, 2025);
INSERT INTO patrocinador VALUES (20771531304, 'Banco Reiciendis Aliquid', 8, 188593.00, 2022, 2024);
INSERT INTO patrocinador VALUES (50143811237, 'Supermercados Corrupti Fugiat', 1, 681222.00, 2021, 2028);
INSERT INTO patrocinador VALUES (96474393619, 'Banco A Nam', 2, 176104.00, 2022, 2026);
INSERT INTO patrocinador VALUES (91037876899, 'Casa de Apostas Molestiae Iusto', 3, 722364.00, 2021, 2026);
INSERT INTO patrocinador VALUES (59944273229, 'Empresas Repudiandae Non', 4, 1011421.00, 2021, 2023);
INSERT INTO patrocinador VALUES (81332785184, 'Casa de Apostas Nulla Corrupti', 5, 583530.00, 2023, 2024);
INSERT INTO patrocinador VALUES (49635524465, 'Supermercados Perferendis Mollitia', 6, 262278.00, 2020, 2027);
INSERT INTO patrocinador VALUES (52446519525, 'Casa de Apostas Pariatur Labore', 14, 786286.00, 2023, 2027);
INSERT INTO patrocinador VALUES (43171528501, 'Banco Enim Velit', 1, 1323448.00, 2022, 2026);
INSERT INTO patrocinador VALUES (31869618172, 'Banco Nulla Natus', 2, 948375.00, 2023, 2025);
INSERT INTO patrocinador VALUES (24093441581, 'Banco Consequatur Delectus', 3, 574990.00, 2020, 2023);
INSERT INTO patrocinador VALUES (65544707148, 'Casa de Apostas Ad Beatae', 4, 2308353.00, 2021, 2024);
INSERT INTO patrocinador VALUES (49010964675, 'Banco Reiciendis Incidunt', 5, 1403146.00, 2021, 2026);