show databases;
use san_francisco;
show tables;

-- ============================================================
-- 03_VIEWS.SQL
-- Vues principales pour Power BI (6 vues)
-- ============================================================


-- 1. Vue : Nombre total de professions
CREATE VIEW v_nombre_professions AS
SELECT COUNT(DISTINCT Poste) AS nombre_professions
FROM salaires_sf;


-- 2. Vue : Top 10 postes les plus fréquents
CREATE VIEW v_top10_postes_frequents AS
SELECT Poste, COUNT(*) AS occurrences
FROM salaires_sf
GROUP BY Poste
ORDER BY occurrences DESC
LIMIT 10;


-- 3. Vue : Top 10 postes les mieux payés (salaire moyen)
CREATE VIEW v_top10_postes_mieux_payes AS
SELECT Poste, AVG(SalaireBase) AS salaire_moyen
FROM salaires_sf
GROUP BY Poste
ORDER BY salaire_moyen DESC
LIMIT 10;


-- 4. Vue : Top 12 employés avec le SalaireBase le plus élevé
CREATE VIEW top12_employes AS
SELECT 
    Nom_Employé,
    Poste,
    SalaireBase
FROM salaires_sf
ORDER BY SalaireBase DESC
LIMIT 12;


-- 5. Vue : Top postes 10 POSTES avec le plus d'avantages salariaux
CREATE VIEW top_postes_avantages AS
SELECT 
    Poste,
    AVG(Avantages) AS avantages_moyens
FROM salaires_sf
GROUP BY Poste
ORDER BY avantages_moyens DESC
LIMIT 10;


-- 6. Vue : Salaire moyen par année
CREATE VIEW salaire_moyen_annuel AS
SELECT Année, AVG(SalaireBase) AS salaire_moyen
FROM salaires_sf
GROUP BY Année
ORDER BY Année;
