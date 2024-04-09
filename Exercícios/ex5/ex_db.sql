-- 01 - Consulte a tabela  TB_FUNCAO e retorne uma expressão única  da forma “O  identificador da<descrição  da função>é o ID: <id_funcao>”. 
-- Utilize um alias para essa expressão de coluna como “Descrição da Função” usando a palavra-chave AS.

DESCRIBE tb_funcao;

SELECT 'O identificador da ' ||
       ds_funcao ||
       ' é o ID: ' ||
       id_funcao AS "Descrição da Função"
FROM tb_funcao;

-- 02 - Usando  a  tabela  DUAL,  calcule  a  área  de  uma  circunferência  com  um  raio  de  6000  unidades,  com  PI  sendo, aproximadamente, 22/7.
-- Use a fórmula: Área = pi x raio x raio. Crie um alias no resultado como “Área”.
SELECT ROUND((20/7) * POWER(6000,2), 2) FROM DUAL;

-- 03 - Recupere o(s)    nome(s)    do(s)    departamento(s)que  termine  com  as  três  letras  “ing”  da  tabela TB_DEPARTAMENTO.
DESCRIBE tb_departamento;

SELECT nm_departamento 
FROM tb_departamento 
WHERE nm_departamento LIKE '%ing';

-- 04 - A tabela TB_FUNCAO contém descrições de diferentes tipos de funções que um empregado da empresa pode ocupar. 
-- Ela contém as colunas ID_FUNCAO, DS_FUNCAO, BASE_SALARIO e TETO_SALARIO. 
-- Você precisa escrever  uma  consulta  que  extraia  as  colunas  DS_FUNCAO,  BASE_SALARIO,  e a diferença  entre  os  
-- valores TETO_SALARIO e BASE_SALARIO para cada linha. 
-- Os resultados somente podem incluir valores DS_FUNCAO que  contenham  a  palavra “Presidente”ou “Gerente”.
-- Classifique  a  lista  em  ordem  descendente  baseadona expressão DIFERENÇA. 
-- Se mais de uma linha tiver o mesmo valor DIFERENÇA, então, em adição, classifique essas linhas por DS_FUNCAO na ordem alfabética reversa.
DESCRIBE tb_funcao;

SELECT ds_funcao, 
       base_salario, 
       teto_salario - base_salario AS "Diferença"
FROM tb_funcao
WHERE ds_funcao LIKE '%Presidente%' OR ds_funcao LIKE '%Gerente%'
ORDER BY "Diferença" DESC, ds_funcao;

-- 05 - Para o exercício abaixo, utilize impreterivelmente, variáveis de substituição (& comercial)
-- Um cálculo comum executado pelo Departamento de Recursos Humanos está relacionado ao cálculo de impostos cobrados sobre um determinado empregado. 
-- Apesar disso ser feito para todos os empregados, sempre há alguns membros  da  equipe  que  discutem  os  impostos  retidos  de  seus  salários.
-- O  imposto  retido  por empregado é calculado obtendo o salário anual do empregado e multiplicando-o pela alíquota atual, que pode variar de ano para ano.
-- Você precisa escrever uma consulta reutilizável usando a alíquota atual e os números ID_EMPREGADO como entradas e 
-- retornar as informações ID_EMPREGADO, NOME, SALARIO, SALARIO ANUAL (SALARIO * 12), ALIQUOTA, e ALIQUOTA (ALIQUOTA * SALARIO ANUAL).

SELECT
    id_empregado,
    nome, 
    salario,
    salario * 12 AS "SALARIO ANUAL", 
    &&aliquota, 
    &&aliquota * salario * 12 AS "IMPOSTO RETIDO"
FROM tb_empregado
WHERE id_empregado = &id_empregado;

