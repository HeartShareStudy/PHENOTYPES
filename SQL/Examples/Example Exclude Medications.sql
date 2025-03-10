-- Name: HeartShare Example: Exclude sensitive protected medications
-- Author: William H Temps
-- Date: 2025-03-03 Monday
-- Background: Illinois laws including the "Mental Health and Developmental
--   Disabilities Act" (740 ILCS 110/1) and the "AIDS Confidentiality Act"
--   (410 ILCS 305/1) impose restrictions on the collection and sharing of
--   certain health information beyond those of HIPAA.
--   The "Illinois Health Information Exchange and Technology Act"
--   (Public Act 096-1331) also created a regulatory body empowered to
--   "establish and adopt standards and requirements for the use of
--   health information", including collection and sharing.
-- Description: This is an example showing one method of excluding
--   certain medications which might indirectly disclose the presence
--   of conditions protected by the above laws and regulations.
-- Notes:
-- 1. Assumes a database using the OMOP Common Data Model, version 5.4
-- 2. Assumes the database server is Microsoft SQL server. Some
--    adjustments may be needed for other variets of SQL.
--
-- Database name for Northwestern University OMOP CDM instance.
-- TODO: Change to local database or schema name, if different.
USE HeartShare_Prod;
GO
-- ________________________________________________________ Person list
-- TODO: FOR ILLUSTRATION ONLY. REMOVE THIS SECTION.
--
DROP TABLE IF EXISTS #Person_List;
SELECT DISTINCT TOP 19 person_id INTO #Person_List FROM cdm.person;
--
-- ______________________________________________ Get drug concept_id's
-- There are several ways to do this. This is one. It's clumsy and slow,
--   but it's the most comprehensive way to be sure of not missing any
--   of the restricted medications. It's also slow only when building
--   the table of restricted medications. It should be fast when
--   actually extracting data.
--
DROP TABLE IF EXISTS #Excluded_Drugs;
CREATE TABLE #Excluded_Drugs ( drug_concept_id INT PRIMARY KEY, [Drug name] VARCHAR(511) );
INSERT INTO #Excluded_Drugs
SELECT concept_id, concept_name
  FROM cdm.concept
  WHERE (domain_id = 'Drug') AND
