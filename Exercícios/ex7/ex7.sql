-- 1:
SELECT e.nome,  f.ds_funcao, e.data_admissao
FROM tb_empregado e
INNER JOIN tb_funcao f ON e.id_funcao = f.id_funcao
WHERE e.data_admissao BETWEEN DATE '1987-02-20' AND DATE '1989-05-01'
ORDER BY 3 ASC;

-- 2
SELECT
    UPPER(e.nome) AS "Nome",
    LENGTH(e.sobrenome) AS "Tamanho Sobrenome",
    d.nm_departamento AS "Nome Departamento",
    p.nm_pais AS "Nome País"
FROM tb_empregado e
INNER JOIN tb_departamento d ON e.id_departamento = d.id_departamento
INNER JOIN tb_localizacao l ON d.id_localizacao = l.id_localizacao
INNER JOIN tb_pais p ON l.id_pais = p.id_pais
WHERE REGEXP_LIKE(e.nome, '^[BLA]')
ORDER BY 1;

-- 3: 
SELECT
    e.nome AS "Nome Empregado",
    d.nm_departamento AS "Nome Departamento",
    l.cidade || ' - ' || l.estado AS "Localização"
FROM tb_empregado e
INNER JOIN tb_departamento d ON e.id_departamento = d.id_departamento
INNER JOIN tb_localizacao l ON d.id_localizacao = l.id_localizacao
WHERE e.percentual_comissao > 0;

-- 4: 
SELECT e.nome ||
       ' trabalha para ' ||
       NVL(g.nome, 'os acionistas') AS "Trabalha para"
FROM tb_empregado e
LEFT JOIN tb_empregado g ON e.id_gerente = g.id_empregado
ORDER BY 1 DESC;

-- 5:
CREATE OR REPLACE PROCEDURE sp_get_emp(
    p_id IN INTEGER) 
AS 
    v_nome_empregado tb_empregado.nome%TYPE;
    v_ds_funcao tb_funcao.ds_funcao%TYPE;
    v_controle INTEGER;
BEGIN 
    IF p_id IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Id do empregado não informado');
        RETURN;
    END IF;

    SELECT COUNT(*) INTO v_controle
    FROM tb_empregado
    WHERE id_empregado = p_id;

    IF v_controle = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Empregado com id ' || p_id || ' não encontrado');
        RETURN;
    END IF;

    SELECT e.nome, f.ds_funcao 
    INTO v_nome_empregado, v_ds_funcao 
    FROM tb_empregado e
    INNER JOIN tb_funcao f ON e.id_funcao = f.id_funcao
    WHERE e.id_empregado = p_id;
   
    DBMS_OUTPUT.PUT_LINE(
        'Nome: ' || 
        v_nome_empregado ||
        ' - Função: ' ||
        v_ds_funcao);
END;

SET serveroutput ON 
BEGIN sp_get_emp(200); END;

SET serveroutput ON 
BEGIN sp_get_emp(999); END;