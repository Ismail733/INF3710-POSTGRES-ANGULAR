-- 4.1
select numeroclient, nomclient 
from client 
where client.numeroclient in 
(select numeroclient from abonner where abonner.numeroplan in 
 (select numeroplan from planrepas where prix between 20.00 and 40.00));

-- 4.2
select numeroplan from planrepas
where planrepas.numerofournisseur not in 
(select numerofournisseur from fournisseur where fournisseur.nomfournisseur ='QC Transport' );

-- 4.3
select F.numeroplan from famille F, planrepas P 
where P.categorie = 'cétogène' and P.numeroplan = F.numeroplan;

-- 4.4
select count(*) as "fournisseur qui ne possede pas de nom" from Fournisseur 
where nomfournisseur is null;


-- 4.5
select nomfournisseur
from planrepas inner join fournisseur 
on planrepas.numerofournisseur = fournisseur.numerofournisseur
where prix > (select max(prix)
from planrepas inner join fournisseur
on planrepas.numerofournisseur = fournisseur.numerofournisseur
where nomfournisseur = 'AB Transport')
group by nomfournisseur;

select f.nomfournisseur from fournisseur f, planrepas p
where p.numerofournisseur = f.numerofournisseur
and p.prix > ALL(select prix from fournisseur f1, planrepas p1
                where p1.numerofournisseur = f1.numerofournisseur
                and f1.nomfournisseur = 'AB Transport');


-- 4.6
select nomfournisseur, adressefournisseur, sum(prix) as "Somme des prix"
from planrepas inner join fournisseur 
on planrepas.numerofournisseur = fournisseur.numerofournisseur
where fournisseur.numerofournisseur
in (select fournisseur.numerofournisseur
from planrepas inner join fournisseur
on planrepas.numerofournisseur = fournisseur.numerofournisseur
order by prix desc limit 2)
group by fournisseur.numerofournisseur;

-- 4.7
select count() as "nombre de kit repas jamais réservés chez les fournisseurs" 
from kitrepas 
where numerokitrepas not in 
(select numerokitrepas 
 from abonner inner join kitrepas 
 on abonner.numeroplan = kitrepas.numeroplan);


-- 4.8
select numeroclient, nomclient, prenomclient from client
where left(prenomclient, 1) not in ('a', 'e', 'i', 'o', 'u', 'y')
and villeclient = (select adressefournisseur from fournisseur 
where nomfournisseur = 'Benjamin')
order by nomclient asc;

-- 4.9
select paysingredient, count(*) as "nombre des ingrédients par pays" 
from ingredient 
where left(right(paysingredient, 3), 1) <> 'g'
group by paysingredient
order by paysingredient desc;

-- 4.10
CREATE VIEW V_fournisseur(V_categorie, V_adresse, V_tot) as
SELECT p.categorie, f.adressefournisseur, SUM(p.prix) from planrepas p, fournisseur f
where p.categorie LIKE '%e%' and p.categorie LIKE '%o__'
and p.numerofournisseur = f.numerofournisseur
and p.numerofournisseur in (select numerofournisseur from planrepas
                         group by numerofournisseur
                         having SUM(prix) > 12500)
group by  p.categorie, f.adressefournisseur
order by p.categorie, SUM(p.prix) DESC;


