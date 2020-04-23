-- Subconsulta

select bainome
from bairro
where baicodigo in (select clibaicodigo from cliente);

select clinome,clirendamensal from cliente
where clirendamensal = (select min(clirendamensal) from cliente);

/*
1) Mostre os nomes dos produtos, e de seus grupos somente 
para os ativos e que tenham valor acima da media dos valores(preço) dos produtos


2) Mostre os nomes dos produtos:
a)Mais vendidos
b)Menos vendidos
 

3) Mostre os nomes dos clientes que tiveream a {a)Maior b)menor}

*/
 
 


-- menor renda dos clientes
 
select clinome 'cliente', clirendamensal 'renda' from cliente

where clirendamensal = (select min(clirendamensal) from cliente); 



-- nome dos clientes com 5 menores renda - subconsulta aninhada 
select clinome 'cliente', clirendamensal 'renda' from cliente
where clirendamensal in (select clirendamensal from 
												(select distinct clirendamensal from cliente
												where clirendamensal is not null
												order by clirendamensal
												limit 5)c1                    
						);




-- subconsulta
select clinome,clirendamensal from (select clinome, clirendamensal from cliente where clirendamensal < 1000) c1;


-- questão 13
select pronome 'produto', propreco 'preço' from produto
where propreco >= (select avg(propreco) from produto);

select grpdescricao 'Media' from produto
inner join grupoproduto on grpcodigo = progrpcodigo
group by grpdescricao
having avg(propreco) = (select avg(propreco) from produto
						inner join grupoproduto on grpcodigo = progrpcodigo
                        group by grpdescricao
                        order by avg(propreco) desc
                        limit 1
                        );

 
 

 






      
