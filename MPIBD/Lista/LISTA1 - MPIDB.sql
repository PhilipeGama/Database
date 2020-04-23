use bd201901;

-- 1. Faça as alterações solicitadas abaixo no banco de dados:

-- a) Tabela Funcionário:

alter table funcionario
add fundtnascto date,
add fundtadmissao date,
add funsexo char(1);

-- b) Tabela Venda: crie um novo campo vendtcancelamento do tipo date, para indicar as vendas
-- canceladas;

alter table venda
add vendtcancelamento date;

-- c) Crie uma nova tabela formapagamento, com os campos fpgcodigo tipo smallint sem sinal e
-- obrigatório, e fpgdescricao tipo varchar(80), obrigatório, e fpgativo do tipo boolean
-- obrigatório;

create table formapagamento(
fpgcodigo smallint unsigned not null,
fpgdescricao varchar(80) not null,
fpgativo boolean not null,
primary key(fpgcodigo)
); 

-- d) Relacione a nova tabela criada no item C com a tabela venda. Uma forma de pagamento pode
-- estar em várias vendas, mas uma venda tem somente uma forma de pagamento.

alter table venda
add venfpgcodigo smallint unsigned,
add foreign key (venfpgcodigo) references formapagamento (fpgcodigo);

-- e) Altere a tabela venda, tornando obrigatório o novo campo referente à forma de pagamento
-- (talvez seja necessário fazer primeiramente algumas da questões posteriores).


/*alter table venda
modify venfpgcodigo smallint unsigned not null;*/

-- Questão 2

-- Questão 3

select * from funcionario;

-- Para executar a atualização de dez valores simultâneos, houve a necessidade de inserir
-- valores sequenciais do mesmo sexo
 
insert into funcionario
values
('35', 'Teresa do Sorriso Aparente', null, null, null, null, null, '11', 'aa', null, null, null),
('36', 'Ophelia das Ondas', null, null, null, null, null, '22', 'bb', null, null, null),
('37', 'Miria, Fantasma', null, null, null, null, null, '33', 'cc', null, null, null),
('38', 'Noel, Tempestade', null, null, null, null, null, '44', 'dd', null, null, null),
('39', 'Irene, Espada Relâmpago', null, null, null, null, null, '55', 'ee', null, null, null),
('40', 'Roxanne do Amor e do Ódio', null, null, null, null, null, '66', 'ff', null, null, null),
('41', 'Histeria, Universal', null, null, null, null, null, '77', 'gg', null, null, null),
('42', 'Cassandra, a comedora de pó', null, null, null, null, null, '88', 'hh', null, null, null),
('43', 'Flora, Vento Cortante', null, null, null, null, null, '99', 'ii', null, null, null),
('44', 'Galatea, Olho de Deus', null, null, null, null, null, '00', 'jj', null, null, null);

-- Para então o update ser realizado

update funcionario
set funsexo = 'F'
where funcodigo >= 35 limit 10;

-- Questão 5
show create table funcionario;

select * from estadocivil;

insert into funcionario (funcodigo, funsenha, funlogin,funbaicodigo, funestcodigo)
values
('45', '111', 'Ushalabashuria', '1', '2'),
('46', '222', 'Saralacanta', '2', '1');

-- Questão 6 (Incompleta, incorreta, verificar)

select *from funcionario;

update funcionario
set funsalario = (funsalario + (funsalario*0.1))
where fundtdem is null;

-- Questão 7

update funcionario
set fundtdem = '2019-05-03'
where funcodigo = '21';

-- Questão 8 Mostre o nome, custo e saldo dos produtos ativos com saldo maior que 5, que foram comprados por
-- clientes casados e do sexo masculino.

select * from produto;
select * from cliente;

select pronome, procusto, prosaldo
from produto
inner join itemvenda on itvprocodigo = procodigo
inner join venda on vencodigo = itvvencodigo
inner join cliente on clicodigo = venclicodigo
where prosaldo > 5 and cliestcodigo = 2 and clisexo = 'M' and proativo = 1;

-- Questão 9
select*from cliente;

select clinome
from cliente
inner join venda on venclicodigo = clicodigo
inner join funcionario on funcodigo = venfuncodigo
where clisexo = 'F' and clirendamensal > 1000 and clirendamensal < 1500 and fundtdem is not null;

#9
select clinome from cliente
inner join  venda  on clicodigo = venclicodigo
inner join funcionario on venfuncodigo = funcodigo
where clisexo = 'F' and 
clirendamensal >= 1000 and clirendamensal<=1500 
and fundtdem is not null;

#10
select funnome,funsalario,zonnome funcionario from funcionario
inner join bairro on baicodigo = funbaicodigo
inner join zona on zoncodigo = baizoncodigo
where fundtadmissao is not null;

#11
select funnome,funsalario,zonnome funcionario from funcionario
inner join bairro on baicodigo = funbaicodigo
inner join zona on zoncodigo = baizoncodigo
where funnome like '%s' and fundtadmissao is null;

#12
select clinome,zonnome,estdescricao from cliente
inner join estadocivil on estcod = cliestcodigo
inner join bairro on baicodigo = clibaicodigo;

#13
select pronome from  produto
inner join fornecedor on forcnpj = proforcnpj
inner join cidade on cidcodigo = forcidcodigo
where cidnome not in('Manaus','Porto Velho','Rio branco');  

#14
select clinome from cliente
inner join bairro on baicodigo = clibaicodigo
inner join venda on clicodigo = venclicodigo
inner join produto on procodigo = venprocodigo
inner join funcionario on funcodigo = venfuncodigo
inner join estadocivil on estcodgio = funestcodigo;



#15
select grpdescricao from grupoproduto
inner join produto on grpcodigo = progrpcodigo
inner join fornecedor on forcnpj = proforcnpj
inner join cidade on cidcodigo = forcidcodigo;

#16
select vencodigo,sum(itvqtde) from venda
inner join itemvenda on vencodigo = itvvencodigo;

#17
select funnome,pronome,propreco from funcionario
inner join venda on funcodigo = venfuncodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
where funnome like '%f%' or funnome like '%u%'
order by funnome,propreco;

#18
select clinome from cliente
inner join venda on clicodigo = venclicodigo
inner join itemvenda on vencodigo = itvvencodigo
inner join produto on procodigo = itvprocodigo
inner join grupoproduto on procodigo = grpcodigo
where proativo = 1 and grpdescricao = 'InformÃ¡tica';

select *from produto;




















