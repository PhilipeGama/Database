use bd201901;

-- 1.a

alter table funcionario
add fundtnascto date,
add fundtadmissao date,
add funsexo char(1);

-- 1.b

alter table venda
add vendtcancelamento date;

-- 1.c

create table formapagamento(
fpgcodigo smallint unsigned not null,
fpgdescricao varchar(80) not null,
fpgativo boolean not null,
primary key (fpgcodigo)
);

-- 1.d

alter table venda
add venfpgcodigo smallint unsigned not null;

-- 1.e

alter table venda
add constraint formapagamento_venda_fk
foreign key (venfpgcodigo) references formapagamento(fpgcodigo);

-- 2

insert into formapagamento
	values
		(1, 'Dinheiro', 1),
        (2, 'Credito', 1),
        (3, 'Débito', 1);
        
update venda
set venfpgcodigo = 1;

-- 3 

update funcionario
set funsexo='M'
where funcodigo in (1,2,3,6,9,10);

update funcionario
set funsexo='F'
where funcodigo in (4,5,7,8);

-- 4
update funcionario
set fundtnascto='1997-09-29'
where funcodgerente in (2,15)
limit 10;

-- 5
insert into funcionario
	values
		(35, 'Josué Filho', 680.50, 5, 2, null, 1, '', '', '1997-09-01', '2019-05-03', 'M'),
        (36, 'Helena Medley', 750.50, 5, 2, null, 1, '', '', '1997-09-15', '2019-05-03', 'F');
-- 6
select funsalario + (funsalario * 0.10)
from funcionario
where fundtdem is null;

-- 7
update funcionario
set fundtdem='2019-05-03' 
where funcodigo = '21';

-- Questão 8 Mostre o nome, custo e saldo dos produtos ativos com saldo maior que 5, que foram comprados por
-- clientes casados e do sexo masculino.

select pronome 'Nome Produto', procusto 'Custo', prosaldo 'Saldo'
from produto
inner join itemvenda on itvprocodigo = procodigo
inner join venda on vencodigo = itvvencodigo
inner join cliente on clicodigo = venclicodigo
inner join estadocivil on estcodigo = cliestcodigo
where prosaldo > 5 and estdescricao = 'casado' and clisexo = 'M' and proativo = 1;

-- 9
select clinome 'Nome cliente'
from cliente
inner join  venda  on clicodigo = venclicodigo
inner join funcionario on venfuncodigo = funcodigo
where clisexo = 'F' and 
clirendamensal >= 1000 and clirendamensal<=1500 
and fundtdem is not null;

-- 10
select funnome 'Nome Funcionário', funsalario 'Salário',zonnome 'Zona' 
from funcionario
inner join bairro on baicodigo = funbaicodigo
inner join zona on zoncodigo = baizoncodigo
where fundtadmissao is not null;

-- 11
select funnome 'Nome Funcionário', funsalario 'Salário',zonnome 'Zona'
from funcionario
inner join bairro on baicodigo = funbaicodigo
inner join zona on zoncodigo = baizoncodigo
where funnome like '%s' and fundtadmissao is null;

-- 12
select clinome 'Nome Cliente',zonnome 'Zona',estdescricao 'Estado Civil'
from zona
inner join bairro on zoncodigo = baizoncodigo
inner join cliente on baicodigo = clibaicodigo
inner join venda on clicodigo = vencodigo
inner join estadocivil on estcodigo = cliestcodigo;


-- 13
select pronome 'Nome Produto'
from  cidade
inner join fornecedor on cidcodigo = forcidcodigo
inner join produto on forcnpj = proforcnpj
where cidnome not in('Manaus','Porto Velho','Rio branco')
order by pronome;  

-- 14
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


-- 15
select distinct grpdescricao 'Grupo Produtos'
from cidade
inner join zona on cidcodigo = zoncidcodigo
inner join bairro on zoncodigo = baizoncodigo
inner join cliente on baicodigo = clibaicodigo
inner join venda on clicodigo = venclicodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
inner join grupoproduto on grpcodigo = progrpcodigo
where grpativo is null and cidnome = 'Manaus';

