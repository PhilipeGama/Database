use map1;

select *from cliente;

select clinome,clirendamensal,bainome from cliente
inner join bairro on baicodigo = clibaicodigo
order by clirendamensal desc,clinome;

select clinome 'Nome',clirendamensal'Renda Mensal',bainome'Bairro',estdescricao'Estado Cívil' 
from cliente
inner join bairro on baicodigo = clibaicodigo
inner join estadocivil on cliestcodigo = estcodigo
where estdescricao in ('Solteiro','Casado','Divorciado');

select *from cliente
inner join bairro on baicodigo = clibaicodigo
where clinome like '%a';
 

