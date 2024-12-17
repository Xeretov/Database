CREATE TYPE Dir AS ENUM(
    'in','out'
);

CREATE DOMAIN Str_Not_Null AS VARCHAR(255) NOT NULL;
CREATE DOMAIN Str16_Not_Null AS VARCHAR(16) NOT NULL;
CREATE DOMAIN Int_Not_Null AS INTEGER NOT NULL;
CREATE DOMAIN Pos_Int_Not_Null AS INTEGER NOT NULL CHECK (value > 0);

CREATE TABLE Socio(
    cf Str16_Not_Null,
    nome Str_Not_Null,
    cognome Str_Not_Null,
    primary key (cf)
);

CREATE TABLE Accesso(
    inizio TimeStamp,
    direzione Dir,
    id serial not null,
    socio Str16_Not_Null,
    varco Int_Not_Null,
    primary key (id)
    foreign key (socio) references Socio(cf),
    foreign key (varco) references Varco(codice)
);

CREATE TABLE Varco(
    codice Int_Not_Null,
    primary key(codice)
);

CREATE TABLE Zona(
    nome Str_Not_Null,
    capienza Pos_Int_Not_Null
);

CREATE TABLE raggiunge(
    id serial not null,
    direzione Dir,
    zona Str_Not_Null,
    varco Int_Not_Null,
    primary key (id),
    foreign key (varco) references Varco(codice),
    foreign key (zona) references Zona(nome)
);