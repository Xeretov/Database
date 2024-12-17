-- Query 1.
-- Quali sono le compagnie che hanno voli che atterrano in
-- un qualche aeroporto di New York [3 punti]
select distinct ap.comp as Compagnia
from arrpart ap, luogoAeroporto la
where ap.arrivo = la.aeroporto or ap.partenza = la.aeroporto and la.citta = 'New York';

-- Query 2.
-- Qual è la durata media di un volo di ogni compagnia
-- (restituire nome della compagnia e durata media dei suoi voli) [3 punti]
select distinct comp as Compagnia, avg(durataMinuti) as Durata_media
from volo
group by comp;

-- Query 3.
-- Quali sono gli aeroporti (restituire, nome e città) situati in Germania [2 punti]
select a.nome, la.citta
from luogoaeroporto la, aeroporto a
where la.aeroporto = a.codice and la.nazione = 'Germania';

-- Query 4.
-- Quali sono le compagnie (restituire nome e anno di fondazione)
-- che hanno voli di durata di meno di 3 ore [3 punti]
select distinct c.nome, c.annoFondaz as Anno_Fondazione
from compagnia c, volo v
where v.comp = c.nome and v.durataMinuti < 180;

-- Query 5.
-- Quante sono le compagnie aeree di cui si conosce l’anno di fondazione [2 punti]
select distinct count(nome) as N_compagnie
from compagnia
where annoFondaz is not null;

-- Query 6.
-- Quante sono le compagnie aeree fondate ogni anno.
-- Per ogni anno nel quale è stata fondata almeno una
-- compagnia, restituire l’anno e il numero di compagnie
-- fondate in quell’anno [3 punti]
select annoFondaz as Anno, count(nome) as N_compagnie
from compagnia
where annoFondaz is not null
group by annoFondaz;

-- Query 7.
-- Quali sono i piani di volo con un cambio che collegano
-- Roma a New York in al più 6 ore (escludendo il tempo del cambio) [4 punti]
select distinct ap1.codice, ap1.comp as Compagnia, ap1.partenza as Partenza, ap1.arrivo as Arrivo, ap2.codice, ap2.comp as Compagnia, ap2.partenza as Partenza, ap2.arrivo as Arrivo
from arrpart ap1, arrpart ap2, luogoAeroporto l1, luogoAeroporto l2, volo v1, volo v2
where ap1.partenza = l1.aeroporto and l1.citta = 'Roma' and ap1.arrivo = ap2.partenza and l1.aeroporto <> l2.aeroporto
and ap2.arrivo = l2.aeroporto and l2.citta = 'New York' and ap1.comp = v1.comp and ap2.comp = v2.comp and v1.durataMinuti+v2.durataMinuti <= 360;

-- Query 8.
-- Quanti sono, in totale, i piani di volo con un cambio (con entrambi i voli della stessa compagnia)
-- che collegano Roma a New York in meno di 6 ore [4 punti]
with scalo as(
    select distinct ap1.codice, ap1.comp as Compagnia, ap1.partenza as Partenza, ap1.arrivo as Arrivo, ap2.codice, ap2.comp as Compagnia, ap2.partenza as Partenza, ap2.arrivo as Arrivo
    from arrpart ap1, arrpart ap2, luogoAeroporto l1, luogoAeroporto l2, volo v1, volo v2
    where ap1.partenza = l1.aeroporto and l1.citta = 'Roma' and ap1.arrivo = ap2.partenza and l1.aeroporto <> l2.aeroporto
    and ap2.arrivo = l2.aeroporto and l2.citta = 'New York' and ap1.comp = v1.comp and ap2.comp = v2.comp and v1.durataMinuti+v2.durataMinuti <= 360
    and ap1.comp = ap2.comp
) select count(*) as N_piani
from scalo;

-- Query 9.
-- Quali sono i piani di volo con un cambio in Olanda e voli
-- della stessa compagnia che collegano Roma a New York in
-- meno di 6 ore di volo (escludendo il tempo di cambio).
-- Ordinare i voli per nome della compagnia crescente [4 punti]
select distinct ap1.codice, ap1.comp as Compagnia, ap1.partenza as Partenza, ap1.arrivo as Arrivo, ap2.codice, ap2.comp as Compagnia, ap2.partenza as Partenza, ap2.arrivo as Arrivo
from arrpart ap1, arrpart ap2, luogoAeroporto l1, luogoAeroporto l2, luogoAeroporto l3, volo v1, volo v2
where ap1.partenza = l1.aeroporto and l1.citta = 'Roma' and ap1.arrivo = ap2.partenza and ap1.arrivo = l3.aeroporto and l1.aeroporto <> l2.aeroporto
and ap2.arrivo = l2.aeroporto and l2.citta = 'New York' and ap1.comp = v1.comp and ap2.comp = v2.comp and v1.durataMinuti+v2.durataMinuti <= 360
and ap1.comp = ap2.comp and l3.nazione = 'Olanda';

-- Query 10.
-- Qual è l’anno nel quale è stata fondata l’ultima
-- compagnia aerea presente nel db [2 punti]
select max(annoFondaz) as Anno
from compagnia;