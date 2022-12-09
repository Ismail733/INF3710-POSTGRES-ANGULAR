create table if not exists Client (
    numeroclient SERIAL not NULL,
    nomclient VARCHAR(20) not NULL, 
    prenomclient varchar(20) not NULL, 
    adressecourrielclient VARCHAR(30) not null,
	rueclient VARCHAR(30) not null,
	villeclient VARCHAR(20) not null,
	codepostalclient CHAR(6) not null,
	PRIMARY KEY (numeroclient)
);

create table if not exists Telephone (
    numerotelephone VARCHAR(15) not null CHECK (numerotelephone not like '%[^0-9]%'),
    numeroclient integer not null,
	PRIMARY KEY (numerotelephone, numeroclient),
	FOREIGN KEY (numeroclient) REFERENCES Client(numeroclient) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists Fournisseur (
    numerofournisseur SERIAL not null,
    nomfournisseur VARCHAR(20),
    adressefournisseur VARCHAR(30) not null,
	PRIMARY KEY (numerofournisseur)
);

create table if not exists Planrepas (
	numeroplan SERIAL not null,
	numerofournisseur integer not null,
    categorie VARCHAR(20) not null,
    frequence integer not null check (frequence > 0),
    nbrpersonnes integer not null check (nbrpersonnes > 0),
    nbrcalories integer not null check (nbrcalories > 0),
    prix NUMERIC(7, 2) not null check (prix > 0),
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numerofournisseur) REFERENCES Fournisseur(numerofournisseur) ON UPDATE CASCADE ON DELETE CASCADE
);



