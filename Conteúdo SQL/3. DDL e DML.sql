create database map1;

use map1;

create table bairro(
baisigla char(3) not null,
bainome varchar(70) not null,
primary key(baisigla)
);

create table escola(
esccnpj char(18) not null,
escnome varchar(100) not null,
escbaisigla char(3) not null,
primary key(esccnpj),
foreign key(escbaisigla) references bairro(baisigla) 
);

create table conselho(
cnscnpj char(18),
primary key(cnscnpj)
);

create table professor(
procpf char(14) not null,
pronome varchar(80) not null,
prodtadmissao date not null,
proddtdemissao date,
primary key(procpf)
);

create table contrato(
conesccnpj char(18) not null,
conprocpf char(14) not  null,
condtinicio date not null,
condtfim date,
condtregistroconselho date,
concnscnpj char(18) not null,
primary key(conesccnpj,conprocpf,condtinicio),
foreign key(conesccnpj) references escola(esccnpj),
foreign key(conprocpf) references professor(procpf),
foreign key(concnscnpj) references conselho(cnscnpj)  
);





create table departamento(
depsigla char(5) not null,
depnome varchar(80) not null,
depdtinicio date not null,
constraint departamento_pk primary key(depsigla)
);



create table temporario(
temprofcpf char(14),
primary key(temprofcpf)

);



create table estatutario(
estprofcpf char(14) not null,
primary key(estprofcpf),
foreign key(estprofcpf) references professor(profcpf)
);

insert into bairro(procpf,pronome) values ('11111111111111111','Mario');

create table projeto(
prjsigla char(3) not null,
prjdescricao varchar(100) not null,
primary key(prjsigla)
);

create table atendimento(
ateestprofcpf char(14) not null,
ateprjsigla char(3) not null,
atedata date not null,
primary key(ateestprocpf,ateprjsigla),
foreign key(ateestprofcpf) references estatutario(estprofcpf),
foreign key(ateprjsigla) references projeto(prjsigla)
);

create table coordenador(
cooestprogcpf char(14) not null,
primary key(cooestprofcpf),
foreign key(cooestprofcpf) references estatutario(estprofcpf)
);


###### DDL ###### 

show create table contrato;
alter table professor change profcpf profcpf char(15);
alter table contrato drop foreign key contrato_ibfk_2;
alter table professor change procpf procpf char(15);
alter table contrato add foreign key(conprocpf) references professor(procpf); 
alter table contrato change condtfim condtfim date not null;


alter table contrato add conteste char(100);
alter  table contrato modify conteste varchar(100) not null;
alter table professor drop foreign key professor_ibfk_1;
drop table departamento;

alter table professor add constraint professor_departamento_fk foreign key(prodepsigla) references departamento(depsigla);

show create table professor;

###### DML ###### 
insert into bairro 
		values
			('CAC','Cachoeirinha'),
            ('P10','Parque 10'),
            ('CHA','Chapada'),
            ('SJ1','São José I'),
            ('ALV','Alvorada'),
            ('CDN','Cidade Nova');
											
desc escola;
insert into escola 
			values
				('11.111.111/1111-11','Escola teste A','ALV'),
				('22.222.222/2222-22','Escola teste B','ALV'),
                ('33.333.333/3333-33','Escola teste C','CHA');
                
insert into professor
			values
				('111.111.111-11','Professor teste 1','2019-05-03',NULL,NULL);
                
insert into professor(procpf,pronome,prodtadmissao)
			values
				('222.222.222-22','Professor teste 2','2019-05-03');                
insert into departamento 
			values
				('INF','Infomática','2010-04-03'),
                ('ELT','Eletrônica','2010-04-03'),
                ('QUI','Química','2010-04-03');
                
 select *from departamento;
 
 update professor set prodepsigla = 'INF'
 where procpf = '111.111.111-11';
 
 update professor set pronome = 'Professor teste dois',prodepsigla='INF';
 
 update professor set pronome = 'Professor teste 1',prodepsigla='QUI';
 
 delete from professor where procpf = '111.111.111-11';
 
 
 
 
 
 
 