-- 16
select vencodigo 'Código Venda', pronome 'Nome Produto', itvqtde 'Quantidade'
from venda
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
where proativo = 0;

-- 17
select funnome 'Nome Funcionário',pronome 'Nome Produto',propreco 'Preço'
from funcionario
inner join venda on funcodigo = venfuncodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
where funnome like '%f%' or funnome like '%u%'
order by funnome,propreco;

-- 18
select clinome 'Nome Cliente'
from cliente
inner join venda on clicodigo = venclicodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
inner join grupoproduto on procodigo = grpcodigo
where proativo = 1 and grpdescricao = 'Informatica';

-- 19
select zonnome 'Zona', estdescricao 'Estado Civil', avg(clirendamensal) 'Média'
from zona
inner join bairro on zoncodigo = baizoncodigo
inner join cliente on baicodigo = clibaicodigo
inner join estadocivil on estcodigo = cliestcodigo
where zonnome not in ('norte', 'sul', 'leste') and estdescricao in ('solteiro', 'divorciado')
group by zonnome, estdescricao;


-- 20
select pronome,grpdescricao from grupoproduto
inner join produto on grpcodigo = progrpcodigo
inner join itemvenda on procodigo = itvprocodigo
inner join venda on vencodigo = itvvencodigo
where ((procusto/propreco)*100) > 50
group by procodigo
having count(procodigo) > 1;

-- 21
select zonnome,clisexo,count(*) from cliente 
inner join bairro on baicodigo = clibaicodigo
inner join zona on zoncodigo = baizoncodigo
group by zoncodigo,clisexo
having count(*) > 10
order by count(*) desc;


-- 22 
select zonnome,clisexo,count(*) from cliente
inner join venda on clicodigo = venclicodigo 
inner join bairro on baicodigo = clibaicodigo
inner join zona on zoncodigo = baizoncodigo
group by zoncodigo,clisexo
having count(*) > 10;


-- 23
select avg(clirendamensal) from cliente
inner join estadocivil on estcodigo = cliestcodigo
where (clinome like 'a%' or clinome like 'e%' or clinome like 'o%'
and  clinome like '%a' or clinome like '%e' or clinome like '%o') 
and not estdescricao = 'solteiro';


-- 24
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

-- 25
select fornome,count(*) from fornecedor
inner join produto on forcnpj = proforcnpj
where propreco > 500
group by forcnpj
order by count(*) desc;

-- 26 
select distinct pronome,count(*) from produto
inner join  itemvenda on procodigo = itvprocodigo
inner join venda on vencodigo = itvvencodigo
group by pronome
having count(*) = ( select count(*) from produto
					inner join  itemvenda on procodigo = itvprocodigo
					inner join venda on vencodigo = itvvencodigo
					group by pronome
					order by count(*) desc 
                    limit 1);

-- 27
select pronome,grpdescricao,prosaldo from produto
inner join grupoproduto on grpcodigo = progrpcodigo
where not prosaldo = 0 
order by prosaldo;

-- 28
select funnome,count(*)'vendas' from funcionario
inner join venda on funcodigo = venfuncodigo
where fundtdem is null
group by funcodigo
having count(*) = (select count(*) from funcionario
					inner join venda on funcodigo = venfuncodigo
					where fundtdem is null
					group by funcodigo 
                    order by count(*)
                    limit 1);
                    

-- 29
select clinome,sum(itvqtde*propreco)'media'
from cliente 
inner join venda on clicodigo = venclicodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
group by clinome
having media = (
				select sum(itvqtde*propreco)'media'
				from cliente 
				inner join venda on clicodigo = venclicodigo
				inner join itemvenda on vencodigo = itvvencodigo
				inner join produto on procodigo = itvprocodigo
				group by clinome
				order by media desc
				limit 1); 


-- 30
select clinome
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

