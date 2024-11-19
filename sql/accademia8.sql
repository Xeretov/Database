/*
Persona (id: PosInteger, nome: StringaM, cognome: StringaM, posizione: Strutturato, stipendio: Denaro)

Progetto (id: PosInteger, nome: StringaM, inizio: date, fine: date, budget:Denaro)
    [VincoloDB.1] altra chiave: (nome)
    [VincoloDB.2] ennupla: inizio < fine

WP (progetto: PosInteger, id: PosInteger, nome: StringaM, inizio: date, fine:date)
    [VincoloDB.3] ennupla: inizio < fine
    [VincoloDB.4] altra chiave: (progetto, nome)
    [VincoloDB.5] foreign key: progetto references Progetto(id)

AttivitaProgetto (id: PosInteger, persona: PosInteger, progetto: PosInteger, wp: PosInteger, giorno: date, tipo: LavoroProgetto, oreDurata: NumeroOre)
    [VincoloDB.6] foreign key: persona references Persona(id)
    [VincoloDB.7] foreign key: (progetto, wp) references WP(progetto, id)

AttivitaNonProgettuale (id: PosInteger, persona: PosInteger, tipo: LavoroNonProgettuale, giorno: date, oreDurata: NumeroOre)
    [VincoloDB.8] foreign key: persona references Persona(id)

Assenza (id: PosInteger, persona: PosInteger, tipo: CausaAssenza, giorno: date)
    [VincoloDB.9] altra chiave: persona, giorno
    [VincoloDB.10] foreign key: persona references Persona(id)

Definire in SQL le seguenti interrogazioni:
1. Quali sono le persone (id, nome e cognome) che hanno avuto assenze solo nei
giorni in cui non avevano alcuna attivitÃ (progettuali o non progettuali)?
2. Quali sono le persone (id, nome e cognome) che non hanno mai partecipato ad
alcun progetto durante la durata del progetto “Pegasus”?
3. Quali sono id, nome, cognome e stipendio dei ricercatori con stipendio maggiore
di tutti i professori (associati e ordinari)?
4. Quali sono le persone che hanno lavorato su progetti con un budget superiore alla
media dei budget di tutti i progetti?
5. Quali sono i progetti con un budget inferiore allala media, ma con un numero
complessivo di ore dedicate alle attività di ricerca sopra la media?
*/

-- Quali sono le persone (id, nome e cognome) che hanno avuto assenze solo nei giorni in cui non avevano alcuna attività (progettuali o non progettuali)?

SELECT DISTINCT p.id, p.nome, p.cognome
FROM Persona p
WHERE p.id NOT IN (
    SELECT ap.persona
    FROM AttivitaProgetto ap
    UNION
    SELECT anp.persona
    FROM AttivitaNonProgettuale anp
    )
    AND p.id IN (
        SELECT a.persona
        FROM Assenza a
    );
