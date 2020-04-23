use bd201901;

select count(*) 'Contagem',
		sum(clirendamensal) 'Soma',
		avg(clirendamensal) 'Média', 
		max(clirendamensal) 'Máximo',
		min(clirendamensal) 'Mínimo'
from cliente
where clisexo='m';

select bainome, clinome
from bairro
inner join cliente on baicodigo = clibaicodigo;

select bainome, clinome
from bairro
inner join cliente on baicodigo = clibaicodigo
order by bainome;

select bainome, clinome
from bairro
inner join cliente on baicodigo = clibaicodigo
group by bainome;

select bainome, clisexo, count(*)
from bairro
inner join cliente on baicodigo = clibaicodigo
group by bainome, clisexo;

-- 1)selecionar a quantidade de produtos por grupo de produtos e em ordem decrescente--
select grpdescricao 'Group', count(*) 'Qtde'
from grupoproduto
inner join produto on grpcodigo = progrpcodigo 
group by grpdescricao
order by count(*) desc;

-- 2)produtos em estoque -- 
select grpdescricao 'Group', count(*) 'Qtde'
from grupoproduto
inner join produto on grpcodigo = progrpcodigo 
where proativo='1'
group by grpdescricao
order by count(*) desc;


-- 3)mostrar os produtos vendidos--
select distinct pronome 'Produto vendido'
from produto 
inner join itemvenda on procodigo = itvprocodigo;

-- 4)bairros que tem clientes com vendas -- 
select distinct bainome 'Bairro'
from bairro
inner join cliente on baicodigo = clibaicodigo
inner join venda on clicodigo = venclicodigo;

-- --
select bainome, count(*)
from bairro
inner join cliente on baicodigo = clibaicodigo
where bainome = 'centro'
group by bainome
having count(*) > 50;

-- 5) mostrar os nomes e valores de rendas dos clientes solteiros ou casados das zonas norte e sul-- 
select clirendamensal 'Renda', clinome 'Nome'
from cliente
inner join bairro on clibaicodigo = baicodigo
inner join zona on zoncodigo = baizoncodigo
inner join estadocivil on estcodigo = cliestcodigo
where estdescricao in ('CASADO', 'SOLTEIRO') and zonnome in('NORTE', 'SUL')
order by clirendamensal desc;

-- 6)mostre as medias de salarios de funcionários, por estado civil--
select estdescricao 'Estado civil', avg(funsalario)
from funcionario
inner join estadocivil on estcodigo = funestcodigo
group by estdescricao;

-- 7)mostre os valores de venda de clientes que tenham sexo feminino, somente para totais acima de 25.000--
select vencodigo 'Venda', sum(propreco* itvqtde) 'Total'
from cliente
inner join venda on clicodigo = venclicodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
where clisexo = 'M'
group by vencodigo
having sum(propreco* itvqtde)> 25000;

-- subconsultas -- 
select bainome
from bairro
where baicodigo in( select clibaicodigo 
					from cliente);
                    
-- questão 14) --
select clinome 'Cliente', bainome 'Bairro'
from bairro
inner join cliente on baicodigo = clibaicodigo
inner join venda on clicodigo = venclicodigo
where bainome in('Cidade Nova', 'Cachoerinha', 'Chapada', 'Japiim', 'Educandos')
and venfuncodigo in (select funcodigo
						from zona
							inner join bairro on zoncodigo = baizoncodigo
							inner join funcionario on baicodigo = funbaicodigo
							inner join estadocivil on estcodigo = funestcodigo
							where zonnome= 'sul'
							and estdescricao in ('solteiro', 'divorciado'));
                            
-- nome dos clientes que tenham o menor salário--
select clinome 'Nome'
from cliente
where clirendamensal= (select min(clirendamensal)
						from cliente);
                        
-- Mostre os nomes dos produtos, e de seus grupos, somente para os ativos e que tenham valor acima da media dos valores(preços) dos produtos --
select pronome, grpdescricao
from produto
inner join grupoproduto on grpdescricao = progrpcodigo
where proativo= 1 and propreco > avg(propreco)

-- Mostre os nomes dos produtos; a)mais b)menos vendidos
-- Mosrte os nomes dos clientes que tiverem a maior e menor qtde de vendas geradas
