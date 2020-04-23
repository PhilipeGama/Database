select count(*) from cliente
where clisexo = 'f';

select count(*) 'Contagem',
		sum(clirendamensal)'Soma',
        avg(clirendamensal)'Média',
        max(clirendamensal)'Maior Sálraio',
        min(clirendamensal)'Menor Sálario'
from cliente
where clisexo = 'm'; 

select distinct clinome 
from cliente
inner join  venda on clicodigo = venclicodigo;

#clientes que geraram venda


select count(*) clinome 
from cliente
inner join  venda on clicodigo = venclicodigo;


select bainome,clinome
from bairro
inner join cliente on baicodigo = clibaicodigo
order by bainome;

select bainome
from bairro
where baicodigo in (select clibaicodigo from cliente);


select clibaicodigo from cliente;

select bainome 'Bairro',count(*) 'Clientes'
from bairro
inner join cliente on baicodigo = clibaicodigo
group by bainome
having count(*) > 50;

# pessoas por bairros
select grpdescricao,count(*)
from grupoproduto
inner join produto on grpcodigo = progrpcodigo
where proativo = 1
group by grpdescricao
order by count(*) desc;

# pessoas por bairros
select grpdescricao,sum(prosaldo),count(*)
from grupoproduto
inner join produto on grpcodigo = progrpcodigo
where proativo = 1
group by grpdescricao
order by count(*) desc;

# mostre o nome dos produtos vendidos
select distinct pronome
from produto 
inner join itemvenda on procodigo = itvprocodigo;

#mostre o nomes dos bairros que tenha cliente com vendas

select bainome 'Nome do Bairro',count(*) 'Venda Bairro'from bairro 
inner join cliente on baicodigo = clibaicodigo
inner join venda on clicodigo = venclicodigo
group by bainome;


#1
 select clinome,clirendamensal,zonnome from cliente
 inner join estadocivil on estcodigo = cliestcodigo
 inner join bairro on baicodigo = clibaicodigo
 inner join zona on zoncodigo = baizoncodigo
 where estdescricao in ('Casado','Solteiro') and zonnome in('NORTE','SUL') 
 order by clirendamensal desc;

#2
select avg(funsalario) from funcionario
inner join estadocivil on estcodigo = funestcodigo
group by estcodigo;

#3
select clinome'Cliente',sum(itvqtde*propreco) 'Compra Total' from produto
inner join itemvenda on procodigo = itvprocodigo
inner join venda on vencodigo = itvvencodigo
inner join cliente on clicodigo = venclicodigo
where clisexo = 'M'
group by clicodigo
having sum(itvqtde*propreco) > 25000;
#4
select count(*),bainome from cliente
inner join bairro on baicodigo = clibaicodigo
where clisexo = 'F' and clinome like '%a%' and  clinome like '%v%'
group by baicodigo;


