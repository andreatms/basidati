
OP2: Rimuovere una spedizione
CREATE OR REPLACE FUNCTION removeSpedizione(Codice INT)
RETURNS void AS
$BODY$
BEGIN
DELETE FROM Spedizione WHERE Codice = $1;
END
$BODY$ LANGUAGE plpgsql VOLATILE




OP20
CREATE OR REPLACE FUNCTION aggiungi_mezzo(Azienda NUMERIC(11),Targa VARCHAR(7))
RETURNS void AS
$BODY$
BEGIN
INSERT INTO Mezzo VALUES($1,$2)
END


OP21
rimouuoveiiCREATE OR REPLACE FUNCTION aggiungi_mezzo(Targa VARCHAR(7))
RETURNS voidMezzo WHERE Targa = AS;DELETE FROM BEGIN
INSERT INTO Mezzo VALUES($1,$2)
END
$BODY$ LANGUAGE plpgsql VOLATILE$BODY$ LANGUAGE plpgsql VOLATILE


CREATE OR REPLACE FUNCTION elimina_partecipante(cod integer)
RETURNS void AS
$BODY$BEGIN
DELETE FROM "Partecipante"
WHERE $1=codice;
END$BODY$
LANGUAGE plpgsql VOLATILE




OP18
CREATE OR REPLACE FUNCTION aggiungi_azienda(
    PartitaIVA NUMERIC(11),
    Nome VARCHAR(20),
    DataInizioContratto DATE,
    DataFineContratto DATE,
    CostoContratto INT
)
RETURNS void AS
$BODY$ BEGIN
INSERT INTO Azienda VALUES($1,$2,$3,$4,$5);
END
$BODY$ LANGUAGE plpgsql VOLATILE

OP19
CREATE OR REPLACE FUNCTION elimina_azienda(
    PartitaIVA NUMERIC(11)
)
RETURNS void AS
$BODY$ BEGIN
DELETE FROM Azienda
WHERE $1=PartitaIVA;
END $BODY$
LANGUAGE plpgsql VOLATILE

OP8
CREATE OR REPLACE FUNCTION aggiungi_filiale(
    Codice INT,
    Tipo VARCHAR(20),
    Via VARCHAR(30),
    Civico INT,
    Localita NUMERIC(5),
    NumeroDipendenti INT
)
RETURNS void AS
$BODY$ BEGIN
INSERT INTO Filiale VALUES($1,$2,$3,$4,$5,$6);
END
$BODY$ LANGUAGE plpgsql VOLATILE


OP9
CREATE OR REPLACE FUNCTION elimina_filiale(
    Codice NUMERIC(11)
)
RETURNS void AS
$BODY$ BEGIN
DELETE FROM Filiale
WHERE Filiale.Codice=$1;
END $BODY$
LANGUAGE plpgsql VOLATILE



OP28
CREATE OR REPLACE FUNCTION aggiungi_sezione(
    Sigla VARCHAR(5),
    Filiale INT,
    Nome VARCHAR(20),

)
RETURNS void AS
$BODY$ BEGIN
INSERT INTO Sezione VALUES($1,$2,$3);
END
$BODY$ LANGUAGE plpgsql VOLATILE


OP29
CREATE OR REPLACE FUNCTION elimina_sezione(
    Sigla VARCHAR(5)
)
RETURNS void AS
$BODY$ BEGIN
DELETE FROM Sezione
WHERE Sezione.Sigla=$1;
END $BODY$
LANGUAGE plpgsql VOLATILE