CREATE TABLE Dipendente(
    Matricola INT PRIMARY KEY,
    Nome VARCHAR(20) NOT NULL,
    Cognome VARCHAR(20) NOT NULL,
    Sesso CHAR(1) NOT NULL CHECK (Sesso in ('M','F')),
    DataNascita DATE NOT NULL,
    Via VARCHAR(30) NOT NULL,
    Civico INT NOT NULL,
    CAP NUMERIC(5) NOT NULL,
    Regione VARCHAR(20) NOT NULL,
    Provincia VARCHAR(2) NOT NULL,
    CodiceFiscale CHAR(16) NOT NULL,
    Ruolo VARCHAR(5) NOT NULL REFERENCES Ruolo(Sigla),
    DataInizio DATE NOT NULL,
    Sezione VARCHAR(5) NOT NULL REFERENCES Sezione(Sigla),
    Filiale INT NOT NULL REFERENCES Filiale(Codice)
)

CREATE TABLE Ruolo(
    Sigla VARCHAR(5) PRIMARY KEY,
    Nome VARCHAR(20) NOT NULL,
    Stipendio INT NOT NULL
)

CREATE TABLE Sezione(
    Sigla VARCHAR(5) PRIMARY KEY,
    Filiale INT NOT NULL REFERENCES Filiale(Codice),
    Nome VARCHAR(20) NOT NULL
)


CREATE TABLE Impiego_Passato(
    DataInizio DATE REFERENCES NOT NULL,
    Dipendente INT Dipendente(Matricola) NOT NULL,
    DataFine DATE NOT NULL,
    Ruolo VARCHAR(20) REFERENCES Ruolo(Sigla) NOT NULL,

    PRIMARY KEY (DataInizio, Dipendente)
)

CREATE TABLE Filiale(
    Codice INT PRIMARY KEY,
    Tipo VARCHAR(20) NOT NULL CHECK (Tipo IN ('Hub','Secondaria')),
    Via VARCHAR(30) NOT NULL,
    Civico INT NOT NULL,
    Localita NUMERIC(5) NOT NULL REFERENCES Localita(CAP)
)

CREATE TABLE Localita(
    CAP NUMERIC(5) PRIMARY KEY,
    Regione VARCHAR(20) NOT NULL,
    Provincia VARCHAR(2) NOT NULL,
    Citta VARCHAR(20) NOT NULL,
    CodiceGiro INT NOT NULL REFERENCES Zone_Di_Consegna_E_Ritiro(CodiceGiro)
) 


CREATE TABLE Zone_Di_Consegna_E_Ritiro(
    CodiceGiro INT PRIMARY KEY,
    CodiceFiliale INT REFERENCES Filiale(Codice) NOT NULL
)

CREATE TABLE Consegna_Effettiva(
    CodiceGiro INT REFERENCES Zone_Di_Consegna_E_Ritiro(CodiceGiro),
    Data DATE,
    OraUscita TIMESTAMP, 
    OraRientro TIMESTAMP NOT NULL,
    Mezzo INT REFERENCES Mezzo(Targa) NOT NULL,
    
    PRIMARY KEY(CodiceGiro, Data, OraUscita)   
)

CREATE TABLE Ritiro_Effettivo(
    CodiceGiro INT REFERENCES Zone_Di_Consegna_E_Ritiro(CodiceGiro),
    Data DATE,
    OraUscita TIMESTAMP, 
    OraRientro TIMESTAMP NOT NULL,
    Mezzo INT REFERENCES Mezzo(Targa) NOT NULL,
    
    PRIMARY KEY(CodiceGiro, Data, OraUscita)
)

CREATE TABLE Mezzo(
    Targa VARCHAR(7) PRIMARY KEY,
    Azienda NUMERIC(11) NOT NULL REFERENCES Azienda(PartitaIVA)    
)

CREATE TABLE Azienda(
    PartitaIVA NUMERIC(11) PRIMARY KEY,
    Nome VARCHAR(20) NOT NULL,
    DataInizioContratto DATE NOT NULL,
    DataFineContratto DATE NOT NULL,
    CostoContratto INT
)

CREATE TABLE Tratta(
    Codice INT PRIMARY KEY,
    FilialePartenza VARCHAR(20) REFERENCES Filiale(Codice) NOT NULL,
    FilialeArrivo VARCHAR(20) REFERENCES Filiale(Codice) NOT NULL
)

CREATE TABLE Tratta_Reale(
    Tratta INT PRIMARY KEY REFERENCES Tratta(Codice),
    DataPartenza DATE REFERENCES NOT NULL,
    OraPartenza TIMESTAMP NOT NULL,
    DataArrivo DATE,
    OraArrivo TIMESTAMP,
    Mezzo VARCHAR(7) REFERENCES Mezzo(Targa) 
)

CREATE TABLE Spostamenti(
    Tratta INT REFERENCES,
    DataPartenza DATE REFERENCES,
    OraPartenza TIMESTAMP,
    Codice INT,

    FOREIGN KEY (Tratta, DataPartenza, OraPartenza) REFERENCES Tratta_Reale(Tratta,DataPartenza,OraPartenza),
    FOREIGN KEY (Codice) REFERENCES Spedizioni(Codice),

    PRIMARY KEY(Tratta, DataPartenza, OraArrivo, Codice)
)

CREATE TABLE Percorso(
    Codice INT PRIMARY KEY,
    Nome VARCHAR(20) NOT NULL
)

CREATE TABLE Tratte_Percorso(
    Percorso INT PRIMARY KEY REFERENCES Percorso(Codice),
    Tratta INT NOT NULL REFERENCES Tratta(Codice)
)