(concept_name LIKE '%Abilify%'
OR concept_name LIKE '%agomelatine%'
OR concept_name LIKE '%Alaquet%'
OR concept_name LIKE '%Allegron%'
OR concept_name LIKE '%alprazolam%'
OR concept_name LIKE '%Alventa%'
OR concept_name LIKE '%Alzain%'
OR concept_name LIKE '%amisulpride%'
OR concept_name LIKE '%amitriptyline%'
OR concept_name LIKE '%Amphero%'
OR concept_name LIKE '%Anquil%'
OR concept_name LIKE '%aripiprazole%'
OR concept_name LIKE '%Arpoya%'
OR concept_name LIKE '%asenapine%'
OR concept_name LIKE '%Ativan%'
OR concept_name LIKE '%Atrolak%'
OR concept_name LIKE '%Axalid%'
OR concept_name LIKE '%benperidol%'
OR concept_name LIKE '%Biquelle%'
OR concept_name LIKE '%Brancico%'
OR concept_name LIKE '%Brintellix%'
OR concept_name LIKE '%buspirone%'
OR concept_name LIKE '%Camcolit%'
OR concept_name LIKE '%Carbagen%'
OR concept_name LIKE '%carbamazapine%'
OR concept_name LIKE '%cariprazine%'
OR concept_name LIKE '%Chloractil%'
OR concept_name LIKE '%chloral%hydrate%'
OR concept_name LIKE '%chlordiazepoxide%'
OR concept_name LIKE '%chlormethiazole%'
OR concept_name LIKE '%chlorpromazine%'
OR concept_name LIKE '%Cipralex%'
OR concept_name LIKE '%Cipramil%'
OR concept_name LIKE '%Circadin%'
OR concept_name LIKE '%citalopram%'
OR concept_name LIKE '%clomethiazole%'
OR concept_name LIKE '%clomipramine%'
OR concept_name LIKE '%Clopixol%'
OR concept_name LIKE '%cloral%betaine%'
OR concept_name LIKE '%clozapine%'
OR concept_name LIKE '%Clozaril%'
OR concept_name LIKE '%Cymbalta%'
OR concept_name LIKE '%Denzapine%'
OR concept_name LIKE '%Depakote%'
OR concept_name LIKE '%Depefex%'
OR concept_name LIKE '%Depixol%'
OR concept_name LIKE '%Diazemuls%'
OR concept_name LIKE '%diazepam%'
OR concept_name LIKE '%Dolmatil%'
OR concept_name LIKE '%Dormagen%'
OR concept_name LIKE '%dosulepin%'
OR concept_name LIKE '%doxepin%'
OR concept_name LIKE '%duloxetine%'
OR concept_name LIKE '%Ebesque%'
OR concept_name LIKE '%Edronax%'
OR concept_name LIKE '%Efexor%'
OR concept_name LIKE '%Epilim%'
OR concept_name LIKE '%escitalopram%'
OR concept_name LIKE '%Faverin%'
OR concept_name LIKE '%Fluanxol%'
OR concept_name LIKE '%fluoxetine%'
OR concept_name LIKE '%flupentixol%'
OR concept_name LIKE '%fluphenazine%'
OR concept_name LIKE '%fluvoxamine%'
OR concept_name LIKE '%Foraven%'
OR concept_name LIKE '%Haldol%'
OR concept_name LIKE '%Halkid%'
OR concept_name LIKE '%haloperidol%'
OR concept_name LIKE '%Heminevrin%'
OR concept_name LIKE '%imipramine%'
OR concept_name LIKE '%Invega%'
OR concept_name LIKE '%isocarboxazid%'
OR concept_name LIKE '%Lamictal%'
OR concept_name LIKE '%lamotrigine%'
OR concept_name LIKE '%Largactil%'
OR concept_name LIKE '%Latuda%'
OR concept_name LIKE '%Lecaent%pregabalin%'
OR concept_name LIKE '%levomepromazine%'
OR concept_name LIKE '%Librium%chlordiazepoxide%'
OR concept_name LIKE '%Li-liquid%'
OR concept_name LIKE '%Liskonum%'
OR concept_name LIKE '%lithium%'
OR concept_name LIKE '%lofepramine%'
OR concept_name LIKE '%Lomont%'
OR concept_name LIKE '%loprazolam%'
OR concept_name LIKE '%lorazepam%'
OR concept_name LIKE '%lormetazepam%'
OR concept_name LIKE '%lurasidone%'
OR concept_name LIKE '%Lustral%'
OR concept_name LIKE '%Lyrica%'
OR concept_name LIKE '%Majoven%'
OR concept_name LIKE '%Manerix%'
OR concept_name LIKE '%mianserin%'
OR concept_name LIKE '%Mintreleg%'
OR concept_name LIKE '%mirtazapine%'
OR concept_name LIKE '%moclobemide%'
OR concept_name LIKE '%Modecate%'
OR concept_name LIKE '%Mogadon%'
OR concept_name LIKE '%Molipaxin%'
OR concept_name LIKE '%Nardil%'
OR concept_name LIKE '%Neulactil%'
OR concept_name LIKE '%nitrazepam%'
OR concept_name LIKE '%nortriptyline%'
OR concept_name LIKE '%Nozinan%'
OR concept_name LIKE '%olanzapine%'
OR concept_name LIKE '%Olena%'
OR concept_name LIKE '%Orap%'
OR concept_name LIKE '%Oxactin%'
OR concept_name LIKE '%oxazepam%'
OR concept_name LIKE '%paliperidone%'
OR concept_name LIKE '%Parnate%'
OR concept_name LIKE '%paroxetine%'
OR concept_name LIKE '%pericyazine%'
OR concept_name LIKE '%phenelzine%'
OR concept_name LIKE '%Phenergan%promethazine%'
OR concept_name LIKE '%pimozide%'
OR concept_name LIKE '%Politid%'
OR concept_name LIKE '%pregabalin%'
OR concept_name LIKE '%Priadel%'
OR concept_name LIKE '%prochlorperazine%'
OR concept_name LIKE '%promazine%'
OR concept_name LIKE '%Prothiaden%'
OR concept_name LIKE '%Prozac%'
OR concept_name LIKE '%Prozep%'
OR concept_name LIKE '%Psytoxil%'
OR concept_name LIKE '%quetiapine%'
OR concept_name LIKE '%Reaglia%'
OR concept_name LIKE '%reboxetine%'
OR concept_name LIKE '%Risperdal%'
OR concept_name LIKE '%Risperdal Consta%'
OR concept_name LIKE '%risperidone%'
OR concept_name LIKE '%Seroquel%'
OR concept_name LIKE '%Seroxat%'
OR concept_name LIKE '%sertraline%'
OR concept_name LIKE '%sertraline%'
OR concept_name LIKE '%Sinepin%'
OR concept_name LIKE '%Slenyto%'
OR concept_name LIKE '%Solian%'
OR concept_name LIKE '%Sominex%'
OR concept_name LIKE '%Stelazine%'
OR concept_name LIKE '%Stemetil%'
OR concept_name LIKE '%Stesolid%'
OR concept_name LIKE '%Stilnoct%'
OR concept_name LIKE '%sulpiride%'
OR concept_name LIKE '%Sulpor%'
OR concept_name LIKE '%Sunveniz%'
OR concept_name LIKE '%Surmontil%'
OR concept_name LIKE '%Sycrest%'
OR concept_name LIKE '%Syncrodin%'
OR concept_name LIKE '%Tegretol%'
OR concept_name LIKE '%temazepam%'
OR concept_name LIKE '%Tenprolide%'
OR concept_name LIKE '%Tensium%diazepam%'
OR concept_name LIKE '%tranylcypromine%'
OR concept_name LIKE '%trazodone%'
OR concept_name LIKE '%Trevicta%'
OR concept_name LIKE '%trifluoperazine%'
OR concept_name LIKE '%trimipramine%'
OR concept_name LIKE '%Tropium%'
OR concept_name LIKE '%Valdoxan%'
OR concept_name LIKE '%valproate%'
OR concept_name LIKE '%Venaxx%'
OR concept_name LIKE '%Venlablue%'
OR concept_name LIKE '%Venladex%'
OR concept_name LIKE '%venlafaxine%'
OR concept_name LIKE '%Venlalic%'
OR concept_name LIKE '%Venlasoz%'
OR concept_name LIKE '%Vensir%'
OR concept_name LIKE '%Venzip%'
OR concept_name LIKE '%ViePax%'
OR concept_name LIKE '%vortioxetine%'
OR concept_name LIKE '%Welldorm%chloral%'
OR concept_name LIKE '%Xanax alprazolam%'
OR concept_name LIKE '%Xeplion%'
OR concept_name LIKE '%Zalasta%'
OR concept_name LIKE '%Zaluron%'
OR concept_name LIKE '%Zaponex%'
OR concept_name LIKE '%Zimovane zopiclone%'
OR concept_name LIKE '%Zispin%'
OR concept_name LIKE '%zolpidem%'
OR concept_name LIKE '%zopiclone%'
OR concept_name LIKE '%zuclopenthixol%'
OR concept_name LIKE '%ZypAdhera%'
OR concept_name LIKE '%Zyprexa%'
AND concept_name NOT LIKE '%iprotropium%'
AND concept_name NOT LIKE '%tiotropium%'
AND concept_name NOT LIKE '%tranquility%'
AND concept_name NOT LIKE '%tranquil %'
AND concept_name NOT LIKE '%tranquil-eze%'
AND concept_name NOT LIKE '%tranquil-val%'
AND concept_name <> 'Tranquil'
AND concept_name NOT LIKE '%tranquility%'
AND concept_name NOT LIKE '%tranquil %'
AND concept_name NOT LIKE '%tranquil-eze%'
AND concept_name NOT LIKE '%tranquil-val%'
AND concept_name <> 'Tranquil'
);
--
-- _______________________________________ Get list of drugs per person
-- List all drug exposures for each person in the list, excluding the
--   restricted medications.
-- Note: Includes drug_concept_id 0 with Drug name "No matching concept"
--
SELECT DISTINCT p1.person_id, drugex1.drug_exposure_id, drug_concept_id
  , con1.concept_name AS [Drug name]
  FROM #Person_List p1 -- TODO: Replace with desired list of persons/study subjects
  LEFT OUTER JOIN cdm.drug_exposure drugex1
    ON (p1.person_id = drugex1.person_id)
  INNER JOIN cdm.concept con1
    ON (con1.concept_id = drugex1.drug_concept_id)
  WHERE NOT EXISTS (
    SELECT drug_concept_id FROM #Excluded_Drugs drugex2 WHERE (drugex2.drug_concept_id = drugex1.drug_concept_id)
    );

