CREATE TABLE Dipendente(
    Matricola INT PRIMARY KEY ,
    Nome VARCHAR(20) NOT NULL,
    Cognome VARCHAR(20) NOT NULL,
    Sesso CHAR(1) NOT NULL CHECK (Sesso in ('M','F')),
    DataNascita DATE NOT NULL,
    Via VARCHAR(30) NOT NULL,
    Civico INT NOT NULL,
    CAP NUMERIC(5) NOT NULL,
    Regione VARCHAR(20) NOT NULL,
    Provincia VARCHAR(2) NOT NULL,
    CodiceFiscale CHAR(16) NOT NULL
)

CREATE TABLE Ruolo(
    Sigla VARCHAR(5) PRIMARY KEY,
    Nome VARCHAR(20) NOT NULL,
    Stipendio INT NOT NULL
)

CREATE TABLE Sezione(
    Sigla VARCHAR(5) PRIMARY KEY,
    Filiale INT NOT NULL REFERENCES Filiale(Codice) ON UPDATE CASCADE ON DELETE CASCADE,
    Nome VARCHAR(20) NOT NULL
)


CREATE TABLE Impiego_Passato(
    DataInizio DATE,
    Dipendente INT REFERENCES Dipendente(Matricola) ON UPDATE CASCADE ON DELETE NO ACTION,
    DataFine DATE NOT NULL,
    Ruolo VARCHAR(5) REFERENCES Ruolo(Sigla) ON UPDATE CASCADE ON DELETE NO ACTION,

    PRIMARY KEY (DataInizio, Dipendente)
)

CREATE TABLE Filiale(
    Codice INT PRIMARY KEY,
    Tipo VARCHAR(20) NOT NULL CHECK (Tipo IN ('Hub','Secondaria')),
    Via VARCHAR(30) NOT NULL,
    Civico INT NOT NULL,
    Localita NUMERIC(5) NOT NULL REFERENCES Localita(CAP) ON UPDATE CASCADE ON DELETE NO ACTION,
    NumeroDipendenti INT NOT NULL
)

CREATE TABLE Localita(
    CAP NUMERIC(5) PRIMARY KEY,
    Regione VARCHAR(20) NOT NULL,
    Provincia VARCHAR(2) NOT NULL,
    Citta VARCHAR(20) NOT NULL,
    CodiceGiro NOT NULL INT REFERENCES Zone_Di_Consegna_E_Ritiro(CodiceGiro) ON UPDATE CASCADE ON DELETE NO ACTION
) 


