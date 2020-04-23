show databases;

use bd201901;



-- 1. Liste a média de salários dos clientes que não morem na zona norte, sul ou leste, e possuam como
-- estado civil “solteiro” ou “divorciado”. 
select clinome'nome',avg(clirendamensal)'media salário' from cliente
inner join estadocivil on estcodigo = cliestcodigo
inner join bairro on baicodigo = clibaicodigo
inner join zona on zoncodigo = baizoncodigo
where zonnome not in('NORTE','SUL','LESTE') 
and estdescricao in('Solteiro','Divorciado')
group by clinome;


-- 2. Mostre os nomes dos produtos e de seus grupos, somente para os que tiverem sido vendidos mais de
-- uma vez, com lucro maior que 50
select pronome,grpdescricao,count(procodigo) from grupoproduto
inner join produto on grpcodigo = progrpcodigo
inner join itemvenda on procodigo = itvprocodigo
inner join venda on vencodigo = itvvencodigo
group by vencodigo
having count(procodigo) > 1;

-- 3. Crie um “ranking” de total de clientes por zona e sexo, eliminando do resultado os registros que tenham
-- totalizado menos de 10 clientes. */
select zonnome,clisexo,count(*) from cliente 
select zonnome 'zona', clisexo 'sexo',count(*) from zona
inner join bairro on zoncodigo= baicodigo
inner join cliente on baicodigo = clibaicodigo
group by zonnome, clisexo
having count(*) >= 10
order by count(*) desc;


-- 4. Altere a questão anterior, de forma que sejam eliminados do resultado aqueles clientes que não tenham gerado vendas 
select zonnome,clisexo,count(*) from cliente
inner join venda on clicodigo = venclicodigo 
inner join bairro on baicodigo = clibaicodigo
inner join zona on zoncodigo = baizoncodigo
group by zoncodigo,clisexo
having count(*) > 10;


/*5. Liste a média de salários dos clientes que não sejam solteiros, somente para os que tenham os nomes
iniciando e terminando com “a”, “e” ou “o”. */
select avg(clirendamensal) from cliente
inner join estadocivil on estcodigo = cliestcodigo
where clinome like '%a' or clinome like '%e' or clinome like '%o';


-- Mostre a quantidade total de produtos dos grupos "informatica" e "foto" vendidos por funcionários
-- solteiros e da zona sul ou leste
select grpdescricao,sum(itvqtde)
from grupoproduto
inner join produto on grpcodigo = progrpcodigo
inner join itemvenda on procodigo = itvprocodigo
inner join venda on vencodigo = itvvencodigo
inner join funcionario on funcodigo = venfuncodigo
inner join estadocivil on estcodigo = funestcodigo
inner join bairro on baicodigo = funbaicodigo
inner join zona on zoncodigo = baizoncodigo
where grpdescricao in('INFORMATICA','FOTO') 
and zonnome in('SUL','LESTE') and estdescricao = 'Solteiro'
group by grpcodigo;

-- 7. Mostre o nome dos fornecedores que fornecerem o maior número de produtos com valores acima de 500. 
select fornome,count(*) from fornecedor
inner join produto on forcnpj = proforcnpj
where propreco > 500
group by forcnpj
order by count(procodigo) desc;

-- 8 Mostre os nomes dos produtos vendidos (sem repetição) que tenham o maior número de vendas */
select distinct pronome,count(*) from produto
inner join  itemvenda on procodigo = itvprocodigo
inner join venda on vencodigo = itvvencodigo
group by vencodigo
order by count(procodigo) desc;

-- 9 Mostre o(s) nome(s) do(s) produto(s) e de seus grupos, somente para os que tenham o menor saldo em
-- estoque, desde que esse saldo seja diferente de zero. */
select pronome,grpdescricao,prosaldo from produto
inner join grupoproduto on grpcodigo = progrpcodigo
where not prosaldo = 0 
order by prosaldo;

-- 10. Mostre os nomes dos funcionários não demitidos com o menor número de vendas geradas.
select funnome,count(*)'vendas' from funcionario
inner join venda on funcodigo = venfuncodigo
where fundtdem is null
group by funcodigo
order by count(*);


-- 11. Mostre os nomes dos clientes que tiveram o maior valor total em vendas.
-- group by
select sum(propreco * itvqtde) 'total'
from cliente
inner join venda on clicodigo = venclicodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
group by clinome
order by total desc
limit 1;

-- subconsulta
select sum(propreco * itvqtde) 'total'
from cliente
inner join venda on clicodigo = venclicodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
group by clinome
having sum(propreco * itvqtde) = ( select sum(propreco * itvqtde) 'total'
									from cliente
									inner join venda on clicodigo = venclicodigo
									inner join itemvenda on vencodigo = itvvencodigo
									inner join produto on procodigo = itvprocodigo	
									group by clinome	
									order by total desc
									limit 1)

-- 12. Mostre os nomes dos clientes com menor renda e que geraram vendas de produtos ativos e com saldo maior que 0.
-- sem subconsulta
select clinome,clirendamensal from cliente
inner join venda on clicodigo = venclicodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
where proativo = 1 and prosaldo > 0
order by clirendamensal;

-- com subconsulta
select clinome,clirendamensal
from cliente
inner join venda on clicodigo = venclicodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
where clirendamensal = (select min(clirendamensal)
						 from cliente
						 inner join  venda on clicodigo = venclicodigo
						 inner join itemvenda on vencodigo = itvvencodigo
						 inner join produto on procodigo = itvprocodigo
						 where proativo = 1 and prosaldo > 0
						 order by clirendamensal
						 limit 1
					   );

-- 13. Mostre os nomes dos grupos de produtos que tenham as maiores médias de valores, considerando os
-- preços de seus produtos
-- sem subconsulta
select grpdescricao 'Média'
from produto
inner join grupoproduto on grpcodigo = progrpcodigo
group by grpdescricao
having avg(propreco)
order by propreco desc
limit 1; 

-- com subconsulta
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
                        
                        
                        
