


-- auto relacionamento
select ger.funcodigo 'gerente cod', ger.funnome 'ger nome', sub.funcodigo 'funcionario cod', sub.funnome 'funcionario nome'
from funcionario ger
inner join funcionario sub on ger.funcodigo = sub.funcodgerente
order by ger.funnome;

-- mostrar os nomes dos gerentes e quantidades de subordinados de cada 
select ger.funnome 'gerente', count(*) 'Qtde. subordinados'
from funcionario ger
inner join funcionario sub on ger.funcodigo = sub.funcodgerente
group by ger.funnome
order by ger.funnome;

-- mostrar a venda mais antiga dos cliente em uma empresa
select clinome, venclicodigo, count(*)
from cliente
inner join venda on clicodigo = venclicodigo
group by clinome, venclicodigo
order by venclicodigo;

-- correto subconsulta relacionada


-- achar clientes duplicados

select clinome, count(*) from cliente
group by clinome
having count(*) > 1;


-- funções de Manipulação de Strings

-- left


-- aula 24/05/2019



-- lista 2

-- 2


select pronome, propreco, procusto, ((propreco - procusto)/ propreco)* 100 'per_lucro', 'per_lucro' > (0.5*100)
from produto;



--  pegar lastName usando "left"


select clinome, left(clinome, locate(' ',clinome)) 'lastName' from cliente;


select clinome, right(clinome, locate(' ',clinome)) 'lastName' from cliente;


select clinome, locate(' ',clinome) from cliente;

select clinome, reverse(left(reverse(clinome), locate(' ',reverse(clinome)))) from cliente;

 -- correto

--  pegar lastName usando "right"


-- junções externas (outer joins) 


-- clientes que tem bairro

select bainome

from bairro

where baicodigo in (select clibaicodigo from cliente);





-- outer join verifica os bairro que não tem cliente (primary key do cliente null)
select *
from bairro
left outer join cliente on baicodigo = clibaicodigo
where clicodigo is null;



-- mostre os nomes dos produtos e os codigos de vendas caso um produto não tiver sido vendido deve ser mostrado no resultado
select *
from produto
left outer join itemvenda on procodigo = itvprocodigo
left outer join venda on vencodigo = itvvencodigo;
select vencodigo ,itvvencodigo from itemvenda
inner join venda on vencodigo = itvvencodigo;





select * from bairro
left outer join cliente on baicodigo = clibaicodigo
where clicodigo is null;

 -- subconsulta

-- forma prof
select *from zona
where zoncodigo in (select baizoncodigo from bairro
where baicodigo not in (select clibaicodigo from cliente));



select bainome, zonnome
from bairro
left outer join cliente on baicodigo = clibaicodigo
inner join zona on zoncodigo = baizoncodigo
where clicodigo is null;



-- mostre os nomes dos bairros (incluindo os que não tiverem clientes associados) e o total de clientes em cada.



-- aula 31 de maio
-- mostre os primeiros nomes dos funcionarios que não possuem subordinados (com junção externa e com subconsulta)
-- formar professor
 -- junção externa
select left(ger.funnome, locate(' ',ger.funnome)) 'primeiro nome'
from funcionario ger
left outer join funcionario sub on ger.funcodigo = sub.funcodgerente
where sub.funcodigo is null
order by ger.funcodigo;

-- formar professor - sunconsulta
select funnome from funcionario
where funcodigo not in (select funcodgerente
						from funcionario
                        where funcodgerente is not null)
order by funcodigo;



-- union
select clinome 'nome', clirendamensal 'renda', 'cliente' tipo
from cliente
union all
select funnome, funsalario, 'funcionario'
from funcionario
order by nome;



-- full outer join
-- zona sem cidade

alter table zona
modify zonnome varchar(50) not null;



insert into zona
values(7, 'zona sem cidade 1', null),
	  (8,'zona sem cidade 2',null);



select * from cidade
left outer join zona on zoncidcodigo = cidcodigo
union
select * 
from cidade
right outer join zona on cidcodigo = zoncidcodigo;



select * from cidade
right outer join zona on zoncidcodigo = cidcodigo;




-- mostre o nome, data de demissão e quantidade de vendas dos funcionarios demitidos que são solteiros
select funnome, estdescricao,count(*) 'qtd de vendas de um funcionario', fundtdem 'dt demissão'
from funcionario
inner join venda on venfuncodigo = funcodigo
inner join estadocivil on estcodigo = funestcodigo
where fundtdem is not null and estdescricao = 'solteiro'
group by funcodigo
order by funnome;



-- clientes que não geraram vendas e morem na zona norte
select clinome, venclicodigo, zonnome from cliente
left outer join venda on venclicodigo = clicodigo
inner join bairro on baicodigo = clibaicodigo
inner join zona on zoncodigo = baizoncodigo
where venclicodigo is null and zonnome = 'norte';




-- façam um ranking do valor total de vendas por data
select distinct pronome,propreco, bainome from produto
inner join itemvenda on procodigo = itvprocodigo
inner join venda on vencodigo = itvvencodigo
inner join cliente on clicodigo = venclicodigo
inner join bairro on baicodigo = clibaicodigo
where pronome like '%a%' and propreco > 700 and bainome = 'educandos';
















