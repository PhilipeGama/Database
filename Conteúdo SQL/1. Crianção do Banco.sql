show databases;

drop database teste;

#criação de um BD
create database teste;

#seleciona BD
use teste;

#criação de tabela
create table bairro(
baisigla char(3) not null,
bainome varchar(70) not null,
primary key(baisigla) 
);

#criação de tabela;
create table escola(
esccnpj char(18) not null,
escnome varchar(100) not null,
escbaisigla char(3) not null,
primary key(esccnpj),
foreign key(escbaisigla) references bairro(baisigla)
);

#criação de tabela;
create table professor(
profcpf char(14) not null,
profnome varchar(70) not null,
profdtadmissao date not null,
profdtdemissao date,
primary key(profcpf)
);

create table contrato(
conesccnpj char(18) not null,
conprofcpf char(14) not null,
condtinicio date not null,
condtfim date,
primary key(conesccnpj,conprofcpf,condtinicio),
foreign key(conesccnpj) references escola(esccnpj),
foreign key(conprofcpf) references professor(profcpf)
);

create table conselho(
cnscpnj char(18) not null,
primary key(cnscpnj)
);

alter table escola 
add escbairro varchar(60);

alter table contrato
add concnscpnj char(18),
add foreign key(concnscpnj)
references conselho(cnscpnj);

alter table escola drop escbairro;



#mostrar tabela
show tables;

#descrever tabela
describe escola;



select version();