CREATE TABLE Zone_Di_Consegna_E_Ritiro(
    CodiceGiro INT PRIMARY KEY,
    CodiceFiliale INT NOT NULL REFERENCES Filiale(Codice) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE Consegna_Effettiva(
    Codice INT PRIMARY KEY,
    CodiceGiro INT NOT NULL REFERENCES Zone_Di_Consegna_E_Ritiro(CodiceGiro) ON UPDATE CASCADE ON DELETE NO ACTION,
    Data DATE NOT NULL, 
    OraUscita TIMESTAMP NOT NULL, 
    OraRientro TIMESTAMP,
    Mezzo INT NOT NULL REFERENCES Mezzo(Targa) ON UPDATE CASCADE ON DELETE NO ACTION,   
    UNIQUE(CodiceGiro, Data, OraUscita)
)

CREATE TABLE Ritiro_Effettivo(
    Codice INT PRIMARY KEY,
    CodiceGiro INT NOT NULL REFERENCES Zone_Di_Consegna_E_Ritiro(CodiceGiro)  ON UPDATE CASCADE ON DELETE NO ACTION,
    Data DATE NOT NULL,
    OraUscita TIMESTAMP NOT NULL, 
    OraRientro TIMESTAMP,
    Mezzo INT NOT NULL REFERENCES Mezzo(Targa) ON UPDATE CASCADE ON DELETE NO ACTION,
    UNIQUE(CodiceGiro, Data, OraUscita)
)

CREATE TABLE Mezzo( 
    Targa VARCHAR(7) PRIMARY KEY,
    Azienda NUMERIC(11) NOT NULL REFERENCES Azienda(PartitaIVA) ON UPDATE CASCADE ON DELETE CASCADE   
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
    FilialePartenza INT NOT NULL REFERENCES Filiale(Codice) ON UPDATE CASCADE ON DELETE NO ACTION,
    FilialeArrivo INT NOT NULL REFERENCES Filiale(Codice) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Tratta_Reale(
    Codice INT PRIMARY KEY,
    Tratta INT NOT NULL REFERENCES Tratta(Codice) ON UPDATE CASCADE ON DELETE NO ACTION,
    DataPartenza DATE NOT NULL,
    OraPartenza TIMESTAMP NOT NULL,
    DataArrivo DATE,
    OraArrivo TIMESTAMP,
    Mezzo VARCHAR(7) REFERENCES Mezzo(Targa) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Percorso(
    Codice INT PRIMARY KEY,
    Nome VARCHAR(20) NOT NULL
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
	NominativoDestinatario VARCHAR(20) NOT NULL,
	Telefono NUMERIC(10) NOT NULL,
	
	FOREIGN KEY(Percorso) REFERENCES Percorso(Codice) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(LocalitaPartenza) REFERENCES Localita(CAP) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY(LocalitaArrivo) REFERENCES Localita(CAP) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY(Mittente) REFERENCES Cliente(CodiceCliente) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY(Destinatario) REFERENCES Cliente(CodiceCliente) ON UPDATE CASCADE ON DELETE NO ACTION
)

CREATE TABLE Cliente(
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
	Cliente INT REFERENCES Cliente(CodiceCliente) ON UPDATE CASCADE ON DELETE CASCADE PRIMARY KEY ,
	CodiceFiscale VARCHAR(16) NOT NULL,
	Nome VARCHAR(20) NOT NULL,
    Cognome VARCHAR(20) NOT NULL,
    Sesso CHAR(1) NOT NULL CHECK (Sesso in ('M','F'))
)

CREATE TABLE Impresa(
	Cliente INT REFERENCES Cliente(CodiceCliente) ON UPDATE CASCADE ON DELETE CASCADE PRIMARY KEY,
	PartitaIVA NUMERIC(11) NOT NULL,
	Denominazione VARCHAR(100) NOT NULL
)

CREATE TABLE Unita(
	Spedizione INT,
	NumeroUnita INT,
	Volume INT NOT NULL,
	Categoria INT NOT NULL,
	
    PRIMARY KEY (Spedizione, NumeroUnita),
	FOREIGN KEY (Spedizione) REFERENCES Spedizione(Codice) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Categoria) REFERENCES Categoria(CodiceCategoria) ON UPDATE CASCADE ON DELETE NO ACTION	
)

CREATE TABLE Categoria(
	CodiceCategoria INT PRIMARY KEY,
	VolumeMassimo INT NOT NULL,
    VolumeMinimo INT NOT NULL
)

CREATE TABLE Tariffa(
	CodiceTariffa INT PRIMARY KEY,
	Costo INT NOT NULL
)

CREATE TABLE Impiego(
    Dipendente INT REFERENCES Dipendente(Matricola) ON UPDATE CASCADE ON DELETE CASCADE,
    Ruolo VARCHAR(5) REFERENCES Ruolo(Sigla) ON UPDATE CASCADE ON DELETE NO ACTION,
    DataInizio DATE NOT NULL,
    
    PRIMARY KEY (Dipendente, Ruolo)
)

CREATE TABLE Afferenza(
    Dipendente INT REFERENCES Dipendente(Matricola) ON UPDATE CASCADE ON NO ACTION,
    Sezione VARCHAR(5) NOT NULL,
    Filiale INT NOT NULL,
    
    FOREIGN KEY (Sezione, Fliale) REFERENCES Sezione(Sigla, Filiale),
    PRIMARY KEY (Dipendente, Sezione, Filiale)
)

CREATE TABLE Spostamenti(
    Tratta INT,
    Codice INT,

    FOREIGN KEY (Tratta) REFERENCES Tratta_Reale(Codice) ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (Codice) REFERENCES Spedizioni(Codice)ON UPDATE CASCADE ON DELETE CASCADE,

    PRIMARY KEY(Tratta, Codice)
)

CREATE TABLE Tratte_Percorso(
    Tratta INT  REFERENCES Tratta(Codice) ON UPDATE CASCADE ON DELETE NO ACTION,   
    Percorso INT REFERENCES Percorso(Codice) ON UPDATE CASCADE ON DELETE CASCADE,
    Numero INT NOT NULL,

    PRIMARY KEY(Percorso, Tratta)
)

--si potrebbe mettere tariffa alla tariffa base se diversa quando cancellata
CREATE TABLE Tariffa_Cliente(
	Tariffa INT,
	Cliente INT,
	
	FOREIGN KEY (Tariffa) REFERENCES Tariffa(CodiceTariffa) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (Cliente) REFERENCES Cliente(CodiceCliente) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (Tariffa, Cliente)
)

CREATE TABLE Personalizzazione(
	Categoria  INT,
	Tariffa INT,
	Prezzo INT NOT NULL,
	
	
	FOREIGN KEY (Categoria) REFERENCES Categoria(CodiceCategoria) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Tariffa) REFERENCES Tariffa(CodiceTariffa) ON UPDATE CASCADE ON DELETE CASCADE,
	PRIMARY KEY (Categoria, Tariffa)
)

CREATE TABLE Filiale_Corrente(
	Spedizione INT,
	Filiale INT,
	
	FOREIGN KEY (Spedizione) REFERENCES Spedizione(Codice) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (Filiale) REFERENCES Filiale(Codice) ON UPDATE CASCADE ON DELETE NO ACTION,
	PRIMARY KEY (Spedizione, Filiale)
)

CREATE TABLE Carico_Consegna(
	Spedizione INT REFERENCES Spedizione(Codice) ON UPDATE CASCADE ON DELETE CASCADE,
	Consegna INT REFERENCES Consegna_Effettiva(Codice) ON UPDATE CASCADE ON DELETE NO ACTION,
	 
	PRIMARY KEY (Spedizione, Consegna)
)


CREATE TABLE Carico_Ritiro(
	Spedizione INT REFERENCES Spedizione(Codice)  ON UPDATE CASCADE ON DELETE CASCADE,
	Ritiro INT REFERENCES Ritiro_Effettivo(Codice)  ON UPDATE CASCADE ON DELETE NO ACTION,
	 
	PRIMARY KEY (Spedizione, Ritiro)
)



