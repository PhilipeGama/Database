#Funções de manipulação de strings

#left
select clinome,left(clinome,5) from cliente;
select clinome,left(clinome,5),left(left(clinome,10),3) from cliente;

#right
select clinome,right(clinome,5) from cliente;

#substring
select clinome,substring(clinome,5) from cliente;

#locale
select clinome,locate('joao',clinome) from cliente;

#reverse
select clinome,reverse(clinome) from cliente;

#length
select clinome,length(clinome) from cliente;

#primeiro nome
select clinome'Nome', left(clinome,locate(' ',clinome)-1) 'primeiro nome' from cliente;

#cast
select clinome,cast(clinome as char) from cliente;

#convert
select clinome,cast(clinome as char) from cliente;

-- MANIPULAÇÃO DE STRINGS
select clinome,
	left(clinome, 10) lef,
    right(clinome, 10) rig,
    substring(clinome, 5) subst1,
    substring(clinome, 5, 4) subst2,
    locate('joao', clinome) loc,
    reverse(clinome),
    concat('0 cliente', clinome, 'possui débitos'),
    length(clinome)
    from cliente;

-- retorna primeiro nome
select clinome 'Nome',
	left(clinome, locate(' ', clinome) -1) 'Primeiro Nome'
    from cliente;

-- retorna ultimo nome
select clinome, left(clinome, locate(' ',clinome)) 'lastName' from cliente;
select clinome, right(clinome, locate(' ',clinome)) 'lastName' from cliente;
select clinome, locate(' ',clinome) from cliente;
select clinome, reverse(left(reverse(clinome), locate(' ',reverse(clinome)))) from cliente;
