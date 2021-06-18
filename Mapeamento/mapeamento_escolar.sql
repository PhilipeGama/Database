create database mapeamento_escola;

use mapeamento_escola;

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
conesccnpj char(18),
conprofcpf char(14),
condtinicio date not null,
condtfim date,
condtregistroconselho date,
concnscnpj char(18) not null,
primary key(conesccnpj,conprofcpf,condtinicio),
foreign key(conesccnpj) references escola(esccnpj),
foreign key(conprofcpf) references professor(procpf),
foreign key(concnscnpj) references conselho(cnscnpj)  
);

create table temporario(
temprocpf char(14) not null,
primary key(temprocpf),
foreign key(temprocpf) references professor(procpf)
);

create table estatutario(
estprocpf char(14) not null,
primary key(estprocpf),
foreign key(estprocpf) references professor(procpf)
);



create table projeto(
prjsigla char(3) not null,
prjdescricao varchar(100) not null,
primary key(prjsigla)
);

create table atendimento(
ateestprocpf char(14) not null,
ateprjsigla char(3) not null,
atedata date not null,
primary key(ateestprocpf,ateprjsigla),
foreign key(ateestprocpf) references estatutario(estprocpf),
foreign key(ateprjsigla) references projeto(prjsigla)
);

create table coordenador(
cooestprocpf char(14) not null,
primary key(cooestprocpf),
foreign key(cooestprocpf) references estatutario(estprocpf)
);

create table gerencia(
gercooestprocpf char(14) not null,
gertemprocpf char(14) not null,
gerdtinicio date not null,
gerdtfim date,
primary key(gercooestprocpf,gertemprocpf,gerdtinicio),
foreign key(gercooestprocpf) references coordenador(cooestprocpf),
foreign key(gertemprocpf) references temporario(temprocpf)
);

create table produto(
prdsigla char(3) not null,
prdvalor decimal(9,3) not null,
primary key(prdsigla)
);

create table publicacao(
impprjsigla char(3) not null,
impprdsigla char(3) not null,
impdtinicio date not null,
impdtfim date,
impvalor decimal(9,2),
impcooestprocpf char(14) not null,
primary key(impprjsigla,impprdsigla,impcooestprocpf),
foreign key(impprjsigla) references projeto(prjsigla),
foreign key(impprdsigla) references produto(prdsigla),
foreign key(impcooestprocpf) references coordenador(cooestprocpf) 
);













