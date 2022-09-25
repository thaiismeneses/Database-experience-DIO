-- Criação do banco de dados para o cenário de Oficina
-- DROP DATABASE AutomotiveWorkshop;
CREATE DATABASE IF NOT EXISTS AutomotiveWorkshop;
USE AutomotiveWorkshop;

-- Criar tabela Cliente
CREATE TABLE Clients(
		idClient INT AUTO_INCREMENT PRIMARY KEY
);

DESC Clients;

-- Criar tabela Pessoa Física 
CREATE TABLE Individual(
		idIndividual INT AUTO_INCREMENT,
        FirstName VARCHAR(20) NOT NULL,
        LastName VARCHAR(45) NOT NULL,
        CPF CHAR(11) NOT NULL,
        Address VARCHAR(30) NOT NULL,
        Contact CHAR(11) NOT NULL,
        BirthDate DATE NOT NULL,
        PRIMARY KEY(idIndividual),
        CONSTRAINT unique_cpf_individual unique (CPF),
        CONSTRAINT fk_individual_client FOREIGN KEY (idIndividual) REFERENCES Clients(idClient)
);

DESC Individual;

-- Criar tabela Pessoa Juridica
CREATE TABLE Company(
		idCompany INT AUTO_INCREMENT PRIMARY KEY,
        socialName VARCHAR(255) NOT NULL,
        CNPJ CHAR(15) NOT NULL,
        Address VARCHAR(255) NOT NULL,
        Contact CHAR(11) NOT NULL,
        CONSTRAINT unique_cnpj_company unique (CNPJ),
        CONSTRAINT fk_company_client FOREIGN KEY (idCompany) REFERENCES Clients(idClient)
);

DESC Company;

-- Criar tabela Conserto
CREATE TABLE RepairCar(
		idRepair INT AUTO_INCREMENT PRIMARY KEY,
        repairDescription VARCHAR(255) NOT NULL
);

DESC RepairCar;

-- Criar tabela Revisão
CREATE TABLE InspectionCar(
		idInspection INT AUTO_INCREMENT PRIMARY KEY,
        inspectionDescription VARCHAR(255) NOT NULL
);

DESC InspectionCar;

-- Criar tabela Veiculo
CREATE TABLE Vehicle(
		idVehicle INT AUTO_INCREMENT,
        idClient INT,
        idVInspection INT,
        idVRepair INT,
        Brand VARCHAR (45) NOT NULL,
        Model VARCHAR (45) NOT NULL,
        licencePlate VARCHAR(10) NOT NULL,
        Color VARCHAR (45) NOT NULL,
		PRIMARY KEY(idVehicle, idClient, idVInspection,idVRepair),
        CONSTRAINT unique_vehicle UNIQUE (licencePlate),
        CONSTRAINT fk_vehicle_client FOREIGN KEY (idClient) REFERENCES Clients(idClient),
        CONSTRAINT fk_vehicle_inspection FOREIGN KEY (idVInspection) REFERENCES InspectionCar(idInspection),
        CONSTRAINT fk_vehicle_repair FOREIGN KEY (idVRepair) REFERENCES RepairCar(idRepair)
);

DESC Vehicle;

-- Criar Tabela Mecânico
CREATE TABLE Mechanics(
		idMechanic INT AUTO_INCREMENT PRIMARY KEY,
        FirstName VARCHAR(20) NOT NULL,
        LastName VARCHAR(45) NOT NULL,
        Address VARCHAR(255),
        Specialty VARCHAR(45) NOT NULL,
        Contact CHAR(11) NOT NULL
);

DESC Mechanics;


-- Criar Tabela Ordem de Serviço
CREATE TABLE serviceOrder(
		idServiceOrder INT AUTO_INCREMENT PRIMARY KEY,
        issueDate DATE NOT NULL,
        serviceType VARCHAR(50),
        carPartPrice FLOAT NOT NULL,
        servicePrice FLOAT NOT NULL,
        totalPrice FLOAT NOT NULL,
        StatusService ENUM('In Process','Cancelled', 'Concluded', 'Waiting'),
        dueDate DATE	
);

DESC serviceOrder;

-- Criar tabela de referência
CREATE TABLE referencePrice(
		idReferencePrice INT AUTO_INCREMENT PRIMARY KEY,
        CONSTRAINT fk_referencePrice FOREIGN KEY (idReferencePrice) REFERENCES serviceOrder(idServiceOrder)
);

DESC referencePrice;

-- Criar tabela equipe de mecânicos
CREATE TABLE MechanicsTeam(
		idMechanicsTeam INT AUTO_INCREMENT,
        idSOrder INT,
        idMechanic  INT,
		PRIMARY KEY(idMechanicsTeam, idSOrder, idMechanic),
        CONSTRAINT fk_Mechanics_Team_SO FOREIGN KEY (idSOrder) REFERENCES serviceOrder(idServiceOrder),
        CONSTRAINT fk_Mechanics_Team_Mechanic FOREIGN KEY (idMechanic) REFERENCES Mechanics (idMechanic)
);

DESC MechanicsTeam;

-- Criar tabela de Autorização do Cliente
CREATE TABLE Authorization(
		idAClient INT,
        idASOrder INT,
        Authorization BOOLEAN DEFAULT FALSE,
		PRIMARY KEY(idAClient,idASOrder),
        CONSTRAINT fk_Authorization_service FOREIGN KEY (idASOrder) REFERENCES serviceOrder(idServiceOrder),
        CONSTRAINT fk_Authorization_client FOREIGN KEY (idAClient) REFERENCES Clients (idClient)
);

DESC Authorization;

-- Criar Tabela de Peças
CREATE TABLE CarParts(
		idCarPart INT AUTO_INCREMENT PRIMARY KEY,
        carPartDescription VARCHAR(255) NOT NULL,
        Price FLOAT NOT NULL
);

DESC CarParts;

CREATE TABLE SOCPart(
		idSOCPart INT AUTO_INCREMENT PRIMARY KEY,
        CONSTRAINT fk_SOCarPart_SOrder FOREIGN KEY (idSOCPart) REFERENCES serviceOrder(idServiceOrder),
        CONSTRAINT fk_SOCarPart_CarPart FOREIGN KEY (idSOCPart) REFERENCES CarParts (idCarPart)
);

DESC SOCPart;


-- Criar Tabela de Serviços
CREATE TABLE Service(
		idService INT AUTO_INCREMENT PRIMARY KEY,
        ServiceDescription VARCHAR(225) NOT NULL,
        sPrice FLOAT
);

DESC Service;

CREATE TABLE SoService(
		idSoService INT AUTO_INCREMENT PRIMARY KEY,
		CONSTRAINT fk_SoService_SOrder FOREIGN KEY (idSoService) REFERENCES serviceOrder(idServiceOrder),
        CONSTRAINT fk_SoService_Service FOREIGN KEY (idSoService) REFERENCES Service (idService)
);

DESC SoService;

