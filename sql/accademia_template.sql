/*
• Strutturato:
    enum (’Ricercatore’, ’Professore Associato’, ’Professore Ordinario’)
• LavoroProgetto:
    enum (’Ricerca e Sviluppo’, ’Dimostrazione’, ’Management’, ’Altro’)
• LavoroNonProgettuale:
    enum (’Didattica’, ’Ricerca’, ’Missione’, ’Incontro Dipartimentale’, ’Incontro Accademico’, ’Altro’)
• CausaAssenza:
    enum (’Chiusura Universitaria’, ’Maternita’, ’Malattia’)
• PosInteger:
    integer ≥ 0
• StringaM:
    varchar(100)
• NumeroOre:
    integer tra 0 e 8
• Denaro:
    real ≥ 0

Persona (id: PosInteger, nome: StringaM, cognome: StringaM, posizione: Strutturato, stipendio: Denaro)

Progetto (id: PosInteger, nome: StringaM, inizio: date, fine: date, budget:Denaro)
    [VincoloDB.1] altra chiave: (nome)
  cialo3   [VincoloDB.3] ennupla: inizio < fine
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
*/