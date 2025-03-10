DROP DATABASE IF EXISTS participants;
CREATE DATABASE participants;
#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------
USE participants;

#------------------------------------------------------------
# Table: civilite
#------------------------------------------------------------

CREATE TABLE civilite(
    id_civilite   Int  Auto_increment  NOT NULL ,
    libelle_long  Varchar (250) NOT NULL ,
    libelle_court Varchar (10) NOT NULL,
    CONSTRAINT PK_civilite PRIMARY KEY (id_civilite)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: pays
#------------------------------------------------------------

CREATE TABLE pays(
    id_pays Int  Auto_increment  NOT NULL ,
    code    Varchar (5) NOT NULL ,
    nom     Varchar (150) NOT NULL,
    CONSTRAINT PK_pays PRIMARY KEY (id_pays)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: cp_ville
#------------------------------------------------------------

CREATE TABLE cp_ville(
    id_cpville Int  Auto_increment  NOT NULL ,
    codepostal Char (5) NOT NULL ,
    ville      Varchar (150) NOT NULL ,
    id_pays    Int NOT NULL,
    CONSTRAINT PK_cp_ville PRIMARY KEY (id_cpville),
    CONSTRAINT FK_cp_ville_pays0 FOREIGN KEY (id_pays) REFERENCES pays(id_pays)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: fonction
#------------------------------------------------------------

CREATE TABLE fonction(
    id_fonction Int  Auto_increment  NOT NULL ,
    libelle     Varchar (50) NOT NULL,
    CONSTRAINT PK_fonction PRIMARY KEY (id_fonction)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: societe
#------------------------------------------------------------

CREATE TABLE societe(
    siret Varchar (20) NOT NULL ,
    nom   Varchar (150) NOT NULL,
    CONSTRAINT PK_societe PRIMARY KEY (siret)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: titre
#------------------------------------------------------------

CREATE TABLE titre(
    id_titre Int  Auto_increment  NOT NULL ,
    libelle  Varchar (50) NOT NULL ,
    niveau   Varchar (50) NOT NULL,
    CONSTRAINT PK_titre PRIMARY KEY (id_titre)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: formation
#------------------------------------------------------------

CREATE TABLE formation(
    id_formation Int  Auto_increment  NOT NULL ,
    libelle      Varchar (200) NOT NULL ,
    id_titre     Int NOT NULL,
    CONSTRAINT PK_formation PRIMARY KEY (id_formation),
	CONSTRAINT FK_formation_titre0 FOREIGN KEY (id_titre) REFERENCES titre(id_titre)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: participant
#------------------------------------------------------------

CREATE TABLE participant(
    id_participant Int  Auto_increment  NOT NULL ,
    nom            Varchar (50) NOT NULL ,
    prenom         Varchar (50) NOT NULL ,
    date_naissance Date NOT NULL ,
    adresse1       Varchar (250) NOT NULL ,
    adresse2       Varchar (250) ,
    date_debut     Date NOT NULL ,
    date_fin       Date NOT NULL ,
    date_obtention Date ,
    id_civilite    Int NOT NULL ,
    id_cpville     Int NOT NULL ,
    id_formation   Int NOT NULL	,
    CONSTRAINT PK_participant PRIMARY KEY (id_participant),
	CONSTRAINT FK_participant_civilite0	FOREIGN KEY (id_civilite) REFERENCES civilite(id_civilite),
	CONSTRAINT FK_participant_cp_ville1	FOREIGN KEY (id_cpville) REFERENCES cp_ville(id_cpville),
	CONSTRAINT FK_participant_formation2 FOREIGN KEY (id_formation) REFERENCES formation(id_formation)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: email
#------------------------------------------------------------

CREATE TABLE email(
    id_email       Int  Auto_increment  NOT NULL ,
    adresse        Varchar (10) NOT NULL ,
    id_participant Int NOT NULL,
    CONSTRAINT PK_email PRIMARY KEY (id_email),	
    CONSTRAINT FK_email_participant0 FOREIGN KEY (id_participant) REFERENCES participant(id_participant)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: travailler
#------------------------------------------------------------

CREATE TABLE travailler(
    id_participant    Int NOT NULL ,
    id_fonction       Int NOT NULL ,
    siret             Varchar (20) NOT NULL ,
    date_debutcontrat Date NOT NULL ,
    date_fincontrat   Date,
    CONSTRAINT PK_travailler PRIMARY KEY (id_participant,id_fonction,siret),
	CONSTRAINT FK_travailler_participant0 FOREIGN KEY (id_participant) REFERENCES participant(id_participant),
	CONSTRAINT FK_travailler_fonction1 FOREIGN KEY (id_fonction) REFERENCES fonction(id_fonction),
	CONSTRAINT FK_travailler_societe2 FOREIGN KEY (siret) REFERENCES societe(siret)
)ENGINE=InnoDB;

#------------------------------------------------------------
# Table: categorie
#------------------------------------------------------------

CREATE TABLE categorie(
	id_categorie         Int  Auto_increment  NOT NULL ,
	libelle              Varchar (50) NOT NULL ,
	id_categorie_estmere Int,
	CONSTRAINT PK_categorie PRIMARY KEY (id_categorie),
	CONSTRAINT FK_categorie_categorie0 FOREIGN KEY (id_categorie_estmere) REFERENCES categorie(id_categorie)
)ENGINE=InnoDB;

#------------------------------------------------------------
# Table: module
#------------------------------------------------------------

CREATE TABLE module(
    id_module    Int  Auto_increment  NOT NULL ,
    code         Varchar (10) NOT NULL ,
    libelle      Varchar (250) NOT NULL ,
    description  Text ,
    id_categorie Int NOT NULL,
    CONSTRAINT PK_module PRIMARY KEY (id_module),
	CONSTRAINT FK_module_categorie0 FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie)
)ENGINE=InnoDB;



#------------------------------------------------------------
# Table: attribuer
#------------------------------------------------------------

CREATE TABLE attribuer(
    id_participant Int NOT NULL ,
    id_module      Int NOT NULL ,
    note           Float NOT NULL ,
    date_attribution Date NOT NULL,
    CONSTRAINT PK_attribuer PRIMARY KEY (id_participant,id_module),
	CONSTRAINT FK_attribuer_participant0 FOREIGN KEY (id_participant) REFERENCES participant(id_participant),
	CONSTRAINT FK_attribuer_module1 FOREIGN KEY (id_module) REFERENCES module(id_module)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: correspondre
#------------------------------------------------------------

CREATE TABLE correspondre(
    id_module    Int NOT NULL ,
    id_formation Int NOT NULL ,
    coefficient  Int NOT NULL,
    CONSTRAINT PK_correspondre PRIMARY KEY (id_module,id_formation),
	CONSTRAINT FK_correspondre_module0 FOREIGN KEY (id_module) REFERENCES module(id_module),
	CONSTRAINT FK_correspondre_formation1 FOREIGN KEY (id_formation) REFERENCES formation(id_formation)
)ENGINE=InnoDB;



	
