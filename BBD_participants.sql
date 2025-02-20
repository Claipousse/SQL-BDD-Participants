create database bddparticipants;

use bddparticipants;

create table civilite (
	id_civilite INT not null auto_increment,
	libelle_long VARCHAR(250) not null,
	libelle_court VARCHAR(10) default null,
	constraint PK_CIV primary key (id_civilite)
) engine=InnoDB;

create table titre (
	id_titre INT not null auto_increment,
	libelle VARCHAR(50) not null,
	niveau VARCHAR(50) default null,
	constraint PK_TITRE primary key (id_titre)
) engine=InnoDB;

create table fonction (
	id_fonction INT not null auto_increment,
	libelle	VARCHAR(50) not null,
	constraint PK_FONC primary key (id_fonction)
) engine=InnoDB;

create table formation (
	id_formation INT not null auto_increment,
	libelle VARCHAR(200) not null,
	constraint PK_FORM primary key (id_formation)
) engine= InnoDB;

create table societe (
	siret VARCHAR(20) not null,
	nom VARCHAR(50) not null,
	constraint PK_SOC primary key (siret)
)engine=InnoDB;

create table email (
	id_email INT not null auto_increment,
	adresse VARCHAR(10) not null,
	constraint PK_MAIL primary key (id_email)
)engine=InnoDB;

create table pays (
	id_pays INT not null auto_increment,
	code VARCHAR(5) not null,
	nom VARCHAR(150) not null,
	constraint PK_PAYS primary key (id_pays)
)engine=InnoDB;

create table cp_ville (
	id_cpville INT not null auto_increment,
	code_postal CHAR(5) not null, #Pas varchar car nombre fixe (code postal tjr 5 char)
	ville VARCHAR(150) not null,
	id_pays INT not null,
	constraint PK_CPV primary key (id_cpville),
	constraint FK_CPV_PAYS foreign key (id_pays) references pays (id_pays)
)engine=InnoDB;

create table participant (
	id_participant INT not null auto_increment,
	nom VARCHAR(50) not null,
	prenom VARCHAR(50) not null,
	date_naissance DATE not null,
	adresse1 VARCHAR(250) not null,
	adresse2 VARCHAR(250) default null,
	id_cpville INT not null,
	id_civilite INT not null,
	id_email INT not null,
	constraint PK_PARTICIPANT primary key (id_participant),
	constraint FK_PARTICIPANT_CPVILLE foreign key (id_cpville) references cp_ville (id_cpville),
	constraint FK_PARTICIPANT_CIVILITE foreign key (id_civilite) references civilite (id_civilite),
	constraint FK_PARTICIPANT_EMAIL foreign key (id_email) references email (id_email)
)engine=InnoDB;

create table categorie (
	id_categorie INT not null auto_increment,
	libelle VARCHAR(50) not null,
	constraint PK_CATEGORIE primary key (id_categorie)
)engine=InnoDB;

create table module (
	id_module INT not null auto_increment,
	code VARCHAR(10) not null,
	libelle VARCHAR(250) not null,
	description TEXT not null,
	id_categorie INT not null,
	constraint PK_MODULE primary key (id_module),
	constraint FK_MODULE_CATEGORIE foreign key (id_categorie) references categorie (id_categorie)
)engine=InnoDB;

create table suivre (
	date_debut DATE not null,
	date_fin DATE not null,
	date_obtention DATE not null,
	id_formation INT not null,
	id_participant INT not null,
	constraint FK_FORMATION_SUIVRE foreign key (id_formation) references formation (id_formation),
	constraint FK_SUIVRE_PARTICIPANT foreign key (id_participant) references participant (id_participant)
)engine=InnoDB;

create table attribuer (
	note FLOAT (5,2) not null,
	date DATE not null,
	id_participant INT not null,
	id_module INT not null,
	constraint PK_ATTRIBUER primary key (id_participant, id_module),
	constraint FK_MODULE_ATTRIBUER foreign key (id_module) references module (id_module),
	constraint FK_ATTRIBUER_PARTICIPANT foreign key (id_participant) references participant (id_participant)
)engine=InnoDB;

create table travailler (
	date_debutcontrat DATE default null, #Si jamais l'employé est en CDD, pas besoin de date de contrat
	date_fincontrat DATE default null,
	id_participant INT not null,
	siret VARCHAR(20) not null,
	id_fonction INT not null,
	constraint PK_TRAVAILLER primary key (id_participant, siret, id_fonction),
	constraint FK_SOCIETE_TRAVAILLER foreign key (siret) references societe (siret),
	constraint FK_FONCTION_TRAVAILLER foreign key (id_fonction) references fonction (id_fonction),
	constraint FK_TRAVAILLER_PARTICIPANT foreign key (id_participant) references participant (id_participant)
)engine=InnoDB;

create table estmere (
	id_categorie_fille INT not null,
	id_categorie_mere INT not null,
	constraint FK_CATEGORIE_FILLE foreign key (id_categorie_fille) references categorie (id_categorie),
	constraint FK_CATEGORIE_MERE foreign key (id_categorie_mere) references categorie (id_categorie)
)engine=InnoDB;

create table correspondre (
	coefficient INT not null,
	id_formation INT not null,
	id_module INT not null,
	constraint PK_CORRESPONDRE primary key (id_formation, id_module),
	constraint FK_CORRESPONDRE_FORMATION foreign key (id_formation) references formation (id_formation),
	constraint FK_CORRESPONDRE_MODULE foreign key (id_module) references module (id_module)
)engine=InnoDB;

create table preparer (
    id_titre INT not null,
    id_formation INT not null,
    constraint FK_TITRE_PREPARER foreign key (id_titre) references titre (id_titre),
    constraint FK_FORMATION_PREPARER foreign key (id_formation) references formation (id_formation)
)engine=InnoDB;