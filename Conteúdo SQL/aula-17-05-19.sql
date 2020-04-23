use bd201901;

-- QUESTÃO 3 LISTA 2
select zonnome 'Zona', clisexo 'Sexo', count(*) 'Total de clientes' from
zona
inner join bairro on zoncodigo = baizoncodigo
inner join cliente on baicodigo = clibaicodigo
group by zonnome, clisexo
having count(*) >=10
order by count(*) desc;


-- CLIENTES COM A MENOR RENDA
select clinome 'Nome', clirendamensal 'Valor'
from cliente
where clirendamensal = (select min(clirendamensal) from cliente);


-- 5 MENORES RENDAS
select distinct clinome 'Nome', clirendamensal 'Renda'
from cliente
where clirendamensal is not null
order by clirendamensal
limit 5;

select clinome 'Cliente', clirendamensal 'Renda'
from cliente
where clirendamensal in (select clirendamensal  from 
												(select distinct clirendamensal 
												from cliente
												where clirendamensal is not null
												order by clirendamensal
												limit 5) c1
						)
order by clirendamensal desc;


-- QUESTÃO 1 LISTA 2
select distinct clinome 'Nome', avg(clirendamensal) 'Média'
from cliente
inner join estadocivil on  estcodigo = cliestcodigo
inner join bairro on  baicodigo = clibaicodigo
inner join zona on zoncodigo = baizoncodigo 
where estdescricao in ('solteiro', 'divorciado')
and zonnome  not in('norte', 'sul', 'leste')
group by clinome;   


-- QUESTÃO 13 LISTA 2
select grpdescricao 'Média'
from produto
inner join grupoproduto on grpcodigo = progrpcodigo
group by grpdescricao
having avg(propreco) = (select avg(propreco)
						from produto
						inner join grupoproduto on grpcodigo = progrpcodigo
                        group by grpdescricao
                        order by avg(propreco) desc
                        limit 1);
                        
					
-- AUTORELACIONAMENTO
select ger.funcodigo, ger.funnome, sub.funcodigo, sub.funnome
from funcionario ger
inner join funcionario sub on ger.funcodigo = sub.funcodgerente
order by ger.funnome;


-- MOSTRE O NOME DOS GERENTES E QTDE DE SUBORDINADOS DE CADA
select ger.funnome 'Gerente', count(*) 'Qtde'
from funcionario ger
inner join funcionario sub on ger.funcodigo = sub.funcodgerente
group by ger.funnome
order by ger.funnome;


-- Nomes de clientes duplicados no banco de dados
select clinome, count(*)
from cliente
group by clinome
having count(*) > 1;

-- Nome de clientes que tem mais de uma venda
select clinome 'Nome', count(*) 'Qtde'
from cliente
inner join venda on clicodigo = venclicodigo
group by clinome
having count(*) > 1;

-- Primeira  venda feita por cada cliente
select clicodigo, clinome, vext.vendata
from cliente
inner join venda vext on clicodigo = vext.venclicodigo
where vext.vendata = (select min(vint.vendata)
						from venda vint
                        where vint.venclicodigo = clicodigo);
                        