create table if not exists Abonner (
	duree integer not null,
	numeroplan integer not NULL,
	numeroclient integer not null,
	PRIMARY KEY (numeroplan, numeroclient),
	FOREIGN KEY (numeroclient) REFERENCES Client(numeroclient) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (numeroplan) REFERENCES Planrepas(numeroplan) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists Famille (
	numeroplan integer not NULL,
	PRIMARY kEY (numeroplan),
    FOREIGN KEY (numeroplan) REFERENCES Planrepas(numeroplan) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists Vegetarien (
    typederepas VARCHAR(20) not null,
	numeroplan integer not NULL,
	PRIMARY KEY (numeroplan),
    FOREIGN KEY (numeroplan) REFERENCES Planrepas(numeroplan) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists Pescaterien (
    numeroplan integer not NULL, 
    typepoisson VARCHAR(20) not null,
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numeroplan) REFERENCES Planrepas(numeroplan) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists Rapide (
	numeroplan integer not NULL,
    tempsdepreparation TIME(0) not null,
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numeroplan) REFERENCES Famille(numeroplan) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists Facile (
	numeroplan integer not NULL,
    nbringredients integer not null,
	PRIMARY KEY (numeroplan),
	FOREIGN KEY (numeroplan) REFERENCES Famille(numeroplan) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists Kitrepas (
	numeroplan integer not NULL,
    numerokitrepas SERIAL not null, 
    description VARCHAR(300) not null,
	PRIMARY KEY (numerokitrepas),
	FOREIGN KEY (numeroplan) REFERENCES Planrepas(numeroplan) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists Image (
    numeroimage SERIAL not null,
    donnees VARCHAR(1250) not null, 
	numerokitrepas integer not null,
	PRIMARY KEY (numeroimage),
	FOREIGN KEY (numerokitrepas) REFERENCES Kitrepas(numerokitrepas) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists Ingredient (
    numeroingredient SERIAL not null,
    nomingredient VARCHAR(20) not null,
    paysingredient VARCHAR(20) not null,
	PRIMARY KEY (numeroingredient)
);

create table if not exists Contenir (
	numeroingredient integer not null,
	numerokitrepas integer not null,
	PRIMARY KEY (numerokitrepas, numeroingredient),
	FOREIGN KEY (numerokitrepas) REFERENCES Kitrepas(numerokitrepas) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (numeroingredient) REFERENCES Ingredient(numeroingredient) ON UPDATE CASCADE ON DELETE CASCADE
);

create table if not exists etape (
	numeroetape integer not null check (numeroetape > 0),
	numerosousetape integer not null check (numerosousetape > 0),
	numerokitrepas integer not null check (numerokitrepas > 0),
	descriptionetape VARCHAR(750) not null,
    dureeetape TIME(0) not null,
	PRIMARY KEY (numerokitrepas, numeroetape, numerosousetape),
	FOREIGN KEY (numerokitrepas) REFERENCES Kitrepas(numerokitrepas) ON UPDATE CASCADE ON DELETE CASCADE
);


insert into client (prenomclient, nomclient, adressecourrielclient, rueclient, villeclient, codepostalclient)
VALUES ('ahmed', 'zghal', 'ahmed.zghal@gmtayo.com', 'rue tanouka', 'laval', 'h6t7r9');

insert into client (prenomclient, nomclient, adressecourrielclient, rueclient, villeclient, codepostalclient)
VALUES ('luffy', 'monkey', 'luffy.monkey@gmtayo.com', 'rue fuschia', 'eastblue', 'j0u6t3');

insert into client (prenomclient, nomclient, adressecourrielclient, rueclient, villeclient, codepostalclient)
VALUES ('zoro', 'roronoa', 'zoro.roronoa@gmtayo.com', 'boulevard mihawk', 'rabat', 'h2s0k8');

insert into client (prenomclient, nomclient, adressecourrielclient, rueclient, villeclient, codepostalclient)
VALUES ('nami', 'clara', 'nami.clara@gmtayo.com', 'avenue ducharme', 'rabat', 't2j4m7');

insert into client (prenomclient, nomclient, adressecourrielclient, rueclient, villeclient, codepostalclient)
VALUES ('ismtayo', 'du-matin', 'ismtayo.du-matin@gmtayo.com', 'rue ismaempire', 'ismaville', 'h3s9f3');


insert into telephone (numeroclient, numerotelephone)
VALUES ((select numeroclient from client where (prenomclient = 'ahmed' and nomclient = 'zghal')), '15142344657');

insert into telephone (numeroclient, numerotelephone)
VALUES ((select numeroclient from client where (prenomclient = 'luffy' and nomclient = 'monkey')), '15146897523');

insert into telephone (numeroclient, numerotelephone)
VALUES ((select numeroclient from client where (prenomclient = 'zoro' and nomclient = 'roronoa')), '15148975642');

insert into telephone (numeroclient, numerotelephone)
VALUES ((select numeroclient from client where (prenomclient = 'nami' and nomclient = 'clara')), '15146698877');

insert into telephone (numeroclient, numerotelephone)
VALUES ((select numeroclient from client where (prenomclient = 'ismtayo' and nomclient = 'du-matin')), '15148657423');


insert into fournisseur (nomfournisseur, adressefournisseur) 
VALUES ('QC Transport', 'rabat');

insert into fournisseur (nomfournisseur, adressefournisseur) 
VALUES ('AB Transport', 'rabat');

insert into fournisseur (nomfournisseur, adressefournisseur) 
VALUES ('Benjamin', 'rabat');

insert into fournisseur (adressefournisseur) 
VALUES ('rabat');

insert into fournisseur (adressefournisseur) 
VALUES ('dorval');


insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('cétogène', 3, 2700, 4, 54, (select numerofournisseur from fournisseur where (nomfournisseur = 'QC Transport')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('cétogène', 2, 2000, 2, 54, (select numerofournisseur from fournisseur where (nomfournisseur = 'Benjamin')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('cétogène', 1, 700, 2, 26, (select numerofournisseur from fournisseur where (nomfournisseur = 'QC Transport')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('carnivore', 3, 2400, 3, 49, (select numerofournisseur from fournisseur where (nomfournisseur = 'Benjamin')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('carnivore', 3, 2400, 3, 18, (select numerofournisseur from fournisseur where (nomfournisseur = 'QC Transport')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('carnivore', 1, 400, 2, 55, (select numerofournisseur from fournisseur where (nomfournisseur = 'Benjamin')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('parmesan', 3, 2400, 3, 49, (select numerofournisseur from fournisseur where (nomfournisseur = 'AB Transport')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('parmesan', 2, 2200, 4, 28, (select numerofournisseur from fournisseur where (nomfournisseur = 'Benjamin')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('indien', 2, 2200, 4, 28, (select numerofournisseur from fournisseur where (adressefournisseur = 'rabat' and nomfournisseur is null)));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('indien', 3, 5260, 3, 42, (select numerofournisseur from fournisseur where (nomfournisseur = 'AB Transport')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('carnivore', 3, 2400, 3, 20000, (select numerofournisseur from fournisseur where (nomfournisseur = 'Benjamin')));

insert into planrepas (categorie, frequence, nbrcalories, nbrpersonnes, prix, numerofournisseur)
VALUES ('herbivore', 3, 2400, 3, 25000, (select numerofournisseur from fournisseur where (nomfournisseur = 'QC Transport')));


insert into Famille (numeroplan)
VALUES ((select numeroplan from planrepas where (categorie = 'cétogène' and nbrcalories = 2700 and prix = 54)));

insert into Famille (numeroplan)
VALUES ((select numeroplan from planrepas where (categorie = 'cétogène' and nbrcalories = 2000 and prix = 54)));

insert into Famille (numeroplan)
VALUES ((select numeroplan from planrepas where (categorie = 'carnivore' and nbrcalories = 2400 and prix = 49)));

insert into Famille (numeroplan)
VALUES ((select numeroplan from planrepas where (categorie = 'carnivore' and nbrcalories = 2400 and prix = 18)));


insert into Vegetarien (numeroplan, typederepas)
VALUES ((select numeroplan from planrepas where (categorie = 'cétogène' and nbrcalories = 700 and prix = 26)), 'trash');

insert into Vegetarien (numeroplan, typederepas)
VALUES ((select numeroplan from planrepas where (categorie = 'parmesan' and nbrcalories = 2400 and prix = 49)), 'ordinaire');


insert into Pescaterien (numeroplan, typepoisson)
VALUES ((select numeroplan from planrepas where (categorie = 'parmesan' and nbrcalories = 2400 and prix = 49)), 'saumon');

insert into Pescaterien (numeroplan, typepoisson)
VALUES ((select numeroplan from planrepas where (categorie = 'parmesan' and nbrcalories = 2200 and prix = 28)), 'truite');


insert into rapide (numeroplan, tempsdepreparation)
VALUES ((select numeroplan from famille where numeroplan in 
(select numeroplan from planrepas where (categorie = 'cétogène' and nbrcalories = 2700 and prix = 54))), '00:12:30');

insert into rapide (numeroplan, tempsdepreparation)
VALUES ((select numeroplan from famille where numeroplan in 
(select numeroplan from planrepas where (categorie = 'cétogène' and nbrcalories = 2000 and prix = 54))), '00:11:00');


insert into facile (numeroplan, nbringredients)
VALUES ((select numeroplan from famille where numeroplan in 
(select numeroplan from planrepas where (categorie = 'carnivore' and nbrcalories = 2400 and prix = 49))), 5);

insert into facile (numeroplan, nbringredients)
VALUES ((select numeroplan from famille where numeroplan in 
(select numeroplan from planrepas where (categorie = 'carnivore' and nbrcalories = 2400 and prix = 18))), 6);


insert into Kitrepas (numeroplan, description)
VALUES ((select numeroplan from planrepas where (categorie = 'indien' and nbrcalories = 2200 and prix = 28)), 'tu va en mordre tes doigts !');

insert into Kitrepas (numeroplan, description)
VALUES ((select numeroplan from planrepas where (categorie = 'indien' and nbrcalories = 5260 and prix = 42)), 'la viande est bonne pour la santé, mangez autant que possible les amis.');


insert into Image (donnees, numerokitrepas)
VALUES ('Taking responsibility - practicing 100 percent responsibility every day.',
(select numerokitrepas from Kitrepas where description = 'tu va en mordre tes doigts !'));

insert into Image (donnees, numerokitrepas)
VALUES ('quel ruine est tombé sur nous pauvre innocent malbarré',
(select numerokitrepas from Kitrepas where description = 'la viande est bonne pour la santé, mangez autant que possible les amis.'));


insert into ingredient (nomingredient, paysingredient) 
VALUES ('goberge', 'maroc');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('pieuvre', 'maroc');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('tayo', 'bresil');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('oignon', 'maroc');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('poivron', 'espagne');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('pomme', 'maroc');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('truie', 'maroc');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('olives', 'syrie');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('cornichon', 'japon');

insert into ingredient (nomingredient, paysingredient) 
VALUES ('live', 'espagne');


insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'goberge' and paysingredient = 'maroc')), 
(select numerokitrepas from Kitrepas where description = 'la viande est bonne pour la santé, mangez autant que possible les amis.'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'pieuvre' and paysingredient = 'maroc')), 
(select numerokitrepas from Kitrepas where description = 'la viande est bonne pour la santé, mangez autant que possible les amis.'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'tayo' and paysingredient = 'bresil')), 
(select numerokitrepas from Kitrepas where description = 'la viande est bonne pour la santé, mangez autant que possible les amis.'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'oignon' and paysingredient = 'maroc')), 
(select numerokitrepas from Kitrepas where description = 'la viande est bonne pour la santé, mangez autant que possible les amis.'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'olives' and paysingredient = 'syrie')), 
(select numerokitrepas from Kitrepas where description = 'la viande est bonne pour la santé, mangez autant que possible les amis.'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'poivron' and paysingredient = 'espagne')), 
(select numerokitrepas from Kitrepas where description = 'la viande est bonne pour la santé, mangez autant que possible les amis.'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'goberge' and paysingredient = 'maroc')), 
(select numerokitrepas from Kitrepas where description = 'tu va en mordre tes doigts !'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'oignon' and paysingredient = 'maroc')), 
(select numerokitrepas from Kitrepas where description = 'tu va en mordre tes doigts !'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'cornichon' and paysingredient = 'japon')), 
(select numerokitrepas from Kitrepas where description = 'tu va en mordre tes doigts !'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'truie' and paysingredient = 'maroc')), 
(select numerokitrepas from Kitrepas where description = 'tu va en mordre tes doigts !'));

insert into Contenir (numeroingredient, numerokitrepas)
VALUES ((select numeroingredient from ingredient where (nomingredient = 'pomme' and paysingredient = 'maroc')), 
(select numerokitrepas from Kitrepas where description = 'tu va en mordre tes doigts !'));


insert into etape (numeroetape, numerosousetape, numerokitrepas, descriptionetape, dureeetape)
VALUES (1, 1, (select numerokitrepas from Kitrepas where description = 'la viande est bonne pour la santé, mangez autant que possible les amis.'), 'Hacher les oignons, l''tayo, goberges et le poivron.', '00:10:45');

insert into etape (numeroetape, numerosousetape, numerokitrepas, descriptionetape, dureeetape)
VALUES (2, 1, (select numerokitrepas from Kitrepas where description = 'la viande est bonne pour la santé, mangez autant que possible les amis.'), 'Faire revenir les oignons et le boeuf.', '00:5:30');

insert into Abonner (duree, numeroplan, numeroclient)
VALUES (20, 
(select numeroplan from planrepas where (categorie = 'parmesan' and prix = 28)), 
(select numeroclient from client where (prenomclient = 'luffy' and nomclient = 'monkey')));

