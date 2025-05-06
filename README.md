# Oracle-DB-PLSQL
Usando SQL e PL/SQL no banco de dados Oracle instalado na máquina local com SQL developer

Technologies:
* Oracle Database 23ai FREE
* Oracle SQL Developer (Interface Gráfica)
* SQL e PL/SQL

Objetivos:
* Ao invés de usar o Oracle Live SQL usar o Oracle propriamente;
* Ao invés de usar um bloco anônimo do PL/SQL, usar PROCEDURE; com dois parâmetros (id do cliente e nome do cliente) e chamar essa PROCEDURE para ver se funcionou
 
1. Criei uma tabela de clientes
```SQL
CREATE TABLE clientes(
    id_cliente INT,
    nome_cliente VARCHAR2(50),
    sexo VARCHAR2(1),
    email VARCHAR2(50),
    data_nascimento DATE
);
```

2. Populei a tabela de clientes
```SQL
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento)
    VALUES (1, 'João', 'M', 'joao@gmail.com', '01/01/1800');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento)
    VALUES (2, 'Maria', 'F', 'maria@gmail.com', '02/02/1805');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento)
    VALUES (3, 'João', 'M', 'joao@gmail.com', '05/05/1860');

SELECT * FROM clientes;
```
<img src="https://github.com/user-attachments/assets/9265414b-3aab-4469-98e5-d99b004a7c6e" width="400"/>

3. Criação da PROCEDURE (..executar a instrução de criação dela, antes de chama-la no passo 4):
```
SET SERVEROUTPUT ON; -- Ativa o DBMS_OUTPUT

-- SP -> Storage Procedure; apenas uma nomeclatura interessante para indicar que é uma procedure
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
END SP_CONFERE_NM_CLIENTE; -- Colocar o nome de novo da procedure para boas práticas, facilmente visualizar seu fechamento...
```

4. Chamar PROCEDURE
```
BEGIN
    SP_CONFERE_NM_CLIENTE(P_ID_CLIENTE => 1, P_NM_CLIENTE => 'João');
END;

BEGIN
    SP_CONFERE_NM_CLIENTE(P_ID_CLIENTE => 1, P_NM_CLIENTE => 'Luisa');
END;
```
* É possível visualizar que a DBMS_OUTPUT.PUT_LINE printou João porque o id e o nome que vieram na procedures correspondiam ao registro no DB corretamente, já na segunda DBMS_OUTPUT.PUT_LINE veio 'Other name', pois no DB o nome do registro de id 1 é 'João' e não 'Luisa'
<img src="https://github.com/user-attachments/assets/da60e021-15f5-4673-a0d1-eb1324503868" width="400"/>
