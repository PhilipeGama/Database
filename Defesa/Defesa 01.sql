use bd201901;

-- minha resposta impar
select clinome,clicodigo from cliente 
where clicodigo in(
select count(vencodigo) from produto 
		inner join itemvenda on procodigo = itvprocodigo
					inner join venda on vencodigo = itvvencodigo
                    group by procodigo
                    order by count(vencodigo) desc
                    );
                    
                    
                    
-- do professor impar

select clinome,clicodigo 
from cliente
inner join venda on clicodigo = venclicodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
where procodigo = (select procodigo
					from produto
                    inner join itemvenda on procodigo = itvprocodigo
                    group by procodigo
                    having count(*) = (select count(*)
					from produto
                    inner join itemvenda on procodigo = itvprocodigo
                    group by pronome
                    order by count(*) desc
                    limit 1)); 
                    
                    
-- do professor par


select zonnome,funnome 
from zona 
inner join bairro on zoncodigo = baizoncodigo
inner join funcionario on baicodigo = funbaicodigo
where funcodigo in (
					select funcodigo
					from funcionario
					inner join venda on funcodigo = venfuncodigo
					group by funcodigo
					having count(*) = (					
										select count(*)
										from funcionario
										inner join venda on funcodigo = venfuncodigo
										group by funnome
										order by count(*)
										limit 1));                              