CREATE TABLE Spedizione(
	Codice INT PRIMARY KEY,
	Percorso INT NOT NULL,
	LocalitaPartenza NUMERIC(5) NOT NULL,
	LocalitaArrivo NUMERIC(5) NOT NULL,
	Destinatario INT NOT NULL,
	Mittente INT NOT NULL,
	Stato VARCHAR(20) NOT NULL,
	Costo INT NOT NULL,
	ViaPartenza VARCHAR(30) NOT NULL,
	ViaDestinazione VARCHAR(30) NOT NULL,
	CivicoPartenza INT NOT NULL,
	CivicoDestinazione INT NOT NULL,
	NominativoMittente VARCHAR(20) NOT NULL,
	NominativoDestinatario ARCHAR(20) NOT NULL,
	Telefono NUMERIC(10) NOT NULL,
	
	FOREIGN KEY(Percorso) REFERENCES Percorso(Codice),
	FOREIGN KEY(LocalitaPartenza, LocalitaArrivo) REFERENCES Localita(CAP),
	FOREIGN KEY(Destinatario, Mittente) REFERENCES Cliente_Registrato(CodiceCliente)
)

CREATE TABLE Cliente_Registrato(
    CodiceCliente INT PRIMARY KEY,
    Civico INT NOT NULL,
    Via VARCHAR(30) NOT NULL,
    CAP NUMERIC(5) NOT NULL,
    Citta VARCHAR(20) NOT NULL,
    Provincia VARCHAR(20) NOT NULL,
    Regione VARCHAR(20) NOT NULL,
    Telefono NUMERIC(10) NOT NULL,
    Mail VARCHAR(30) NOT NULL
)

CREATE TABLE Privato(
	Cliente INT REFERENCES Cliente_Registrato(CodiceCliente) PRIMARY KEY,
	CodiceFiscale VARCHAR(16) NOT NULL,
	Nome VARCHAR(20) NOT NULL,
    Cognome VARCHAR(20) NOT NULL,
    Sesso CHAR(1) NOT NULL CHECK (Sesso in ('M','F'))
)

CREATE TABLE Impresa(
	Cliente INT REFERENCES Cliente_Registrato(CodiceCliente) PRIMARY KEY,
	PartitaIVA NUMERIC(11) NOT NULL,
	Denominazione VARCHAR(20) NOT NULL
)

CREATE TABLE Unita(
	Spedizione INT,
	NumeroUnita INT,
	Volume INT NOT NULL,
	Tariffa INT NOT NULL,
	
	FOREIGN KEY (Spedizione) REFERENCES Spedizione(Codice),
	FOREIGN KEY (Tariffa) REFERENCES Tariffa(CodiceTariffa),
	PRIMARY KEY (Spedizione, NumeroUnita)
)

CREATE TABLE Tariffa_Personalizzata(
	CodiceTariffa INT PRIMARY KEY,
	Costo INT NOT NULL
)

CREATE TABLE Tariffa(
	CodiceTariffa INT PRIMARY KEY,
	Pezzo INT NOT NULL,
	VolumeMassimo INT NOT NULL
)

CREATE TABLE Tariffa_Cliente(
	Tariffa INT,
	Cliente INT,
	
	FOREIGN KEY (Tariffa) REFERENCES Tariffa_Personalizzata(CodiceTariffa),
	FOREIGN KEY (Cliente) REFERENCES Cliente_Registrato(CodiceCliente),
	PRIMARY KEY (Tariffa, Cliente)
)

CREATE TABLE Personalizzazione(
	Tariffa  INT,
	TariffaPersonalizzata INT,
	Prezzo INT NOT NULL
	Sconto INT NOT NULL,
	
	FOREIGN KEY (Tariffa) REFERENCES Tariffa(CodiceTariffa),
	FOREIGN KEY (TariffaPersonalizzata) REFERENCES Tariffa_Personalizzata(CodiceTariffa),
	PRIMARY KEY (Tariffa, TariffaPersonalizzata)
)

CREATE TABLE Carico_Consegna(
	Spedizione INT,
	Consegna INT,
	DataConsegna DATE,
	OraConsegna TIMESTAMP,
	 
	FOREIGN KEY (Spedizione) REFERENCES Spedizione(Codice),
	FOREIGN KEY (Consegna) REFERENCES Zone_Di_Consegna_E_Ritiro(CodiceGiro),
 	FOREIGN KEY (DataConsegna, OraConsegna) REFERENCES Consegna_Effettiva(Data,OraUscita),
	PRIMARY KEY (Spedizione, Consegna, DataConsegna, OraConsegna)
)

CREATE TABLE Carico_Ritiro(
	Spedizione INT,
	Ritiro INT,
	DataRitiro DATE,
	OraRitiro TIMESTAMP,
	
	FOREIGN KEY (Spedizione) REFERENCES Spedizione(Codice),
	FOREIGN KEY (Ritiro) REFERENCES Zone_Di_Consegna_E_Ritiro(CodiceGiro),
 	FOREIGN KEY (DataRitiro, OraRitiro) REFERENCES Consegna_Effettiva(Data,OraUscita),
	PRIMARY KEY (Spedizione, Ritiro, DataRitiro, OraConsegna)
)

CREATE TABLE Filiale_Corrente(
	Spedizione INT,
	Filiale INT,
	
	FOREIGN KEY (Spedizione) REFERENCES Spedizione(Codice),
	FOREIGN KEY (Filiale) REFERENCES Filiale(Codice),
	PRIMARY KEY (Spedizione, Filiale)
)