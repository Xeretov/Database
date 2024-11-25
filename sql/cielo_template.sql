/*
• PosInteger:
    integer ≥ 0
• StringaM:
    varchar(100)
• CodIATA:
    char(3)

Volo (codice: PosInteger, comp: StringaM, durataMinuti: PosInteger)
    [VincoloDB.1] foreign key: comp references Compagnia(nome)
    [VincoloDB.2] foreign key: (codice, comp) references ArrPart(codice, comp)

ArrPart (codice: PosInteger, comp: StringaM, arrivo: CodIATA, partenza: CodIATA)
    [VincoloDB.3] foreign key: (codice, comp) references Volo(codice, comp)
    [VincoloDB.4] foreign key: arrivo references Aeroporto(codice)
    [VincoloDB.5] foreign key: partenza references Peroporto(codice)

Aeroporto (codice: CodIATA, nome: StringaM)
    [VincoloDB.6] foreign key: codice references LuogoAeroporto(aeroporto)

LuogoAeroporto (aeroporto: CodIATA, citta: StringaM, nazione: StringaM)
    [VincoloDB.7] foreign key: aeroporto references Aeroporto(codice)

Compagnia (nome: StringaM, annoFondaz*: PosInteger)
*/