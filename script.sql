-- MySQL Workbench Forward Engineering

create database oficina;
use oficina;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------

-- Table `oficina`.`EquipeMecanicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`EquipeMecanicos` (
  `idEquipeMecanicos` INT NOT NULL AUTO_INCREMENT,
  `quantFuncionario` INT NOT NULL,
  `horarioInicio` TIME NOT NULL,
  `horarioTermino` TIME NOT NULL,
  PRIMARY KEY (`idEquipeMecanicos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Endereco` (
  `idEndereco` INT NOT NULL AUTO_INCREMENT,
  `cep` INT NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `estado` CHAR(2) NOT NULL,
  `numero` INT NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `mecanico_CPF` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idEndereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Mecanico` (
  `CPF` VARCHAR(15) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `salario` DECIMAL(6,2) NOT NULL,
  `especialidade` VARCHAR(45) NOT NULL,
  `dataNasc` DATE NOT NULL,
  `dataAdm` DATE NOT NULL,
  `dataDem` DATE NULL,
  `email` VARCHAR(45) NULL,
  `EquipeMecanicos_idEquipeMecanicos` INT NULL,
  PRIMARY KEY (`CPF`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oficina`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Servico` (
  `idServico` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(500) NOT NULL,
  `valor` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`idServico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Veiculo` (
  `Placa` VARCHAR(10) NOT NULL,
  `descricao` VARCHAR(200) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`Placa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`OrdemServico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`OrdemServico` (
  `idOrdemServico` INT NOT NULL AUTO_INCREMENT,
  `dataEmissao` DATE NOT NULL,
  `valor` DECIMAL(6,2) NOT NULL,
  `dataConclusao` DATE NOT NULL,
  `EquipeMecanicos_idEquipeMecanicos` INT NOT NULL,
  `Veiculo_Placa` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idOrdemServico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Peca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Peca` (
  `idPeca` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idPeca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Fornecedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Fornecedores` (
  `CNPJ` VARCHAR(20) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`CNPJ`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `oficina`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Produto` (
  `idProduto` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `valor` DECIMAL(6,2) NOT NULL,
  `descricao` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Telefone` (
  `idTelefone` INT NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(45) NOT NULL,
  `Cliente_idCliente` INT NULL,
  `Fornecedores_CNPJ` VARCHAR(20) NULL,
  `Mecanico_CPF` VARCHAR(15) NULL,
  PRIMARY KEY (`idTelefone`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Dependente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Dependente` (
  `CPF` VARCHAR(15) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `dataNasc` DATE NOT NULL,
  `sexo` CHAR(2) NOT NULL,
  `parentesco` VARCHAR(45) NOT NULL,
  `Mecanico_CPF` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Fazer_Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Fazer_Servico` (
  `OrdemServico_idOrdemServico` INT NOT NULL,
  `Servico_idServico` INT NOT NULL,
  PRIMARY KEY (`OrdemServico_idOrdemServico`, `Servico_idServico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Fornecer_Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Fornecer_Produto` (
  `Fornecedores_CPNJ` VARCHAR(20) NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedores_CPNJ`, `Produto_idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Fornecer_Peca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Fornecer_Peca` (
  `Fornecedores_CPNJ` VARCHAR(20) NOT NULL,
  `Peca_idPeca` INT NOT NULL,
  PRIMARY KEY (`Fornecedores_CPNJ`, `Peca_idPeca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Utilizar_Peca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Utilizar_Peca` (
  `OrdemServico_idOrdemServico` INT NOT NULL,
  `Peca_idPeca` INT NOT NULL,
  PRIMARY KEY (`OrdemServico_idOrdemServico`, `Peca_idPeca`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


/* script para escluir tudo*/

/*drop schema oficina;*/


/* definindo a chave estrangeira de endereco */

alter table endereco add foreign key(mecanico_CPF) references mecanico(CPF) on delete cascade on update cascade;


/* definindo as chaves estrangeiras em telefone*/


alter table telefone add foreign key(cliente_idCliente) references cliente(idCLiente) on delete cascade;
alter table telefone add foreign key(mecanico_CPF) references mecanico(CPF) on delete cascade on update cascade;
alter table telefone add foreign key(fornecedores_CNPJ) references fornecedores(CNPJ) on delete cascade on update cascade;


/* definindo a chave estrangeira em mecanico*/


alter table mecanico add foreign key(EquipeMecanicos_idEquipeMecanicos) references equipemecanicos(idEquipeMecanicos);


/* definindo a chave estrangeiras em dependente*/


alter table dependente add foreign key(mecanico_CPF) references mecanico(CPF) on update cascade on delete cascade;


/* definindo as chaves estrangeiras em ordemservico*/



alter table ordemservico add foreign key(EquipeMecanicos_idEquipeMecanicos) references equipemecanicos(idEquipeMecanicos) on delete cascade;
alter table ordemservico add foreign key(Veiculo_Placa) references veiculo(Placa) on update cascade on delete cascade;


/* definindo as chaves estrangeiras em fornecer_produto*/



alter table fornecer_produto add foreign key(Fornecedores_CPNJ) references fornecedores(CNPJ) on update cascade on delete cascade;
alter table fornecer_produto add foreign key(Produto_idProduto) references produto(idProduto) on delete cascade;


/* definindo as chaves estrangeiras em fornecer_peca*/

alter table fornecer_peca add foreign key(Fornecedores_CPNJ) references fornecedores(CNPJ) on update cascade on delete cascade;
alter table fornecer_peca add foreign key(Peca_idPeca) references peca(idPeca) on delete cascade;


/* definindo as chaves estrangeiras em utilizar_peca*/

alter table utilizar_peca add foreign key(Peca_idPeca) references peca(idPeca) on delete cascade;
alter table utilizar_peca add foreign key(OrdemServico_idOrdemServico) references ordemservico(idOrdemServico) on delete cascade;


/* definindo as chaves estrangeiras em fazer_servico*/

alter table fazer_servico add foreign key(OrdemServico_idOrdemServico) references ordemservico(idOrdemServico) on delete cascade;
alter table fazer_servico add foreign key(Servico_idServico) references servico(idServico) on delete cascade;


/* definindo a chave estrangeiras em veiculo*/

alter table veiculo add foreign key(Cliente_idCliente) references cliente(idCliente) on delete cascade;



									/* DML */


/* Inserindo os clientes*/

insert into cliente(nome, email)
	values("Rafael Pereira", "rafa55@gmail.com"),
    ("Vitoria Santos", "viviS@gmail.com"),
    ("Carlos André", "adrezinho@gmail.com"),
    ("Felipe Alves", "lipe0@gmail.com"),
    ("Ricardo Martins", "ricardoM@gmail.com"),
    ("Paula Ferreira", "paulinha@gmail.com"),
    ("Letícia Ribeiro", "lele@gmail.com"),
    ("Eduardo Silva", "edu56@gmail.com"),
    ("Leonardo Santos", "leoss@gmail.com"),
    ("Gabriela Souza", "gabi@gmail.com");
    
    
    
/* Inserindo os equipe de mecanicos*/
   
insert into equipemecanicos(quantFuncionario, horarioInicio, horarioTermino)
	values(2, '08:00:00', '12:30:00'),
	(2, '08:00:00', '12:30:00'),
	(2, '08:00:00', '12:30:00'),
    (2, '08:00:00', '12:30:00'),
    (2, '08:00:00', '12:30:00'),
    (2, '12:30:00', '18:00:00'),
	(2, '12:30:00', '18:00:00'),
    (2, '12:30:00', '18:00:00'),
    (2, '12:30:00', '18:00:00'),
    (2, '12:30:00', '18:00:00');
    
    
/* Inserindo os mecanicos*/

insert into mecanico(CPF, nome, sexo, salario, especialidade, dataNasc, dataAdm, dataDem, email, EquipeMecanicos_idEquipeMecanicos)
	values("265.894.584-20", "Rivaldo Oliveira", 'M', 5042.00, "Preparador e customizador", '1985-03-20', '2021-06-01', null, "valdinho@gmail.com", 1),
    ("285.323.104-77", "Antonio Ferreira", 'M', 2557.00, "Nenhuma", '1979-07-15', '2018-04-10', null, "toninho@gmail.com", 1),
    ("198.067.434-11", "Joao Henrique dos Santos", 'M', 2557.00, "Nenhuma", '1986-10-04', '2018-04-10', null, "joaoHs@gmail.com", 2),
    ("170.550.824-93", "Paulo André de Lima", 'M', 3308.00, "Especialidade em motos", '1975-05-26', '2017-03-10', null, "pALima@gmail.com", 2),
    ("180.295.664-98", "Ricardo Pereira", 'M', 2557.00, "nenhuma", '1970-02-20', '2017-03-10', null, "ricardoP@gmail.com", 3),
    ("135.005.785-02", "Luiz Mateus dos Santos", 'M', 3308.00, "Especialista em marcas ou segmentos", '1982-11-17', '2017-03-10', null, "luizinhoMs@gmail.com", 3),
    ("089.150.210-33", "Filipe Martins", 'M', 2557.00, "Nenhuma", '1988-07-10', '2017-03-10', null, "lipeMs@gmail.com", 4),
    ("340.662.943-40", "Pedro Barbosa", 'M', 4042.00, "Especialista em carros de luxo", '1981-09-21', '2017-03-10', null, "pedrao002@gmail.com", 4),
	("020.100.050-88", "Afonso Duarte", 'M', 2557.00, "Nenhuma", '1990-01-19', '2017-03-10', null, "Afnduarte@gmail.com", 5),
    ("234.095.310-20", "Lourenço Santana", 'M', 3308.00, "Reparador de sistemas específicos", '1994-09-06', '2017-03-10', null, "santana03@gmail.com", 5),
    ("140.700.390-91", "Guilherme Freitas", 'M', 2557.00, "Nenhuma", '1992-08-02', '2017-03-10', null, "freitasG@gmail.com", 6),
    ("530.808.002-50", "Joäo Pedro Gomes", 'M', 3308.00, "Especialista em motos", '1990-05-30', '2017-03-10', null, "joaopgomes@gmail.com", 6),
    ("201.462.709-38", "Nicolas Marques", 'M', 3308.00, "Especialista em carros antigos", '1989-12-18', '2017-03-10', null, "nicolas55@gmail.com", 7),
    ("033.210.886-15", "Santiago Machado", 'M', 2557.00, "Nenhuma", '1987-09-17', '2017-03-10', null, "santiago05m@gmail.com", 7),
    ("430.610.402-92", "André Luiz da Silva", 'M', 2557.00, "Nenhuma", '1995-04-28', '2017-03-10', null, "andrezinho08@gmail.com", 8),
    ("020.590.107-06", "Helena Fernandes", 'F', 3308.00, "Especialista em marcas ou segmentos", '1987-05-14', '2017-03-10', null, "helenafer01@gmail.com", 8),
    ("380.295.233-56", "Camila Lopes", 'F', 3308.00, "Especialista em motos", '1986-12-26', '2018-04-10', null, "milaLops@gmail.com", 9),
    ("220.603.595-26", "Amanda Medeiros", 'F', 2557.00, "Nenhuma", '1983-09-20', '2018-04-10', null, "amandaM02@gmail.com", 9),
    ("652.450.214-09", "Maria Cecília Moraes", 'F', 4042.00, "Especialista em carros de luxo", '1992-07-25', '2017-03-10', null, "ceciliamaria@gmail.com", 10),
    ("399.815.741-63", "Ana Júlia Ribeiro", 'F', 2557.00, "Nenhuma", '1996-09-18', '2018-04-10', null, "anajulinha07@gmail.com", 10),
    
	("520.324.854-21", "Marcelo Nascimento", 'M', 2557.00, "Nenhuma", '1984-05-25', '2017-03-10', '2019-06-30', "marcelinho07@gmail.com", null),
    ("226.527.170-45", "Eduardo Moura", 'M', 2557.00, "Nenhuma", '1987-08-11', '2017-03-10', '2019-06-30', null, null),
    ("154.325.824-97", "João Miguel Rocha", 'M', 3308.00, "Especialista em motos", '1988-02-24', '2017-03-10', '2019-06-30', null, null),
    ("053.936.552-82", "Samuel Oliveira", 'M', 2557.00, "Nenhuma", '1983-09-23', '2018-04-10', '2019-06-30', "samuel-oliveira00@gmail.com", null),
    ("656.282.914-87", "José Luís Moreira", 'M', 2557.00, "Nenhuma", '1985-04-29', '2017-04-10', '2019-06-30', "moreiraLuís@gmail.com", null);
    
    
    
    /* Inserindo enderecos dos mecanicos*/
    
    insert into endereco(cep, rua, cidade, estado, numero, bairro, mecanico_CPF)
		values(52490260, "Rua AJalmar Correia", "Recife", 'PE', 885, "Guabiraba", "265.894.584-20"),
        (50711220, "Rua Abadia", "Recife", 'PE', 203, "Cordeiro", "285.323.104-77"),
        (50870610, "Rua Abel Manoel do Nascimento", "Recife", 'PE', 523, "Areias", "198.067.434-11"),
        (52051270, "Rua Abel de Sá Bezerra Cavalcanti", "Recife", 'PE', 294, "Casa Amarela", "170.550.824-93"),
        (52190311, "Rua Angaí", "Recife", 'PE', 362, "Nova Descoberta", "180.295.664-98"),
        (52280555, "Rua Aratuba", "Recife", 'PE', 210, "Vasco da Gama", "135.005.785-02"),
        (50040170, "Rua Araripina", "Recife", 'PE', 450, "Santo Amaro", "089.150.210-33"),
        (52090630, "Rua Aritana", "Recife", 'PE', 189, "Macaxeira", "340.662.943-40"),
        (50830500, "Rua Armando Burle", "Recife", 'PE', 540, "Afogados", "020.100.050-88"),
        (52070310, "Rua Armando Gaioso", "Recife", 'PE', 723, "Casa Amarela", "234.095.310-20"),
        (50110480, "Rua Ascenção", "Recife", 'PE', 465, "Santo Amaro", "140.700.390-91"),
        (52160505, "Rua Bandeirantes", "Recife", 'PE', 299, "Dois Unidos", "530.808.002-50"),
        (52080341, "Rua Barra Nova", "Recife", 'PE', 148, "Alto José Bonifácio", "201.462.709-38"),
        (50730070, "Rua Barcelos", "Recife", 'PE', 520, "Engenho do Meio", "033.210.886-15"),
        (50820190, "Rua Barra Longa", "Recife", 'PE', 370, "Mangueira", "430.610.402-92"),
        (52280270, "Rua Barra Velha", "Recife", 'PE', 910, "Morro da Conceição", "020.590.107-06"),
        (50800360, "Rua Barão de Itapissuma", "Recife", 'PE', 484, "Iputinga", "380.295.233-56"),
        (52131571, "Rua Bela Vista do Poente", "Recife", 'PE', 305, "Linha do Tiro", "220.603.595-26"),
       	(52041070, "Rua Belmiro Corrêa", "Recife", 'PE', 065, "Encruzilhada", "652.450.214-09"),
        (52111330, "Rua Belo Jardim", "Recife", 'PE', 822, "Água Fria", "399.815.741-63"),
        (50960520, "Rua Bernardim Ribeiro", "Recife", 'PE', 925, "Várzea", "520.324.854-21"),
        (50770170, "Rua Bom Gosto", "Recife", 'PE', 330, "Afogados", "226.527.170-45"),
        (50761435, "Rua Bom Jardim", "Recife", 'PE', 549, "San Martin", "154.325.824-97"),
		(50630670, "Rua Brasabante", "Recife", 'PE', 703, "Cordeiro", "053.936.552-82"),
		(50900380, "Rua Brilhante", "Recife", 'PE', 048, "Barro", "656.282.914-87");
       
       
       
	/* Inserindos os dependetes*/
    
    insert into dependente
		values("819.227.144-70", "Luana Farias Barbosa", '2015-06-10', 'F', "Filha", "340.662.943-40"),
        ("405.181.044-51", "Sophia Castro Martins", '2015-08-17', 'F', "Filha", "089.150.210-33"),
        ("616.210.974-71", "Brenda Sara Rocha Medeiros", '2006-09-11', 'F', "Filha", "220.603.595-26"),
        ("794.281.214-60", "Antonio Davi da Cruz Lima", '2017-11-03', 'M', "Filho", "170.550.824-93"),
        ("419.754.734-00", "Yago Bento Duarte", '2011-09-22', 'M', "Filho", "020.100.050-88"),
        ("883.954.094-60", "Elias Filipe Moraes", '2008-02-19', 'M', "Filho", "652.450.214-09"),
        ("501.496.344-71", "Melissa Nicole Jesus", '2013-10-28', 'F', "Filha", "180.295.664-98"),
        ("228.336.844-87", "Rosa Rayssa Barbosa", '2002-01-17', 'F', "Filha", "430.610.402-92"),
        ("341.857.614-14", "Benício Gael Monteiro", '2020-12-15', 'M', "Filho", "265.894.584-20"),
        ("748.452.684-34", "Patrícia Vitória Oliveira", '2005-07-21', 'F', "Filha", "265.894.584-20");
        
        
	/* Inserindo os fornecedores*/
    
	insert into fornecedores
		values("34.993.882/0001-55", "REAL DISTRIBUIDORA DE PECAS E ACESSORIOS AUTOMOTIVOS", "prnunesctb@gmail.com"),
        ("91.541.061/0001-11", "COBRA ROLAMENTOS E AUTOPECAS S.A", "sac@cobrarolamentos.com.br"),
        ("14.506.593/0001-77", "DPK PECAS E ACESSORIOS LTDA", "sac@dpk.com.br"),
        ("27.527.034/0001-95", "FW DISTRIBUIDORA LTDA.", null),
        ("68.701.475/0001-49", "GIRANDO COMERCIO DE PECAS LTDA", "vendas.recife@rolemar.com"),
        ("12.457.612/0001-97", "JAHU BORRACHAS E AUTOPECAS LTDA", "vendas@jahu.com.br"),
        ("27.303.332/0001-00", "SK AUTOMOTIVE DISTRIBUIDORA DE AUTOPECAS LTDA", "faleconosco@skautomotive.com.br"),
        ("08.429.785/0001-24", "COMDIP COMERCIAL DISTRIBUIDORA DE PECAS LTDA", null),
        ("31.895.270/0001-31", "DINPAR-DISTRIBUIDORA NACIONAL DE PARAFUSOS E PECAS LTDA", "contatos@dinpar.com.br"),
        ("86.789.755/0001-32", "UNIVERSAL AUTOMOTIVE SYSTEMS LTDA", null);
        
               
        /* Inserindo os produtos*/
        
	insert into produto(nome, valor, descricao)
		 values("aditivio para óleo", 46.90, "Aditivo Para Óleo De Motor 500ml - Bardahl B12 Plus"),
		 ("Limpa Radiador Orgânico", 21.90, "Limpa Radiador Orgânico 500ml - KOUBE-20013"),
		 ("Cristalizador de Vidros", 11.90, "Cristalizador de Vidros 100ml - TECBRIL-5920145"),
		 ("Fluido para Freios", 13.90, "Fluido para Freios DOT 3 500ml - RADNAQ-7030"),
		 ("Grafite Em Pó", 4.32, "Grafite Em Pó 25g - VONDER-5199000025"),
		 ("Graxa Branca ", 14.90, "Graxa Branca 290ml - RADNAQ-6060"),
		 ("Tinta Spray Fosco ", 26.90, "Tinta Spray Fosco Uso geral Interno e Externo - Preto - 400ml - Colorgin"),
		 ("Limpa Para-Brisa", 7.91, "Limpa Para-Brisa 100ml - KOUBE-20012"),
		 ("Pneu Pretinho Limpador", 13.90, "Pneu Pretinho Limpador 500ml - Orbi Química"),
		 ("Vaselina em Spray", 24.90, "Vaselina em Spray 200ml/115g - WURTH-0893224211");
     
		
        
        /* Inserindo as peças*/
        
	insert into peca(nome, descricao)
		values("Interruptor Luz Freio", "Interruptor Luz Freio Bipolar Chevrolet Classic 2002 A 2007"),
        ("Interruptor Freio", "Interruptor Freio Uno 2010 2011 Rosca M12 3 Rho"),
        ("Fusivel Cinta", "Fusivel Cinta 175 Amperes - Hikari"),
        ("Bobina Impulsora", "Bobina Impulsora Distribuidor Gm Ford Fiat"),
        ("Modulo De Ignição", "Modulo De Ignição Volkswagen Saveiro 1.8 1992 Gauss"),
        ("Sensor De Rotação", "Sensor De Rotação Fiat Palio Siena Strada 1.0 1.3 8v Fire"),
        ("Caixa de Direção Hidráulica", "Caixa Direção Hidráulica Volkswagen Voyage 81 a 94 Sem Terminal Ampri"),
        ("corpo borboleta", "CORPO BORBOLETA TBI VW GOL, FOX, SAVEIRO, GOLF - GI7134"),
        ("Reservatório de Água Radiador", "Reservatório de Água Radiador Palio Siena Palio Weekend 2001 a 2011 1.0 1.3 e 1.4 M516 - Marvini"),
        ("Sensor de Velocidade", "Sensor Velocidade Doblo Fiorino Idea Palio 46818007");
    
    
        /* Inserindo os serviços*/
    
     insert into servico(nome, descricao, valor)
		values("Manutenção da embreagem", "A troca da embreagem em casos de desgaste é importante para garantir o funcionamento correto do câmbio e para que o condutor trafegue sem problemas", 350.00),
        ("Revisão dos componentes de Freio", "Esse procedimento visa identificar o estado das peças do sistema de frenagem, como as pastilhas, discos, sistema hidráulico, sistema eletrônico (se for o caso) e higienização do sistema", 450.00),
        ("Revisão no Sistema de Arrefecimento", "Um dos principais itens a serem revisados são os do sistema de arrefecimento. Por se tratar de componentes que atuam na refrigeração do motor, exigem grande cuidado para não acarretar em prejuízos.", 120.00),
        ("Troca de óleo do motor", "É importante manter o bom funcionamento do veículo. Além do lubrificante é realizada a troca do filtro de óleo", 150.00),
        ("Regulagem de válvulas", "Manter a as válvulas reguladas é essencial para preservar o bom desempenho do veículo.", 350.00),
        ("Troca de filtros", "Para melhorar o desempenho do veículo, sua troca é indispensável e varia de acordo com o tráfego do automóvel.", 250.00),
        ("Troca de lâmpadas", "A iluminação do veículo é essencial para manter a segurança principalmente quando se roda a noite. O farol desregulado e lâmpadas queimadas podem gerar multa quando não estão de acordo com o padrão exigido.", 40.00),
        ("Alinhamento e Balanceamento", "O alinhamento e balanceamento tendem a ser procedimentos periódicos, pois as estradas não apresentam boas condições de tráfego e assim vão desalinhando e causando desgastes nos componentes da suspensão.", 150.00),
        ("Checagem do nível de água no radiador", "O sistema de arrefecimento é responsável por deixar a temperatura do motor ideal e manter o bom funcionamento do veículo. Por esse motivo, a água que é armazenada no motor deve ser verificada com frequência.", 350.00),
        ("Troca de baterias", "Trocar a bateria do carro, de acordo com a sua marca e especificações.", 450.00);
        
        
		/* Inserindo os Telefones*/
     
     
		/* Clientes*/
     
        insert into telefone(numero, Cliente_idCliente, Fornecedores_CNPJ, Mecanico_CPF)
			values("(81)3955-7382", 1, null, null),
            ("(81)3832-3327", 2, null, null),
			("(81)3713-9370", 3, null, null),
            ("(81)3932-6441", 4, null, null),
            ("(81)3753-3522", 5, null, null),
            ("(81)3838-5618", 6, null, null),
            ("(81)98279-8509", 7, null, null),
            ("(81)99818-6001", 8, null, null),
            ("(81)99586-6250", 9, null, null),
            ("(81)98269-3284", 10, null, null);
            
            
            /* Fornecedores*/
            
        insert into telefone(numero, Cliente_idCliente, Fornecedores_CNPJ, Mecanico_CPF)
			values("(81)2860-4987", null, '08.429.785/0001-24', null),
            ("(81)3864-9922", null, '12.457.612/0001-97', null),
            ("(81)3717-7258", null, '14.506.593/0001-77', null),
            ("(81)2849-0744", null, '27.303.332/0001-00', null),
            ("(81)3951-3983", null, '27.527.034/0001-95', null),
            ("(81)3683-1894", null, '31.895.270/0001-31', null),
            ("(81)3958-8271", null, '34.993.882/0001-55', null),
            ("(81)3680-8628", null, '68.701.475/0001-49', null),
            ("(81)2969-2791", null, '86.789.755/0001-32', null),
			("(81)2566-3011", null, '91.541.061/0001-11', null);
            
            
                  /* Mecanicos*/
            
        insert into telefone(numero, Cliente_idCliente, Fornecedores_CNPJ, Mecanico_CPF)
			values("(81)3841-0666", null, null, '020.100.050-88'),
            ("(81)99382-4007", null, null, '020.590.107-06'),
            ("(81)2886-4090", null, null, '033.210.886-15'),
            ("(81)99778-6930", null, null, '053.936.552-82'),
            ("(81)2539-4676", null, null, '089.150.210-33'),
            ("(81)98776-5518", null, null, '135.005.785-02'),
            ("(81)3793-8678", null, null, '140.700.390-91'),
            ("(81)99271-5122", null, null, '154.325.824-97'),
            ("(81)3626-6502", null, null, '170.550.824-93'),
            ("(81)9871-0926", null, null, '180.295.664-98'),
            ("(81)3555-8038", null, null, '198.067.434-11'),
            ("(81)98339-1964", null, null, '201.462.709-38'),
            ("(81)2556-9838", null, null, '220.603.595-26'),
            ("(81)99406-7367", null, null, '226.527.170-45'),
            ("(81)25345-553", null, null, '234.095.310-20'),
            ("(81)99119-8304", null, null, '265.894.584-20'),
            ("(81)2724-5957", null, null, '285.323.104-77'),
            ("(81)98353-1575", null, null, '340.662.943-40'),
            ("(81)3573-4437", null, null, '380.295.233-56'),
            ("(81)99872-0503", null, null, '399.815.741-63'),
            ("(81)2574-3297", null, null, '430.610.402-92'),
            ("(81)99880-0246", null, null, '520.324.854-21'),
            ("(81)3741-2008", null, null, '530.808.002-50'),
            ("(81)98410-0066", null, null, '652.450.214-09'),
            ("(81)3533-4213", null, null, '656.282.914-87');



	/* Inserindo os veiculos*/

	insert into veiculo
		values("KHX-7855", "Marca:Fiat/Modelo:Strada 1.4 mpi Fire Flex 8V CE/Ano:2006/RENAVAM:71335208354/cor:Vermelho", 1),
        ("KGL-8459", "Marca:Fiat/Modelo:UNO WAY 1.0 EVO Fire Flex 8V 2p/Ano:2012/RENAVAM:11191893183/Cor:Azul", 2),
        ("KJY-3075", "Marca:Toyota/Modelo:Corolla Fielder SW 1.8/1.8 XEi Flex Aut./Ano:2005/RENAVAM:91262384969/Cor:Marrom", 3),
		("KGB-7436", "Marca:Toyota/Modelo:Land Cruiser Prado 3.0 4x4 TB Diesel Mec/Ano:2003/RENAVAM/Cor:Marrom", 4),
        ("KFX-9729", "Marca:Nissan/Modelo:LIVINA X-GEAR S 1.6 16V Flex Fuel/Ano:2010/RENAVAM:05151780626/Cor:Preto", 5),
        ("KKU-1310", "Marca:Jeep/Modelo:Renegade Sport 1.8 4x2 Flex 16V Mec./Ano:2016/RENAVAM:58638640271/cor:Vermelho", 6),
        ("KGY-0398", "Marca:Ford/Modelo:Fiesta SE 1.6 16V Flex 5p/Ano:2011/RENAVAM:29501619257/Cor:Cinza", 7),
        ("KLZ-4141", "Marca:Citroen/Modelo:AIRCROSS Feel 1.6 Flex 16V 5p Aut./Ano:2016/RENAVAM:24115611620/Cor:Verde", 8),
		("KIO-8206", "Marca:Ford/Modelo:Ranger XLT 4.0 4x4 CD/Ano:1998/RENAVAM:73569669893/Cor:Prata", 9),
		("KKN-3667", "Marca:VW - VolksWagen/Modelo:Gol Plus 1.0 Mi Total Flex 2p/Ano:2006/RENAVAM:03255592242C/or:Laranja", 10);
        
        
        /* Inserindo as ordens de serviços*/
        
    insert into ordemservico(dataEmissao, valor, dataConclusao, EquipeMecanicos_idEquipeMecanicos, Veiculo_Placa)
		values('2022-10-19', 350.00, '2022-10-22', 1, "KIO-8206"),
        ('2022-10-19', 150.00, '2022-10-19', 2, "KKU-1310"),
        ('2022-10-04', 250.00, '2022-10-05', 3, "KFX-9729"),
        ('2022-10-12', 196.90, '2022-10-15', 4, "KJY-3075"),
        ('2022-09-20', 40.00, '2022-09-12', 5, "KGB-7436"),
        ('2022-10-03', 400.00, '2022-10-03', 6, "KLZ-4141"),
        ('2022-10-18', 520.00, '2022-10-21', 7, "KGL-8459"),
        ('2022-10-04', 350.00, '2022-10-06', 8, "KGY-0398"),
        ('2022-10-10', 120.00, '2022-10-11', 9, "KHX-7855"),
        ('2022-10-17', 450.00, '2022-10-19', 10, "KKN-3667");
        
      
      
       /* Inserindo os serviços efeutados na ordem de serviço*/
        
        insert into fazer_servico
			values(1, 9),
				(2, 4),
				(3, 6),
				(4, 4),
				(5, 7),
				(6, 1),
                (7, 2),
                (8, 9),
                (9, 3),
                (10, 10);
				
                
			
		/* Inserindos as peças utilizadas*/
        
		insert into utilizar_peca
            values(1, 3),
            (2, 3),
            (3, 3),
            (4, 8),
            (5, 10),
            (6, 2),
            (7, 1),
            (8, 9),
            (9, 5),
            (10, 4);
		
        
        /* Inserindo as pecas fornecidas de acordo com o fornecedor*/
	
         insert into fornecer_peca
			values('08.429.785/0001-24', 1),
            ('12.457.612/0001-97', 2),
            ('14.506.593/0001-77', 3),
            ('27.303.332/0001-00', 4),
            ('27.527.034/0001-95', 5),
            ('31.895.270/0001-31', 6),
            ('34.993.882/0001-55', 7),
            ('68.701.475/0001-49', 8),
            ('86.789.755/0001-32', 9),
            ('91.541.061/0001-11', 10);
            
          
		/* Inserindo os produtos fornecidos de acordo com o fornecedor*/
        
            insert into fornecer_produto
			values('08.429.785/0001-24', 1),
            ('12.457.612/0001-97', 2),
            ('14.506.593/0001-77', 3),
            ('27.303.332/0001-00', 4),
            ('27.527.034/0001-95', 5),
            ('31.895.270/0001-31', 6),
            ('34.993.882/0001-55', 7),
            ('68.701.475/0001-49', 8),
            ('86.789.755/0001-32', 9),
            ('91.541.061/0001-11', 10);
            
            
        
      /*Atualizando dados na tabela cliente*/
      
       
       update cliente set email = 'rafa5@gmail.com'
		where idCliente = 1;
        
         update cliente set email = 'edu6@gmail.com'
		where idCliente = 8;
        
         update cliente set email = 'vivi@gmail.com'
		where idCliente = 2;
        
         update cliente set email = 'leos@gmail.com'
		where idCliente = 9;
        
         update cliente set email = 'lipe099@gmail.com'
		where idCliente = 4;
        
        
        /*Atualizando dados na tabela mecanico*/
        
        update mecanico set especialidade = 'Nenhuma'
		where CPF = '180.295.664-98';
        
        update mecanico set email = 'helenafr01@gmail.com'
		where CPF = '020.590.107-06';
        
        update mecanico set email = 'Afduarte@gmail.com'
		where CPF = '020.100.050-88';
        
        update mecanico set email = 'lipeM@gmail.com'
		where CPF = '089.150.210-33';
        
        update mecanico set email = 'ricardoPr@gmail.com'
		where CPF = '180.295.664-98';
        
        update mecanico set email = 'moreiraLuis@gmail.com'
		where CPF = '656.282.914-87';
        
        update mecanico set email = 'joaopgomes@gmail.com'
		where CPF = '530.808.002-50';
        
        update mecanico set email = 'vadinho@gmail.com'
		where CPF = '265.894.584-20';
        
        update mecanico set email = 'freitasGs@gmail.com'
		where CPF = '140.700.390-91';
        
        update mecanico set email = 'Especialista em motos'
		where CPF = '170.550.824-93';
        
        update mecanico set email = 'santiagom05@gmail.com'
		where CPF = '033.210.886-15';
        
        
	/*Atualizando dados na tabela endereco*/
	
        update  endereco set numero = 481
		where idEndereco = 25;
        
        update  endereco set numero = 240
		where idEndereco = 2;
        
        update  endereco set numero = 218
		where idEndereco = 6;
        
        update  endereco set numero = 549
		where idEndereco = 9;
        
        
        
        
								/*  DQL */
                                
                                
                                
                                
/* Relatorio para saber os fonecedores dos respectivos produtos*/

create view fornecedor_produto as select f.nome "Fonecedores", p.nome "Produtos Fornecidos"
	from fornecedores f
		inner join fornecer_produto fn on fn.Fornecedores_CPNJ = f.CNPJ
		inner join produto p on fn.Produto_idProduto = p.idProduto
			order by f.nome;


/* Relatorio para saber as equipes de cada mecanico*/

create view mecanico_equipe as select m.nome "Mecanico", e.idEquipeMecanicos "Equipe"
	from mecanico m
		inner join  equipemecanicos e on m.EquipeMecanicos_idEquipeMecanicos = e.idEquipeMecanicos
			order by m.nome;
		
        
/* Relatorio para saber o total de mecanico por equipe*/

create view quantidade_membros as select e.idEquipeMecanicos"Equipes", count(m.CPF)"Total de Mecanicos"
	from mecanico m
		inner join equipemecanicos e on e.idEquipeMecanicos = m.EquipeMecanicos_idEquipeMecanicos
		group by e.idEquipeMecanicos;



/* Relatorio para saber a idade dos dependentes com base no ano de 2022*/

select nome, (2022 - substring(dataNasc, 1, 4)) as "Idade" 
	from dependente
	order by nome;
    
    
/* Relatorio para saber o total de mecanico que residem no Bairro Afogados*/     
        
select m.nome "Mecanico", ed.bairro "Bairro"
	from mecanico m, endereco ed
		where ed.bairro like "Afogados"
        group by m.CPF;


/* Relatorio para saber o total de dependentes por mecanico*/     

create	view contagem_dependente as select m.nome "Mecanico", count(de.CPF)"Quant Dependente"
	from mecanico m
		inner join dependente de on de.Mecanico_CPF = m.CPF
        group by m.CPF;
        
        
/* Relatorio para saber a quantidade de mulheres na mecanica*/   

create view media_mulheres as select count(m.CPF)"Total de mecanicos", (select count(m.CPF) from mecanico m where sexo = 'F') as "Total de mulheres mecanicas"
	from mecanico m;
		

/* Relatorio para saber quais os mecanicos com o salario acima da media*/

create view salarios_acima_media as select m.nome"Mecanico", m.salario"Salario"
	from mecanico m
        where m.salario > (select avg(salario) from mecanico);
        

/* Relatorio para saber os mecanicos demitidos*/

create view mecanicos_desativados as select nome"Mecanico", dataAdm "Admissão", dataDem "Demissão"
	from mecanico m
		where dataDem is not null;
        
        
/* Relatorio para saber o total de telefones cadastrados para cada grupo*/

select count(numero)"Total de telefones mecanicos", (select count(numero) from telefone where Cliente_idCliente is not null)"Total de telefones clientes",
(select count(numero) from telefone where Fornecedores_CNPJ is not null)"Total de telefones Fornecedores"
	from telefone where Mecanico_CPF is not null;


/* Relatorio para pesquisar por carros de acordo com anos 2003 e 2016*/

select Placa, descricao 
	from veiculo 
		where descricao like "%2003%" or (descricao like "%2016%");
        
        

/* Relatorio para saber quais peças foram utilizadas em quais ordens de serviços*/

create view pecas_mais_utilizadas as select o.idOrdemServico"Ordem de serviço",  p.nome "Pecas utilizadas"
	from peca p
		inner join utilizar_peca ut on p.idPeca = ut.Peca_idPeca
		inner join ordemservico o on o.idOrdemServico = ut.OrdemServico_idOrdemServico
		order by o.idOrdemServico;
        
        
/* Relatorio para saber quais serviços foram feitos*/

	create view servicos_feitos as select o.idOrdemServico"Ordem de serviço", s.nome "Serviço feito"
		from servico s
			inner join fazer_servico f on s.idServico = f.Servico_idServico
            inner join ordemservico o on o.idOrdemServico = f.OrdemServico_idOrdemServico
            order by o.idOrdemServico;
            

/* Relatorio para saber os produtos mais caros*/ 
   
select * 
	from produto 
    where valor > (select avg(valor) from produto)
    order by valor desc;
    
    
/* Relatorio para saber os dependentes do sexo masculino*/ 
select *
	from dependente 
		where sexo = 'M';
        
        
/* Relatorio para saber os carros registrados da marca Ford*/ 
select *
	from veiculo
		where descricao like "%ford%";
        
        
/* Relatorio para saber as ordens de serviços concluidas antes do dias 16*/ 

select * 
	from ordemservico
	 where dataConclusao <= '2022-10-15';


/* Relatorio para saber os produtos com 500ml no estoque*/ 

create view produtos_estocados as select *
	from produto
		where descricao like "%500ml%";
        
        
/* Relatorio para saber os mecanicos admitidos entre 2018 e 2022*/   

select * 
	from mecanico
	 where dataAdm between '2018-01-01' and '2022-12-31'
     order by dataAdm desc;
     
     
/* Relatorio para saber a idade dos mecanicos com base no ano de 2022*/

select nome, (2022 - substring(dataNasc, 1, 4)) as "Idade" 
	from mecanico
	order by nome;
    

