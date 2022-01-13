       CREATE TABLE Autorzy
    (
          ID_Autora int NOT NULL
         ,AU_Imie varchar(40) NOT NULL
         ,AU_Nazwisko varchar(40) NOT NULL
         ,PRIMARY KEY (ID_Autora)
    );

CREATE GENERATOR GEN_AUTORZY_ID;

SET TERM ^ ;

CREATE TRIGGER TRIG_AUTORZY_GEN FOR Autorzy
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN
	IF (NEW.ID_Autora IS NULL) THEN
	NEW.ID_Autora = GEN_ID(GEN_AUTORZY_ID,1);
END^

SET TERM ; ^



    CREATE TABLE Kategoria
    (
          ID_Kategorii int NOT NULL
         ,KT_Nazwa varchar(40) NOT NULL
         ,PRIMARY KEY (ID_Kategorii)
    );

CREATE GENERATOR GEN_Kategoria_ID;

SET TERM ^ ;

CREATE TRIGGER TRIG_Kategoria_GEN FOR Kategoria
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN
	IF (NEW.ID_Kategorii IS NULL) THEN
	NEW.ID_Kategorii = GEN_ID(GEN_Kategoria_ID,1);
END^

SET TERM ; ^


   
    CREATE TABLE Ksiazki
    (
        ID_Ksiazki int NOT NULL
        ,KS_Nazwa varchar(40) NOT NULL
		,KS_ISBN varchar(13) NOT NULL
		,KS_Wydawnictwo varchar(40) NOT NULL
        ,KS_Liczba_stron int NOT NULL
        ,ID_Autora int NOT NULL
        ,ID_Kategorii int NOT NULL
        ,PRIMARY KEY (ID_Ksiazki)
        , CONSTRAINT fk_KsiazkaAutor FOREIGN KEY (ID_Autora)
        REFERENCES Autorzy(ID_Autora)
        , CONSTRAINT fk_KsiazkaKategoria FOREIGN KEY (ID_Kategorii)
        REFERENCES Kategoria(ID_Kategorii)
    );

CREATE GENERATOR GEN_Ksiazki_ID;

SET TERM ^ ;

CREATE TRIGGER TRIG_Ksiazki_GEN FOR Ksiazki
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN
	IF (NEW.ID_Ksiazki IS NULL) THEN
	NEW.ID_Ksiazki = GEN_ID(GEN_Ksiazki_ID,1);
END^

SET TERM ; ^


	
	CREATE TABLE Kierunek
    (
        ID_Kierunku int NOT NULL
        ,KR_Nazwa varchar(40) NOT NULL
        ,PRIMARY KEY (ID_Kierunku)
    );
	
CREATE GENERATOR GEN_Kierunek_ID;

SET TERM ^ ;

CREATE TRIGGER TRIG_Kierunek_GEN FOR Kierunek
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN
	IF (NEW.ID_Kierunku IS NULL) THEN
	NEW.ID_Kierunku = GEN_ID(GEN_Kierunek_ID,1);
END^

SET TERM ; ^

	
	
	CREATE TABLE Polecane
    (
		ID_Kierunku int NOT NULL
        ,ID_Ksiazki int NOT NULL
		, CONSTRAINT fk_PolecaneKierunek FOREIGN KEY (ID_Kierunku)
        REFERENCES Kierunek(ID_Kierunku)
        , CONSTRAINT fk_PolecaneKsiazka FOREIGN KEY (ID_Ksiazki)
        REFERENCES Ksiazki(ID_Ksiazki)
    );
	


    CREATE TABLE Studenci
    (
        ID_Studenta int NOT NULL
        ,ST_Imie varchar(40) NOT NULL
        ,ST_Nazwisko varchar(40) NOT NULL
        ,ST_Data_urodzenia date NOT NULL
        ,ST_Plec varchar(40) NOT NULL
        ,ID_Kierunku int NOT NULL
        ,PRIMARY KEY (ID_Studenta)
		, CONSTRAINT fk_StudentKierunek FOREIGN KEY (ID_Kierunku)
        REFERENCES Kierunek(ID_Kierunku)
    );

CREATE GENERATOR GEN_Studenci_ID;

SET TERM ^ ;

CREATE TRIGGER TRIG_Studenci_GEN FOR Studenci
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN
	IF (NEW.ID_Studenta IS NULL) THEN
	NEW.ID_Studenta = GEN_ID(GEN_Studenci_ID,1);
END^

SET TERM ; ^



    CREATE TABLE Wypozyczenia
    (
        ID_Wypozyczenia int NOT NULL
        ,ID_Studenta int NOT NULL
        ,ID_Ksiazki int NOT NULL
        ,WP_Data_wypozyczenia date NOT NULL
        ,WP_Data_oddania date NOT NULL
        ,PRIMARY KEY (ID_Wypozyczenia)
        , CONSTRAINT fk_WypozyczenieStudent FOREIGN KEY (ID_Studenta)
        REFERENCES Studenci(ID_Studenta)
        , CONSTRAINT fk_WypozyczenieKsiazka FOREIGN KEY (ID_Ksiazki)
        REFERENCES Ksiazki(ID_Ksiazki)
    );
	
CREATE GENERATOR GEN_Wypozyczenia_ID;

SET TERM ^ ;

CREATE TRIGGER TRIG_Wypozyczenia_GEN FOR Wypozyczenia
ACTIVE BEFORE INSERT POSITION 0
AS 
BEGIN
	IF (NEW.ID_Wypozyczenia IS NULL) THEN
	NEW.ID_Wypozyczenia = GEN_ID(GEN_Wypozyczenia_ID,1);
END^

SET TERM ; ^




SET TERM ^ ;
CREATE PROCEDURE DodanieAutora(the_ID integer,
                               the_imie varchar(40),
                               the_nazwisko varchar(40)) /* procedure name and required parameters  */
RETURNS (ID_AUTORA INTEGER) /* return values */
AS
BEGIN
    ID_AUTORA = GEN_ID(GEN_AUTORZY_ID,1); /* next value */
    INSERT INTO AUTORZY(ID_AUTORA,AU_IMIE,AU_NAZWISKO) /* insert a new record */
    VALUES(:the_ID,:the_imie,:the_nazwisko);
END^
SET TERM ; ^