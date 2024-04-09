-- 1
CREATE TABLE tb_mulheres(
    id_mulher INTEGER PRIMARY KEY,
    nome_mulher VARCHAR2(50)
);

INSERT INTO tb_mulheres VALUES(1, 'Edna');
INSERT INTO tb_mulheres VALUES(2, 'Stefanny');
INSERT INTO tb_mulheres VALUES(3, 'Cássia'); 

-- 2
CREATE TABLE tb_homens(
    id_homem INTEGER PRIMARY KEY,
    nome_homem VARCHAR2(50), 
    id_mulher INTEGER,
    CONSTRAINT fk_id_mulher 
        FOREIGN KEY (id_mulher) 
        REFERENCES tb_mulheres(id_mulher)
);

INSERT INTO tb_homens VALUES(10, 'Anderson', NULL);
INSERT INTO tb_homens VALUES(20, 'Jander', 1);
INSERT INTO tb_homens VALUES(30, 'Rogério', 2);

-- 3
---- 3.a: todos os casamentos
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS casal
FROM tb_homens h
INNER JOIN tb_mulheres m ON h.id_mulher = m.id_mulher;

---- 3.b: todos os casamentos utilizando natural join
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS casal
FROM tb_homens h
NATURAL INNER JOIN tb_mulheres m;

---- 3.c: todos os casamentos utilizando JOIN...USING
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS casal
FROM tb_homens h
INNER JOIN tb_mulheres m USING(id_mulher);

---- 3.d: todos os casamentos utilizando JOIN...ON
SELECT h.nome_homem || ' é casado com ' || m.nome_mulher AS casal
FROM tb_homens h
INNER JOIN tb_mulheres m ON h.id_mulher = m.id_mulher;

---- 3.e por meio do produto cartesiano, simular todos os casamentos possíveis
------ 3.e.1
SELECT h.nome_homem || 
       ' pode formar casal com ' ||
       m.nome_mulher AS "Possível casal"
FROM tb_homens h, tb_mulheres m;
------ 3.e.2 
SELECT h.nome_homem || 
       ' pode formar casal com ' ||
       m.nome_mulher AS "Possível casal"
FROM tb_homens h
CROSS JOIN tb_mulheres m

-- 4
---- 4.f homens casados ou não
SELECT 
    h.nome_homem || 
    ' é casado com ' ||
    NVL(m.nome_mulher, 'ninguém') AS casal
FROM tb_homens h
LEFT OUTER JOIN tb_mulheres m USING(id_mulher);

---- 4.g mulheres casadas ou não
SELECT 
    m.nome_mulher ||
    ' é casada com ' ||
    NVL(h.nome_homem, 'ninguém') as casal
FROM tb_homens h
RIGHT OUTER JOIN tb_mulheres m USING(id_mulher)

---- 4.h homens casados ou não usando operador (+)
SELECT 
    h.nome_homem || 
    ' é casado com ' ||
    NVL(m.nome_mulher, 'ninguém') AS casal
FROM tb_homens h, tb_mulheres m
WHERE h.id_mulher = m.id_mulher(+);

---- 4.i mulheres casadas ou não usando operador (+)
SELECT 
    m.nome_mulher ||
    ' é casada com ' ||
    NVL(h.nome_homem, 'ninguém') as casal
FROM tb_homens h, tb_mulheres m
WHERE h.id_mulher(+) = m.id_mulher;

---- 4.k todos os casados e solteiros
SELECT 
    NVL(h.nome_homem, 'ninguém') ||
    ' é casado com ' ||
    NVL(m.nome_mulher, 'ninguém') AS casal
FROM tb_homens h
FULL OUTER JOIN tb_mulheres m USING(id_mulher);

---- 4.l
SELECT 
    NVL(h.nome_homem, 'ninguém') ||
    ' é casado com ' ||
    NVL(m.nome_mulher, 'ninguém') AS casal
FROM tb_homens h
FULL OUTER JOIN tb_mulheres m ON h.id_mulher = m.id_mulher;