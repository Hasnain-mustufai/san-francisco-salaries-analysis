show databases;
use san_francisco;
show tables;

-- ============================================================
-- 02_ANALYSES.SQL
-- Analyses business pour extraire des insights du dataset
-- ============================================================


-- 1. NOMBRE TOTAL DES PROFESSIONS 
SELECT COUNT(DISTINCT Poste) AS nombre_professions
FROM salaires_sf;


-- 2. LES 10 POSTES LES PLUS FREQUENTS 
SELECT Poste, COUNT(*) AS occurrences
FROM salaires_sf
GROUP BY Poste
ORDER BY occurrences DESC
LIMIT 10;


-- 4. Top 10 des postes les mieux payés (salaire moyen)
SELECT Poste, AVG(SalaireBase) AS salaire_moyen
FROM salaires_sf
GROUP BY Poste
ORDER BY salaire_moyen DESC
LIMIT 10;


-- 3. SalaireBase / HeuresSup / SalaireTotal moyen pour tous les employés
SELECT 
    AVG(SalaireBase) AS salaire_base_moyen,
    AVG(HeuresSup) AS heures_supp_moyenne,
    AVG(SalaireTotal) AS salaire_total_moyen
FROM salaires_sf;


-- 4. Top 10% des salaires (hauts revenus)
SELECT *
FROM (
    SELECT 
        s.*,
        CUME_DIST() OVER (ORDER BY SalaireBase) AS cd
    FROM salaires_sf AS s
) AS t
WHERE cd >= 0.9
ORDER BY SalaireBase DESC;


-- 5. Classement global des employés par salaire
SELECT Nom_Employé, Poste, SalaireBase
FROM salaires_sf
ORDER BY SalaireBase DESC
LIMIT 12;


-- 6. Classement des employés par métier (Window Function)
SELECT 
    Nom_Employé,
    Poste,
    SalaireBase,
    RANK() OVER (PARTITION BY Poste ORDER BY SalaireBase DESC) AS rang_dans_poste
FROM salaires_sf;


-- 7. Évolution du salaire moyen par année
SELECT Année, AVG(SalaireBase) AS salaire_moyen
FROM salaires_sf
GROUP BY Année
ORDER BY Année;


-- 8. Salaire total vs avantages (impact des avantages)
SELECT 
    Poste,
    AVG(Avantages) AS avg_avantages,
    AVG(SalaireTotal) AS moyen_salaire_total
FROM salaires_sf
GROUP BY Poste
ORDER BY avg_avantages DESC
LIMIT 10;


-- 9. TOP 10 des postes avec le plus d'avantages salariaux
SELECT 
    Poste,
    AVG(Avantages) AS avantages_moyens
FROM salaires_sf
GROUP BY Poste
ORDER BY avantages_moyens DESC
LIMIT 10;
