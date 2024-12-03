CREATE TABLE clientes(
    id_cliente INT,
    nome_cliente VARCHAR2(50),
    sexo VARCHAR2(1),
    email VARCHAR2(50),
    data_nascimento DATE
);

-- Preenche tabela de clientes
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento)
    VALUES (1, 'João', 'M', 'joao@gmail.com', '01/01/1800');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento)
    VALUES (2, 'Maria', 'F', 'maria@gmail.com', '02/02/1805');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento)
    VALUES (3, 'João', 'M', 'joao@gmail.com', '05/05/1860');

SELECT * FROM clientes;

-- pl/sql
SET SERVEROUTPUT ON; -- Ativa o DBMS_OUTPUT

CREATE OR REPLACE PROCEDURE SP_CONFERE_NM_CLIENTE (P_ID_CLIENTE NUMBER,
                                                   P_NM_CLIENTE VARCHAR2) IS
	VAR_NM_CLIENTE  clientes.nome_cliente%Type;
BEGIN
	SELECT nome_cliente
     INTO VAR_NM_CLIENTE
      FROM clientes
       WHERE id_cliente = P_ID_CLIENTE;

	IF VAR_NM_CLIENTE = P_NM_CLIENTE THEN
        DBMS_OUTPUT.PUT_LINE(VAR_NM_CLIENTE);
	ELSE
		DBMS_OUTPUT.PUT_LINE('Other name');
	END IF;
END SP_CONFERE_NM_CLIENTE;

BEGIN
    SP_CONFERE_NM_CLIENTE(P_ID_CLIENTE => 1, P_NM_CLIENTE => 'João');
END;
BEGIN
    SP_CONFERE_NM_CLIENTE(P_ID_CLIENTE => 1, P_NM_CLIENTE => 'Luisa');
END;
