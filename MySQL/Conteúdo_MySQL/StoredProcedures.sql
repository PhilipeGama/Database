/*  
99.O que são Stored Procedures?

Stored Procedures

Procedimentos armazenados são pequenos programas no banco de dados que podem ser chamados a qualquer momento
*/


CREATE PROCEDURE <proc_nome>(<parametros>)
BEGIN
    /**/
END

CALL <proc_nome>(<parametros>)

/*
     Regras de negócio

Desvantagem
Necessidade de reescrita  dos procedimentos para migração do banco de dados

Vantagem
Por estarem armazenadas no banco de dados é mais fácil trocar as tecnologias de aplicação

*/ 


--  100. Criando e chamando a nossa primeira Procedure

use universidade_u;

delimiter $$
create procedure proc_oi()
begin
	select 'Oi, você acabou de executar um procedimento que está armazenado no bd! Sempre que você precisar é só me chamar.' as msg;
end
$$
delimiter ;

call proc_oi();

-- 101. Consultando, alterando e removendo Procedures

-- Monstar Procedures
show procedure status;

-- Especifíca o banco de dados
show procedure status where Db = 'universidade_u';

-- Mostrar o  conteúdo da procedure
show create procedure proc_oi;

-- Especifica a que banco pertence a procedure
show create procedure universidade_u.proc_oi;

-- Alterar procedure -> remover a procedure e cria-la novamente
drop procedure universidade_u.proc_oi;

delimiter $$
create procedure proc_oi()
begin
	select 'Oi, eu foi modificado!!!' as msg; 
end
$$
delimiter ;

call universidade_u.proc_oi();

-- 102. Definindo parâmetros de entrada

CREATE PROCEDURE <proc_nome>(IN param1 TIPO,in param2 TIPO)
BEGIN
    /**/
END

CALL <proc_nome>(param1,param2);

-- media ponderada
delimiter &&
create procedure proc_media_ponderada(
	in nome varchar(100),
    in p1 float(3,1),
    in p2 float(3,1),
    in p3 float(3,1),
    in p4 float(3,1)
)
-- comentário entende a procedure
comment 'Efetua o cálculo de média ponderada:((p1*2)+(p2*2)+(p3*3)+(p4*3)) / 10'
begin 

	select 
    nome,
	round(
		(((p1*2)+(p2*2)+(p3*3)+(p4*3))/10),2) as 'média ponderada';
end 
&&
delimiter ;

call proc_media_ponderada('Pedro',10,10,10,10);

-- 103 . Definindo parâmetros de saída

CREATE PROCEDURE <proc_nome>(IN param1 TIPO,OUT param2 TIPO)
BEGIN
    /**/
END

CALL <proc_nome>(param1,@param2);

SELECT @param2;
-- o total de alunos e o total de professores

delimiter &&
create procedure proc_resumo(out total_professores int,
out total_alunos int)
comment 'Resumo do total de aluno e professores'
begin
	-- total de professores
		select count(*) into total_professores from professor;
    -- total de aluno
		select count(*) into total_alunos from aluno;
end
&&
delimiter ;
 
call proc_resumo(@x,@y);

select @x as 'Total de professores',@y as 'Total de alunos';

/*
104. O que são variáveis e escopos?
O que são variáveis 
    Não podem ser utilizados caracteres especiais como "ç","^","~"
    Não podem ser iniciadas com números,apenas com letras
    Não podem ser iguais as palavras reservados do sgbd
 Escopo das variás 
    Global
    Sessão
    Parâmetros
    Local
*/
