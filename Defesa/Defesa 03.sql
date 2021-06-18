-- 1
select distinct pronome from produto 
inner join itemvenda on procodigo = itvprocodigo
inner join venda on vencodigo = itvvencodigo
inner join cliente on clicodigo = venclicodigo
inner join bairro on baicodigo = clibaicodigo
where propreco > 700 and pronome like '%a%' and bainome = 'Educandos'; 


-- 2
select pronome from grupoproduto
inner join produto on grpcodigo = progrpcodigo
where grpcomissao = (
					select min(grpcomissao) from grupoproduto);
  
-- 3 façam um ranking do valor total de vendas por data
select sum(itvqtde*propreco)'valor total de vendas por data',vendata from venda
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
group by vendata
order by sum(itvqtde*propreco) desc;
  
-- 4
select pronome from produto
inner join fornecedor on forcnpj = proforcnpj
inner join cidade on cidcodigo = forcidcodigo
where propreco > 1000 and cidnome not in('Manaus','Porto Velho')
order by pronome;
                    
                    
                    
        
                    