-- 31
select grpdescricao 'Média'
from produto
inner join grupoproduto on grpcodigo = progrpcodigo
group by grpcodigo
having avg(propreco) = (select avg(propreco)
						from produto
						inner join grupoproduto on grpcodigo = progrpcodigo
                        group by grpcodigo
                        order by avg(propreco) desc 
                        limit 1
                        );
               

-- 32
select procodigo,pronome,ven1.vendata from produto
inner join itemvenda itv1 on procodigo = itv1.itvprocodigo
inner join venda ven1 on ven1.vencodigo = itv1.itvvencodigo
where ven1.vendata = (select max(ven2.vendata) from venda ven2
					  inner join itemvenda itv2 on ven2.vencodigo = itv2.itvvencodigo	
                      			  where procodigo = itv2.itvprocodigo);
                                  
select extpro.procodigo,extpro.pronome,extven.vendata from produto extpro
inner join itemvenda extitv on extpro.procodigo = extitv.itvprocodigo
inner join venda extven on extven.vencodigo = extitv.itvvencodigo
where extven.vendata = (select max(intven.vendata) from venda intven
					  inner join itemvenda intitv on intven.vencodigo = intitv.itvvencodigo	
                      			  where extpro.procodigo = intitv.itvprocodigo);

-- 33	
select  
right(clinome, locate(' ', reverse(clinome)) -1) 'Ultimo Nome',bainome'Bairro'
from cliente 
inner join estadocivil on estcodigo = cliestcodigo
inner join bairro on baicodigo = clibaicodigo
where estdescricao in('solteiro','divorciado');

-- 34
select funnome,estdescricao from funcionario 
inner join venda on funcodigo = venfuncodigo
inner join estadocivil on estcodigo = funestcodigo
group by funcodigo
order by count(*) desc
limit 3;           

-- 35                     
select distinct zonnome from bairro
inner join zona on zoncodigo = baizoncodigo
where baicodigo not in(select clibaicodigo from cliente  where clibaicodigo is not null);                        



-- 36
select distinct ger.funnome,estdescricao from funcionario ger
inner join funcionario sub on ger.funcodigo = sub.funcodgerente
inner join estadocivil on estcodigo = ger.funestcodigo
where estdescricao in('solteiro','casado')
group by ger.funcodigo
having count(*) < 3;

-- 37
select ext.funcodigo from funcionario ext where funcodigo in(
select funcodgerente  from funcionario inter where  ext.funcodigo = inter.funcodgerente)
order by ext.funcodigo;
 


-- 38
select concat('O cliente ',clinome,' possui ',length(clinome),' caracteres em seu nome, sexo ',clisexo,'e é ',estdescricao)'cliente'
from cliente
inner join estadocivil on estcodigo = cliestcodigo;

-- 39
select locate('DA',pronome) loc,locate('MA',pronome) loc2,locate('CA',pronome) loc3,pronome from produto
where locate('DA',pronome) or locate('MA',pronome) or locate('CA',pronome) ;


-- 41 
select bainome 'Bairro',funsexo 'Sexo', cast(sum(funsalario) as signed) 'Totais'
from funcionario
inner join bairro on baicodigo = funbaicodigo
group by bainome, funsexo;

-- 40 
select concat(substring(fundtdem, 9, 2), '/', substring(fundtdem, 6, 2), '/',
SUBSTRING(fundtdem, 1, 4))fundtdem
from funcionario
where fundtdem is not null;

-- 42
select pronome 
from produto 
where procodigo not in(select itvprocodigo
						from itemvenda);
                                                                      
-- 43
select left(clinome,locate(' ',clinome)-1)'primeiro',count(left(clinome,locate(clinome,' ')-1))'primeiro_nome' 
from cliente
group by primeiro
having primeiro_nome > 1
order by primeiro_nome desc; 


-- 44
select extcli.clinome,vendata 
from cliente extcli
inner join venda on clicodigo = venclicodigo
where vendata = (select min(vendata) 
				 from cliente intcli
				 inner join venda on clicodigo = venclicodigo
				 where intcli.clicodigo = extcli.clicodigo
                 )limit 10;


