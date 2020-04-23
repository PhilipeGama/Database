show databases;
use bd201901;

-- 1. Mostre os nomes dos produtos vendidos e para cada um deles, a respectiva data da última venda.
select procodigo,pronome,ven1.vendata from produto
inner join itemvenda itv1 on procodigo = itv1.itvprocodigo
inner join venda ven1 on ven1.vencodigo = itv1.itvvencodigo
where ven1.vendata = (select max(ven2.vendata) from venda ven2
					  inner join itemvenda itv2 on ven2.vencodigo = itv2.itvvencodigo	
                      			  where procodigo = itv2.itvprocodigo);

-- 2. Mostre os últimos nomes dos clientes que forem solteiros ou divorciados, assim como os nomes de
-- seus bairros. Ex: Para o cliente “João da Silva”, o resultado será “Silva”.		
select clinome,bainome, 
right(clinome, locate(' ', reverse(clinome)) -1) 'Ultimo Nome'
from cliente 
inner join estadocivil on estcodigo = cliestcodigo
inner join bairro on baicodigo = clibaicodigo
where estdescricao in('solteiro','divorciado');

-- 3. Mostre os nomes dos funcionários e seus estados civis, para os que estejam entre os 3 que mais
-- venderam, baseado no número de vendas realizadas por cada.
select funnome,estdescricao,count(vencodigo) from funcionario 
inner join venda on funcodigo = venfuncodigo
inner join estadocivil on estcodigo = funestcodigo
group by funcodigo 
limit 3;           

-- 4. Mostre os nomes das zonas que não tenham clientes associados a seus bairros.                        
select zonnome,baicodigo from bairro
inner join zona on zoncodigo = baizoncodigo
where baicodigo not in(select clibaicodigo from cliente  where clibaicodigo is not null);                        



-- 5. Mostre os nomes dos gerentes que tenham menos de 3 subordinados e sejam solteiros ou casados
select distinct(ger.funnome),ger.funcodigo,count(*) from funcionario ger
inner join funcionario sub on ger.funcodigo = sub.funcodgerente
inner join estadocivil on estcodigo = ger.funestcodigo
where estdescricao in('solteiro','casado')
group by ger.funnome
having count(*) < 3;

-- 6. Mostre os nomes dos funcionários que não são gerentes.
select funcodigo from funcionario where funcodigo not in(
select funcodigo from funcionario
where funcodigo in(select funcodgerente from funcionario)) order by funcodigo; 


/* 
7 Mostre os primeiros nomes dos clientes que tiverem a maior quantidade de caracteres em seus nomes
completos, seus sexos e estados civis. A resposta deverá sair FORMATADA conforme exemplo
abaixo:
O cliente XYZW possui 35 caracteres no seu nome, sexo M e é Casado.
*/
select concat('O cliente ',clinome,' possui ',length(clinome),' caracteres em seu nome, sexo ',clisexo,'e é ',estdescricao)'cliente'
from cliente
inner join estadocivil on estcodigo = cliestcodigo;

-- 8. Sem a utilização de Like, mostre os nomes dos produtos que tiverem as strings “DA”, “MA” ou “CA” em qualquer parte do nome.
select locate('DA',pronome) loc,locate('MA',pronome) loc2,locate('CA',pronome) loc3,pronome from produto
where locate('DA',pronome) or locate('MA',pronome) or locate('CA',pronome) ;

-- 9 Para todos os funcionários demitidos, mostre as suas datas de demissão no formado DIA/MÊS/ANO. 
select funnome'Nome',date_format(fundtdem,'%d/%m/%Y')'Data de Demissão'from funcionario
where fundtdem is not null;



-- 10. Mostre os totais de salários por bairro e sexo, retornando para os valores somente a parte inteira, ou
-- seja, eliminando do resultado as casas decimais.
select left(funsalario,locate('.',funsalario) -1) 'loc',bainome,funsexo from funcionario
inner join bairro on baicodigo = funbaicodigo
group by baicodigo,funsexo;

-- 11. Mostre os nomes dos produtos que não foram vendidos.
select pronome 
from produto 
where procodigo not in(select itvprocodigo
						from itemvenda);
                                                
                        
-- 12. Faça um ranking de número de ocorrências de cada PRIMEIRO NOME dos clientes.
select left(clinome,locate(' ',clinome)-1)'Primerio',count(left(clinome,locate(clinome,' ')-1))'primeiro_nome' 
from cliente
group by clinome
having primeiro_nome > 1
order by primeiro_nome desc; 


-- 13. Mostre os nomes dos clientes que tenham gerado as 10 primeiras vendas
select clinome,vendata,count(*) 
from cliente
inner join venda on clicodigo = venclicodigo
group by clinome
having count(*) > 1
order by vendata
limit 10;


