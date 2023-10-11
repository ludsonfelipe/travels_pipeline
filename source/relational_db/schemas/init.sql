CREATE TABLE Usuarios (
    usuario_id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    senha VARCHAR(255),
    telefone VARCHAR(20),
    endereco TEXT
);
CREATE TABLE Motoristas (
    motorista_id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES Usuarios(usuario_id),
    avaliacao DECIMAL(3, 2),
    status VARCHAR(20)
);
CREATE TABLE Veiculos (
    veiculo_id SERIAL PRIMARY KEY,
    motorista_id INT REFERENCES Motoristas(motorista_id),
    modelo VARCHAR(100),
    ano INT,
    placa VARCHAR(15)
);
CREATE TABLE Viagens (
    viagem_id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES Usuarios(usuario_id),
    motorista_id INT REFERENCES Motoristas(motorista_id),
    veiculo_id INT REFERENCES Veiculos(veiculo_id),
    data_hora_inicio TIMESTAMP,
    data_hora_fim TIMESTAMP,
    origem VARCHAR(255),
    destino VARCHAR(255),
    status VARCHAR(20)
);
CREATE TABLE Pagamentos (
    pagamento_id SERIAL PRIMARY KEY,
    viagem_id INT REFERENCES Viagens(viagem_id),
    valor DECIMAL(10, 2),
    status VARCHAR(20)
);


ALTER TABLE
    Usuarios REPLICA IDENTITY FULL;
ALTER TABLE
    Motoristas REPLICA IDENTITY FULL;
ALTER TABLE
    Veiculos REPLICA IDENTITY FULL;
ALTER TABLE
    Viagens REPLICA IDENTITY FULL;
ALTER TABLE
    Pagamentos REPLICA IDENTITY FULL;