--
-- ______________________________________________________ ** TESTING **
-- Testing
--
SELECT DISTINCT p1.person_id, drugex1.drug_exposure_id, drug_concept_id
  , con1.concept_name AS [Drug name]
  FROM #Person_List p1 -- TODO: Replace with desired list of persons/study subjects
  LEFT OUTER JOIN cdm.drug_exposure drugex1
    ON (p1.person_id = drugex1.person_id)
  INNER JOIN cdm.concept con1
    ON (con1.concept_id = drugex1.drug_concept_id)
  WHERE EXISTS (
    SELECT drug_concept_id FROM #Excluded_Drugs drugex2 WHERE (drugex2.drug_concept_id = drugex1.drug_concept_id)
    );
--
SELECT DISTINCT TOP 31 p1.person_id, drug_concept_id, con1.concept_name AS [Drug name]
  , con1.domain_id AS [Drug domain], con1.vocabulary_id AS [Drug vocabulary], con1.concept_code
  , drug_type_concept_id, con2.concept_name AS [Drug type], con2.domain_id AS [Type domain]
  , con2.[vocabulary_id] AS [Type vocab]
  , drug_source_value
  , drug_source_concept_id, con3.[concept_name] AS [Drug source], con3.domain_id, con3.vocabulary_id
FROM #Person_List p1
  INNER JOIN cdm.drug_exposure drugex1
    ON (drugex1.person_id = p1.person_id)
  INNER JOIN cdm.concept con1
    ON (drugex1.drug_concept_id = con1.concept_id)
  INNER JOIN cdm.concept con2
    ON (drugex1.drug_type_concept_id = con2.concept_id)
  INNER JOIN cdm.concept con3
    ON (drugex1.drug_source_concept_id = con3.concept_id)
--
-- Drug domain
-- Two possibilities in the drug_exposure table:
-- Domain "Metadata" and vocabulary "None": drug_concept_id is always 0
-- Domain "Drug" and vocabulary "RxNorm"
SELECT DISTINCT TOP 31 con1.domain_id AS [Drug domain], con1.vocabulary_id AS [Drug vocabulary]
  FROM cdm.drug_exposure drugex1
  LEFT OUTER JOIN cdm.concept con1
    ON (drugex1.drug_concept_id = con1.concept_id);
--
SELECT *
  FROM cdm.drug_exposure drugex1
  LEFT OUTER JOIN cdm.concept con1
    ON (drugex1.drug_concept_id = con1.concept_id)
  WHERE ( (con1.domain_id = 'Metadata') AND (drugex1.drug_concept_id != 0) ); -- 0 rows
--
SELECT * FROM cdm.concept WHERE (domain_id = 'Metadata');
--
