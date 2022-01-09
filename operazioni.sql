OP1:
INSTERT INTO Spedizione VALUES( :( )

OP1:
CREATE OR REPLACE FUNCTION aggiungi_spedizione(codice integer,
percorso int, localita_p numeric(5), localita_a numeric(5)character varying, indirizzo_s character varying, provincia_s
character, email_s character varying DEFAULT NULL::character varying,
telefono_s integer DEFAULT NULL::integer, sez character varying[] DEFAULT
NULL::character varying[])
 RETURNS void AS
$BODY$
DECLARE
cod integer := (SELECT max(codice)+1 FROM "Partecipante");
scu integer ;
i time without time zone;
BEGIN
IF NOT EXISTS(SELECT* FROM "Scuola" WHERE "Scuola".nome=nome_s AND
"Scuola".citta=citta_s AND "Scuola".provincia=provincia_s) THEN
scu := (SELECT max(codice)+1 FROM "Scuola");
INSERT INTO "Scuola"
VALUES (scu,nome_s,citta_s,indirizzo_s,provincia_s,email_s,telefono_s);
END IF;
IF array_length(sez,1)>0 THEN
INSERT INTO "Partecipante"
VALUES(cod);
INSERT INTO "Scuola_Part"(codice,scuola)
VALUES (cod,scu);
FOR j IN 1..array_length(sez, 1) LOOP
INSERT INTO "Iscrizione1"
VALUES(cod,sez[j]);
IF (SELECT max(ora) FROM "Esibizione" WHERE
"Esibizione".sezione=sez[j])IS NULL THEN
i:='00:00:00';
ELSE
i:=(SELECT max(ora) FROM "Esibizione" WHERE
"Esibizione".sezione=sez[j]);
END IF;
INSERT INTO "Esibizione" (partecipante,data,ora,sezione)
VALUES(cod,(date '0001-01-01' + j),
( i + interval '10 minute'),sez[j]);
 END LOOP;
END IF;
end
$BODY$ LANGUAGE plpgsql VOLATILE









OP12:
CREATE OR REPLACE FUNCTION modifica_tratta(cap_loc numeric(5), codice_gf int)
RETURNS void AS
$BODY$
DECLARE
BEGIN
    UPDATE Localita
SET CodiceGiro = codice_gf
WHERE CAP = cap_loc;
end
$BODY$ LANGUAGE plpgsql VOLATILE


ii int = 10;
i cointj count = 0;



CREATE OR REPLACE FUNCTION addloc()
RETURNS TABLE AS
$BODY$$BODY$
i  i
count int = 1DECLARE i int = 0;

WHILE i < count
BEGIN
    SET @i =@i + 1
    Insert into Localita(CAP) VALUES(i)
END


$BODY$ LANGUAGE plpgsql VOLATILE

















CREATE OR REPLACE FUNCTION addloc()
RETURNS void AS
$BODY$
DECLARE i int  = 0;
BEGIN
FOR j IN 1..10 LOOP
    -- i will take on the values 1,2,3,4,5,6,7,8,9,10 within the loop
END LOOP;
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% --



CREATE OR REPLACE FUNCTION addSpedizione(CodiceDestinatario INT, NominativoDestinatario VARCHAR(20), CodiceMittente INT, NominativoMittente VARCHAR(20), ViaDestinazione VARCHAR(30), CivicoDestinazione INT, ViaPartenza VARCHAR(30), CivicoPartenza INT, CAPDestinazione num
(5), CAPPartenza NUMERIC(5), Telefono NUMERIC(10))
RETURNS void AS
$BODY$

DECLARE CodiceNuovaSpedizione INT;
SET CodiceNuovaSpedizione := (SELECt max(Codice)+1 FROM Spedizione);

DECLARE CodicePercorso INT;
SET CodicePercorso := (SELECT Codice
                        FROM Percorso
                        WHERE 

DECLARE Stato VARCHAR(20);
SET Stato = "in transito";

DECLARE ViaPartenza VARCHAR(30);
DECLARE CivicoPartenza INT;
DECLARE Telefono NUMERIC(10);

BEGIN
    IF $7 <> '1' 
        THEN
            LocalitaPartenza = (SELECT CAP
                                FROM Clienti
                                WHERE CodiceCliente = $7)
    ELSE




END
$BODY$ LANGUAGE plpgsql VOLATILE


















--pollorosso--
OP2: Rimuovere una spedizione
CREATE OR REPLACE FUNCTION removeSpedizione(Codice INT)
RETURNS void AS
$BODY$
DELETE FROM Spedizione WHERE Codice = $1;
$BODY$ LANGUAGE plpgsql VOLATILES 



























OP7: 
SELECT *
FROM Spedizioni




OP8:
CREATE OR REPLACE FUNCTION addFiliale(Tipo VARCHAR(20), Via VARCHAR(30), Civico INT, CAP NUMERIC(5))
RETURNS void AS 
$BODY$
DECLARE codiceFiliale := (SELECT max(Codice)+1 FROM Filiale);
BEGIN

END
$BODY$ LANGUAGE plpgsql VOLATILE




OP10:
CREATE OR REPLACE FUNCTION printFilialByRegion(Regione VARCHAR(20))
RETURNS TABLE(Regione VARCHAR(20), NumFiliali INT) AS 
$BODY$
SELECT Regione, COUNT(*)
FROM Filiale JOIN Localita ON Filiale.Localita = Localita.CAP
WHERE Regione = $1
GROUP BY Regione
$BODY$ LANGUAGE plpgsql VOLATILE



OP31:
CREATE OR REPLACE 






















































OP37:
CREATE OR REPLACE FUNCTION printTariffe()
RETURNS TABLE(CodiceTariffa INT, CostoAnnuo INT, Categoria INT, Prezzo INT, VolumeMinimo INT, VolumeMassimo INT) AS 
$BODY$
SELECT Tariffa.CodiceTariffa, Tariffa.Costo, Categoria.CodiceCategoria, Categoria.Prezzo, Categoria.VolumeMinimo, Categoria.VolumeMassimo
FROM Tariffa JOIN Personalizzazione ON Tariffa.CodiceTariffa = Personalizzazione.Tariffa
            JOIN Categoria ON Personalizzazione.Categoria = Categoria.CodiceCategoria
$BODY$ LANGUAGE plpgsql VOLATILE


OP38:Visualizzare tutte le spedizioni effettuate da un cliente 
CREATE OR REPLACE FUNCTION printSpedizioniByMittente(CodiceCliente INT)
RETURNS TABLE(CodiceSpedizione INT, NominativoMittente VARCHAR(20) NominativoDestinatario VARCHAR(20), IndirizzoDestinazione VARCHAR(30) CivicoDestinazione INT, Stato VARCHAR(20), Costo INT) AS
$BODY$
SELECT Codice, NominativoMittente, NominativoDestinatario, IndirizzoDestinazione, CivicoDestinazione, Stato, Costo
FROM Spedizione
WHERE CodiceMittente = $1
$BODY$ LANGUAGE plpgsql VOLATILE


OP39:Visualizzare tutte le spedizioni ricevute da un cliente
CREATE OR REPLACE FUNCTION printSpedizioniByMittente(CodiceCliente INT)
RETURNS TABLE(CodiceSpedizione INT, NominativoMittente VARCHAR(20) NominativoDestinatario VARCHAR(20), IndirizzoDestinazione VARCHAR(30) CivicoDestinazione INT, Stato VARCHAR(20), Costo INT) AS
$BODY$
SELECT Codice, NominativoMittente, NominativoDestinatario, IndirizzoDestinazione, CivicoDestinazione, Stato, Costo
FROM Spedizione
WHERE CodiceDestinatario = $1
$BODY$ LANGUAGE plpgsql VOLATILE


OP40:Visualizzare la lista di tutti i dipendenti presenti in una filiale riportando la sezione in cui lavorano il ruolo ricoperto e lo stipendio
CREATE OR REPLACE FUNCTION printDipendentiByFiliale(CodiceFiliale INT)
RETURNS TABLE(Matricola INT, Nome VARCHAR(20), Cognome VARCHAR(20), Ruolo VARCHAR(20), Sezione VARCHAR(10), Stipendio INT) AS
$BODY$
SELECT Dipendente.Matricola, Dipendente.Nome, Dipendente.Cognome, Ruolo.Nome, Sezione.Nome, Ruolo.Stipendio
FROM Dipendente JOIN Afferenza ON Dipendente.Matricola = Afferenza.Dipendente
                JOIN Filiale ON Afferenza.Filiale = Filiale.Codice
                JOIN Sezione ON Afferenza.Sezione = Sezione.Sigla
                        AND Filiale.Codice = Sezione.Filiale
                JOIN Impiego ON Dipendente.Matricola = Impiego.Dipendente
                JOIN Ruolo ON Impiego.Ruolo = Ruolo.Sigla
WHERE Filiale.Codice = $1
$BODY$ LANGUAGE plpgsql VOLATILE


OP41:Visualizzare tutti i dipendenti relativi ad un particolare ruolo presenti nell’azienda riportando la filiale in cui operano
CREATE OR REPLACE FUNCTION printDipendentiByRuolo(Ruolo VARCHAR(20))
RETURNS TABLE(Matricola INT, Nome VARCHAR(20), Cognome VARCHAR(20), Ruolo VARCHAR(20), Filiale INT) AS
$BODY$
SELECT Dipendente.Matricola, Dipendente.Nome, Dipendente.Cognome, Ruolo.Nome, Filiale.Codice
FROM Dipendente JOIN Afferenza ON Dipendente.Matricola = Afferenza.Dipendente
                JOIN Filiale ON Afferenza.Filiale = Filiale.Codice
                JOIN Impiego ON Dipendente.Matricola = Impiego.Dipendente
                JOIN Ruolo ON Impiego.Ruolo = Ruolo.Sigla
WHERE Ruolo.Sigla = $1
$BODY$ LANGUAGE plpgsql VOLATILE

