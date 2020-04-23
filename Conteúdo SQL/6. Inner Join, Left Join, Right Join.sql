-- auto relacionamento
select ger.funcodigo 'gerente cod', ger.funnome 'ger nome', sub.funcodigo 'funcionario cod', sub.funnome 'funcionario nome'
from funcionario ger
inner join funcionario sub on ger.funcodigo = sub.funcodgerente
order by ger.funnome;

select bainome
from cliente
inner join bairro on baicodigo = clibaicodigo;



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
