-- Criando um banco de dados para E-commerce
CREATE DATABASE Ecommerce;
USE Ecommerce;

-- Criar Tabela Cliente
CREATE TABLE Clients(
		idClient INT AUTO_INCREMENT PRIMARY KEY,
        FirstName VARCHAR(20) NOT NULL,
        LastName VARCHAR(45),
        CPF CHAR(11) NOT NULL,
        BirthDate DATE,
        Address VARCHAR(45) NOT NULL,
        CONSTRAINT unique_cpf_client unique(CPF)        
);

DESC Clients;

-- Criar Tabela Produto
CREATE TABLE Products(
		idProduct INT AUTO_INCREMENT PRIMARY KEY,
        ProductName VARCHAR(45) NOT NULL,
        ProductCode VARCHAR(20),
        Details VARCHAR(45),
        Category VARCHAR(45),
        Price FLOAT NOT NULL        
);

DESC Products;

-- Criar Tabela Pagamento
CREATE TABLE Payments(
		idPayment INT AUTO_INCREMENT PRIMARY KEY,
        idPaymentClient INT,
        Card VARCHAR(45),
        CardNumber VARCHAR(20),
        GoodThru DATE,
        CONSTRAINT fk_payment_client FOREIGN KEY (idPaymentClient) REFERENCES Clients (idClient)
);

DESC Payments;

-- Criar Tabela Entrega
CREATE TABLE Shippings(
		idShipping INT AUTO_INCREMENT PRIMARY KEY,
        ShippingStatus ENUM('Confirmed order', 'In process', 'Sent', 'Delivered') DEFAULT 'In process',
        trackingCode VARCHAR(20),
        estimatedDate DATE
);

DESC Shippings;

-- Criar Tabela Pedido
CREATE TABLE Orders(
		idOrder INT AUTO_INCREMENT PRIMARY KEY,
        idOrderClient INT,
        OrderStatus ENUM('Cancelled', 'Confirmed', 'In process') DEFAULT 'In process',
        OrderDescription VARCHAR(255),
        ShippingPrice FLOAT DEFAULT 0,
        CONSTRAINT fk_order_client FOREIGN KEY (idOrderClient) references Clients(idClient),
        CONSTRAINT fk_shipping FOREIGN KEY (idOrder) REFERENCES Shippings(idShipping)
);

DESC Orders;

-- Criar Tabela Estoque
CREATE TABLE Stock(
		idStock INT AUTO_INCREMENT PRIMARY KEY,
        location VARCHAR(45)
);

DESC Stock;


-- Criar tabela produtos em estoque
CREATE TABLE productStock(
		idProductStock INT,
        idProduct INT PRIMARY KEY,
        Quantity INT,
        CONSTRAINT fk_stock FOREIGN KEY (idProduct) REFERENCES Products(idProduct),
        CONSTRAINT fk_product_stock FOREIGN KEY (idProductStock) REFERENCES Stock(idStock)
);

DESC productStock;


-- Criar tabela fornecedor
CREATE TABLE Supplier(
		idSupplier INT AUTO_INCREMENT PRIMARY KEY,
        socialName VARCHAR(45) NOT NULL,
        CNPJ CHAR(15) NOT NULL,
        contact CHAR(11) NOT NULL,
        CONSTRAINT unique_supplier UNIQUE (CNPJ)
);

DESC Supplier;


CREATE TABLE productSupplier(
		idPsSupplier INT,
        idPsProduct INT,
        productQuantity INT DEFAULT 0,
        PRIMARY KEY (idPsSupplier, idPsProduct),
        CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPsSupplier) REFERENCES Supplier (idSupplier),
        CONSTRAINT fk_product_supplier_product FOREIGN KEY (idPsProduct) REFERENCES Products (idProduct)
);

DESC productSupplier;

-- Criar tabela Vendedor
CREATE TABLE Seller(
		idSeller INT AUTO_INCREMENT PRIMARY KEY,
        socialName VARCHAR(255) NOT NULL,
        CNPJ CHAR(15) NOT NULL,
        CPF CHAR(11) NOT NULL,
        location VARCHAR(255) NOT NULL,
		contact CHAR(11) NOT NULL,
		CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
        CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

DESC Seller;

CREATE TABLE productSeller(
		idSProduct INT,
        idSSeller INT,
        productQuantity INT DEFAULT 0,
        PRIMARY KEY (idSProduct, idSSeller),
        CONSTRAINT fk_product_seller_seller FOREIGN KEY (idSSeller) REFERENCES Seller(idSeller),
        CONSTRAINT fk_product_seller_product FOREIGN KEY (idSProduct) REFERENCES Products(idProduct)
);

DESC productSeller;

CREATE TABLE productOrder(
		idPoProduct INT,
        idPoOrder INT,
        productQuantity INT DEFAULT 0,
        PRIMARY KEY (idPoProduct, idPoOrder),
        CONSTRAINT fk_product_order_order FOREIGN KEY (idPoOrder) REFERENCES Orders(idOrder),
        CONSTRAINT fk_product_product_order FOREIGN KEY (idPoProduct) REFERENCES Products(idProduct)
 );
 
 DESC productOrder;





