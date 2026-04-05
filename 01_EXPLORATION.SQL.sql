show databases;
use	san_francisco;
show tables;

-- ============================================================
-- 01_EXPLORATION.SQL
-- Explorations initiales pour comprendre la structure des données
-- Objectif : vérifier la qualité, la structure et l'intégrité du dataset
-- ============================================================

use salaires_sf;
select * from salaires_sf limit 5;
 -- ---------------------------
 -- 1. Nombre total de lignes 
 -- --------------------------
 SELECT COUNT(*) AS nombre_total
FROM salaires_sf;
-- ----------------------
-- 2. Vérifier les valeurs distinctes par colonne (catégorielles)
-- ----------------------
SELECT 
    COUNT(DISTINCT Poste) AS distinct_poste,
    COUNT(DISTINCT Agence) AS distinct_agence,
    COUNT(DISTINCT Année) AS distinct_annee
FROM salaires_sf;

-- ----------------------
-- 3. Taille de la table (en Ko / Mo)
-- ----------------------
SELECT 
    table_name,
    ROUND((data_length + index_length) / 1024, 2) AS taille_Ko,
    ROUND((data_length + index_length) / 1024 / 1024, 2) AS taille_Mo
FROM information_schema.tables
WHERE table_name = 'salaires_sf';

-- ----------------------
-- 4. Types des colonnes/Noms
-- ----------------------
DESCRIBE salaires_sf;
-- ----------------------
-- 5.  Valeurs non nulles par colonne (qualité des données)
-- ----------------------
SELECT
    COUNT(Agence) AS Agence_ok,
    COUNT(Année) AS Annee_ok,
    COUNT(AutresPaiements) AS AutresPaiements_ok,
    COUNT(Avantages) AS Avantages_ok,
    COUNT(HeuresSup) AS HeuresSup_ok,
    COUNT(Id) AS Id_ok,
    COUNT(Nom_Employé) AS Nom_Employe_ok,
    COUNT(Poste) AS Poste_ok,
    COUNT(SalaireBase) AS SalaireBase_ok,
    COUNT(SalaireTotal) AS SalaireTotal_ok,
    COUNT(SalaireTotalAvantages) AS SalaireTotalAvantages_ok
FROM salaires_sf;

-- ----------------------
-- 6. Valeurs fréquentes (distribution des postes) (Views)
-- ----------------------
SELECT Poste, COUNT(*) 
FROM salaires_sf
GROUP BY Poste
ORDER BY COUNT(*) DESC;
-- ----------------------
-- 7. detection des fraudes
-- ----------------------
 SELECT *
FROM salaires_sf
WHERE SalaireTotal < SalaireBase;

-- ------------
-- 8 Avantages négatifs (impossible)
-- ------------
SELECT *
FROM salaires_sf
WHERE Avantages < 0;

-- ----------------------
-- 9. les Statistiques numériques
-- ----------------------
SELECT 
    MIN(SalaireBase) AS min_salary,
    MAX(SalaireBase) AS max_salary,
    AVG(SalaireBase) AS avg_salary,
    STD(SalaireBase) AS std_salary
FROM salaires_sf;


-- Anomalies à corriger
-- supprimer les  occurence qui ont une salaire de base Null & 0 

-- Anomalie 

SET SQL_SAFE_UPDATES = 0;

DELETE FROM salaires_sf
WHERE SalaireBase IS NULL
   OR SalaireBase = 0;
   
 --  Les lignes supprimées contenaient des salaires impossibles à analyser (NULL ou 0).
  
SET SQL_SAFE_UPDATES = 1; 

