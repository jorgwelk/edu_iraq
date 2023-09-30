/*************************************************************************************
**** EDUCATION IN IRAQ ******************************************* JW, 09.06.2023 ****
*************************************************************************************/


/* overview */

SELECT TOP (10) * FROM IraqEducation..hh	--household data
SELECT TOP (10) * FROM IraqEducation..hl	--individual-level data


/* data preparation */

--keep only households with completed interview
DELETE FROM IraqEducation..hh
WHERE [Result of HH interview] != 'COMPLETED'

--join household & individual-level data
SELECT * 
FROM IraqEducation..hh
LEFT JOIN IraqEducation..hl
ON IraqEducation..hh.[Cluster number] = IraqEducation..hl.[Cluster number]
AND IraqEducation..hh.[Household number] = IraqEducation..hl.[Household number]


/* data exploration */

--highest educational level attended
SELECT [Highest level of education attended], COUNT([Highest level of education attended]) AS FrequencyEducation
FROM IraqEducation..hl
GROUP BY [Highest level of education attended]

--ECE attendance
SELECT [Level of education attended current school year(2017-2018)], COUNT([Level of education attended current school year(2017-2018)]) AS FrequencyECE
FROM IraqEducation..hl
WHERE [Age] BETWEEN 4 AND 5
GROUP BY [Level of education attended current school year(2017-2018)]

--primary school attendance
SELECT [Level of education attended current school year(2017-2018)], COUNT([Level of education attended current school year(2017-2018)]) AS FrequencyPrimary
FROM IraqEducation..hl
WHERE [Age] BETWEEN 7 AND 8
GROUP BY [Level of education attended current school year(2017-2018)]

--secondary school attendance
SELECT [Level of education attended current school year(2017-2018)], COUNT([Level of education attended current school year(2017-2018)]) AS FrequencySecondary
FROM IraqEducation..hl
WHERE [Age] BETWEEN 14 AND 16
GROUP BY [Level of education attended current school year(2017-2018)]


/* generate dummy variables of highest educational level attended */

ALTER TABLE IraqEducation..hl
DROP COLUMN edulevel0, edulevel1, edulevel2, edulevel3, edulevel4, part_ece, part_primary, part_secondary

-- no education

ALTER TABLE IraqEducation..hl
ADD edulevel0 int

UPDATE IraqEducation..hl
   SET edulevel0 = CASE
      WHEN [Highest level of education attended] = 'ECE'
	  OR [Ever attended school or any Early Childhood Education programme] = 'NO'
      THEN 1
	  WHEN [Highest level of education attended] = 'PRIMARY'
	  OR [Highest level of education attended] = 'INTERMEDIATE/LOWER SECONDARY'
	  OR [Highest level of education attended] = 'SECONDARY/ UPPER SECONDARY'
	  OR [Highest level of education attended] = 'DIPLOMA'
	  OR [Highest level of education attended] = 'DIPLOMA (5 YEARS AFTER INTERMEDIATE)'
	  OR [Highest level of education attended] = 'BACHELORS DEGREE'
	  OR [Highest level of education attended] = 'HIGHER EDUCATION'
      THEN 0
	  ELSE NULL
      END

SELECT [edulevel0] FROM IraqEducation..hl

SELECT [edulevel0], COUNT([edulevel0]) AS FrequencyEdulevel0
FROM IraqEducation..hl
WHERE [Year of Birth] BETWEEN 1954 AND 2003
GROUP BY [edulevel0]

/*
SELECT [edulevel0], SUM([Household sample weight]) AS FrequencyEdulevel0
FROM IraqEducation..hl
WHERE [Year of Birth] BETWEEN 1954 AND 2003
GROUP BY [edulevel0]
*/

-- primary education

ALTER TABLE IraqEducation..hl
ADD edulevel1 int

UPDATE IraqEducation..hl
   SET edulevel1 = CASE
	  WHEN [Highest level of education attended] = 'PRIMARY'
      THEN 1
      WHEN [Highest level of education attended] = 'ECE'
	  OR [Ever attended school or any Early Childhood Education programme] = 'NO'
	  OR [Highest level of education attended] = 'INTERMEDIATE/LOWER SECONDARY'
	  OR [Highest level of education attended] = 'SECONDARY/ UPPER SECONDARY'
	  OR [Highest level of education attended] = 'DIPLOMA'
	  OR [Highest level of education attended] = 'DIPLOMA (5 YEARS AFTER INTERMEDIATE)'
	  OR [Highest level of education attended] = 'BACHELORS DEGREE'
	  OR [Highest level of education attended] = 'HIGHER EDUCATION'
      THEN 0
	  ELSE NULL
      END

SELECT [edulevel1] FROM IraqEducation..hl

SELECT [edulevel1], COUNT([edulevel1]) AS FrequencyEdulevel1
FROM IraqEducation..hl
WHERE [Year of Birth] BETWEEN 1954 AND 2003
GROUP BY [edulevel1]

-- lower secondary education

ALTER TABLE IraqEducation..hl
ADD edulevel2 int

UPDATE IraqEducation..hl
   SET edulevel2 = CASE
	  WHEN [Highest level of education attended] = 'INTERMEDIATE/LOWER SECONDARY'
      THEN 1
      WHEN [Highest level of education attended] = 'ECE'
	  OR [Ever attended school or any Early Childhood Education programme] = 'NO'
	  OR [Highest level of education attended] = 'PRIMARY'
	  OR [Highest level of education attended] = 'SECONDARY/ UPPER SECONDARY'
	  OR [Highest level of education attended] = 'DIPLOMA'
	  OR [Highest level of education attended] = 'DIPLOMA (5 YEARS AFTER INTERMEDIATE)'
	  OR [Highest level of education attended] = 'BACHELORS DEGREE'
	  OR [Highest level of education attended] = 'HIGHER EDUCATION'
      THEN 0
	  ELSE NULL
      END

SELECT [edulevel2] FROM IraqEducation..hl

SELECT [edulevel2], COUNT([edulevel2]) AS FrequencyEdulevel2
FROM IraqEducation..hl
WHERE [Year of Birth] BETWEEN 1954 AND 2003
GROUP BY [edulevel2]

-- upper secondary education

ALTER TABLE IraqEducation..hl
ADD edulevel3 int

UPDATE IraqEducation..hl
   SET edulevel3 = CASE
	  WHEN [Highest level of education attended] = 'SECONDARY/ UPPER SECONDARY'
      THEN 1
      WHEN [Highest level of education attended] = 'ECE'
	  OR [Ever attended school or any Early Childhood Education programme] = 'NO'
	  OR [Highest level of education attended] = 'PRIMARY'
	  OR [Highest level of education attended] = 'INTERMEDIATE/LOWER SECONDARY'
	  OR [Highest level of education attended] = 'DIPLOMA'
	  OR [Highest level of education attended] = 'DIPLOMA (5 YEARS AFTER INTERMEDIATE)'
	  OR [Highest level of education attended] = 'BACHELORS DEGREE'
	  OR [Highest level of education attended] = 'HIGHER EDUCATION'
      THEN 0
	  ELSE NULL
      END

SELECT [edulevel3] FROM IraqEducation..hl

SELECT [edulevel3], COUNT([edulevel3]) AS FrequencyEdulevel3
FROM IraqEducation..hl
WHERE [Year of Birth] BETWEEN 1954 AND 2003
GROUP BY [edulevel3]

-- higher education

ALTER TABLE IraqEducation..hl
ADD edulevel4 int

UPDATE IraqEducation..hl
   SET edulevel4 = CASE
	  WHEN [Highest level of education attended] = 'DIPLOMA'
	  OR [Highest level of education attended] = 'DIPLOMA (5 YEARS AFTER INTERMEDIATE)'
	  OR [Highest level of education attended] = 'BACHELORS DEGREE'
	  OR [Highest level of education attended] = 'HIGHER EDUCATION'
      THEN 1
      WHEN [Highest level of education attended] = 'ECE'
	  OR [Ever attended school or any Early Childhood Education programme] = 'NO'
	  OR [Highest level of education attended] = 'PRIMARY'
	  OR [Highest level of education attended] = 'INTERMEDIATE/LOWER SECONDARY'
	  OR [Highest level of education attended] = 'SECONDARY/ UPPER SECONDARY'
      THEN 0
	  ELSE NULL
      END

SELECT [edulevel4] FROM IraqEducation..hl

SELECT [edulevel4], COUNT([edulevel4]) AS FrequencyEdulevel4
FROM IraqEducation..hl
WHERE [Year of Birth] BETWEEN 1954 AND 2003
GROUP BY [edulevel4]


/* generate dummy variables of educational participation */

-- ECE participation

ALTER TABLE IraqEducation..hl
ADD part_ece int

UPDATE IraqEducation..hl
   SET part_ece = CASE
	  WHEN [Level of education attended current school year(2017-2018)] = 'ECE'
      THEN 1
      WHEN [Ever attended school or any Early Childhood Education programme] = 'NO'
	  OR [Attended school during current school year(2017-2018)] = 'NO'
	  OR [Level of education attended current school year(2017-2018)] = 'PRIMARY'
	  OR [Level of education attended current school year(2017-2018)] = 'INTERMEDIATE/LOWER SECONDARY'
	  OR [Level of education attended current school year(2017-2018)] = 'SECONDARY/ UPPER SECONDARY'
	  OR [Level of education attended current school year(2017-2018)] = 'DIPLOMA'
	  OR [Level of education attended current school year(2017-2018)] = 'DIPLOMA (5 YEARS AFTER INTERMEDIATE)'
	  OR [Level of education attended current school year(2017-2018)] = 'BACHELORS DEGREE'
	  OR [Level of education attended current school year(2017-2018)] = 'HIGHER EDUCATION'
      THEN 0
	  ELSE NULL
      END

SELECT [part_ece] FROM IraqEducation..hl

SELECT [part_ece], COUNT([part_ece]) AS FrequencyEdulevel3
FROM IraqEducation..hl
WHERE [Age] BETWEEN 4 AND 5
GROUP BY [part_ece]

-- primary school participation

ALTER TABLE IraqEducation..hl
ADD part_primary int

UPDATE IraqEducation..hl
   SET part_primary = CASE
	  WHEN [Level of education attended current school year(2017-2018)] = 'PRIMARY'
      THEN 1
      WHEN [Ever attended school or any Early Childhood Education programme] = 'NO'
	  OR [Attended school during current school year(2017-2018)] = 'NO'
	  OR [Level of education attended current school year(2017-2018)] = 'ECE'
	  OR [Level of education attended current school year(2017-2018)] = 'INTERMEDIATE/LOWER SECONDARY'
	  OR [Level of education attended current school year(2017-2018)] = 'SECONDARY/ UPPER SECONDARY'
	  OR [Level of education attended current school year(2017-2018)] = 'DIPLOMA'
	  OR [Level of education attended current school year(2017-2018)] = 'DIPLOMA (5 YEARS AFTER INTERMEDIATE)'
	  OR [Level of education attended current school year(2017-2018)] = 'BACHELORS DEGREE'
	  OR [Level of education attended current school year(2017-2018)] = 'HIGHER EDUCATION'
      THEN 0
	  ELSE NULL
      END

SELECT [part_primary] FROM IraqEducation..hl

SELECT [part_primary], COUNT([part_primary]) AS FrequencyEdulevel3
FROM IraqEducation..hl
WHERE [Age] BETWEEN 7 AND 8
GROUP BY [part_primary]

-- secondary school participation

ALTER TABLE IraqEducation..hl
ADD part_secondary int


UPDATE IraqEducation..hl
   SET part_secondary = CASE
	  WHEN [Level of education attended current school year(2017-2018)] = 'PRIMARY'
	  OR [Level of education attended current school year(2017-2018)] = 'SECONDARY/ UPPER SECONDARY'
	  OR [Level of education attended current school year(2017-2018)] = 'INTERMEDIATE/LOWER SECONDARY'
	  OR [Level of education attended current school year(2017-2018)] = 'DIPLOMA'
	  OR [Level of education attended current school year(2017-2018)] = 'DIPLOMA (5 YEARS AFTER INTERMEDIATE)'
	  OR [Level of education attended current school year(2017-2018)] = 'BACHELORS DEGREE'
	  OR [Level of education attended current school year(2017-2018)] = 'HIGHER EDUCATION'
      THEN 1
      WHEN [Ever attended school or any Early Childhood Education programme] = 'NO'
	  OR [Attended school during current school year(2017-2018)] = 'NO'
	  OR [Level of education attended current school year(2017-2018)] = 'ECE'
      THEN 0
	  ELSE NULL
      END

SELECT [part_secondary] FROM IraqEducation..hl

SELECT [part_secondary], COUNT([part_secondary]) AS FrequencyEdulevel3
FROM IraqEducation..hl
WHERE [Age] BETWEEN 14 AND 16
GROUP BY [part_secondary]


/* calculate relative frequencies by region and store as new table */

WITH
cte_levels AS (
	SELECT [Region/Governorate], 
	CAST(SUM(edulevel0 * [Household sample weight]) / SUM([Household sample weight]) AS FLOAT)*100 AS avg_edulevel0,
	CAST(SUM(edulevel1 * [Household sample weight]) / SUM([Household sample weight]) AS FLOAT)*100 AS avg_edulevel1,
	CAST(SUM(edulevel2 * [Household sample weight]) / SUM([Household sample weight]) AS FLOAT)*100 AS avg_edulevel2,
	CAST(SUM(edulevel3 * [Household sample weight]) / SUM([Household sample weight]) AS FLOAT)*100 AS avg_edulevel3,
	CAST(SUM(edulevel4 * [Household sample weight]) / SUM([Household sample weight]) AS FLOAT)*100 AS avg_edulevel4
	FROM IraqEducation..hl
	WHERE [Year of Birth] BETWEEN 1954 AND 2003
	GROUP BY [Region/Governorate]
	),
cte_ece AS (
	SELECT [Region/Governorate], 
	CAST(SUM(part_ece * [Household sample weight]) / SUM([Household sample weight]) AS FLOAT)*100 AS avg_part_ece
	FROM IraqEducation..hl
	WHERE [Age] BETWEEN 4 AND 5
	GROUP BY [Region/Governorate]
	),
cte_primary AS (
	SELECT [Region/Governorate], 
	CAST(SUM(part_primary * [Household sample weight]) / SUM([Household sample weight]) AS FLOAT)*100 AS avg_part_primary
	FROM IraqEducation..hl
	WHERE [Age] BETWEEN 7 AND 8
	GROUP BY [Region/Governorate]
	),
cte_secondary AS (
	SELECT [Region/Governorate], 
	CAST(SUM(part_secondary * [Household sample weight]) / SUM([Household sample weight]) AS FLOAT)*100 AS avg_part_secondary
	FROM IraqEducation..hl
	WHERE [Age] BETWEEN 14 AND 16
	GROUP BY [Region/Governorate]
	)
SELECT cte_levels.[Region/Governorate], cte_levels.avg_edulevel0, cte_levels.avg_edulevel1,
	cte_levels.avg_edulevel2, cte_levels.avg_edulevel3, cte_levels.avg_edulevel4,
	cte_ece.avg_part_ece, cte_primary.avg_part_primary, cte_secondary.avg_part_secondary
INTO IraqEducation..RegioFreq
FROM cte_levels
	JOIN cte_ece ON cte_ece.[Region/Governorate] = cte_levels.[Region/Governorate]
    JOIN cte_primary ON cte_primary.[Region/Governorate] = cte_levels.[Region/Governorate]
    JOIN cte_secondary ON cte_secondary.[Region/Governorate] = cte_levels.[Region/Governorate]


SELECT * FROM IraqEducation..RegioFreq

--control if sum of edulevel columns = 100 percent
SELECT avg_edulevel0 + avg_edulevel1 + avg_edulevel2 + avg_edulevel3 + avg_edulevel4 FROM IraqEducation..RegioFreq

--region: merge code

ALTER TABLE IraqEducation..RegioFreq
DROP COLUMN pcode

ALTER TABLE IraqEducation..RegioFreq
ADD pcode varchar(5)

UPDATE IraqEducation..RegioFreq
   SET pcode = CASE
      WHEN [Region/Governorate] = 'ANBAR' THEN 'IQG01'
      WHEN [Region/Governorate] = 'BABIL' THEN 'IQG07'
      WHEN [Region/Governorate] = 'BAGHDAD' THEN 'IQG08'
      WHEN [Region/Governorate] = 'BASRAH' THEN 'IQG02'
      WHEN [Region/Governorate] = 'DIALA' THEN 'IQG10'
      WHEN [Region/Governorate] = 'DUHOK' THEN 'IQG09'
      WHEN [Region/Governorate] = 'ERBIL' THEN 'IQG11'
      WHEN [Region/Governorate] = 'KARBALAH' THEN 'IQG12'
      WHEN [Region/Governorate] = 'KIRKUK' THEN 'IQG13'
      WHEN [Region/Governorate] = 'MISAN' THEN 'IQG14'
      WHEN [Region/Governorate] = 'MUTHANA' THEN 'IQG03'
      WHEN [Region/Governorate] = 'NAINAWA' THEN 'IQG15'
      WHEN [Region/Governorate] = 'NAJAF' THEN 'IQG04'
      WHEN [Region/Governorate] = 'QADISYAH' THEN 'IQG05'
      WHEN [Region/Governorate] = 'SALAHADDIN' THEN 'IQG16'
      WHEN [Region/Governorate] = 'SULAIMANIYA' THEN 'IQG06'
      WHEN [Region/Governorate] = 'THIQAR' THEN 'IQG17'
      WHEN [Region/Governorate] = 'WASIT' THEN 'IQG18'
      END

/* Alter Versuch ohne Gewichtung
/* calculate relative frequencies by region and store as new table */

WITH
cte_levels AS (
	SELECT [Region/Governorate], 
	AVG(CAST(edulevel0 AS FLOAT))*100 AS avg_edulevel0, 
	AVG(CAST(edulevel1 AS FLOAT))*100 AS avg_edulevel1, 
	AVG(CAST(edulevel2 AS FLOAT))*100 AS avg_edulevel2, 
	AVG(CAST(edulevel3 AS FLOAT))*100 AS avg_edulevel3, 
	AVG(CAST(edulevel4 AS FLOAT))*100 AS avg_edulevel4
	FROM IraqEducation..hl
	WHERE [Year of Birth] BETWEEN 1954 AND 2003
	GROUP BY [Region/Governorate]
	),
cte_ece AS (
	SELECT [Region/Governorate], 
	AVG(CAST(part_ece AS FLOAT))*100 AS avg_part_ece
	FROM IraqEducation..hl
	WHERE [Age] BETWEEN 4 AND 5
	GROUP BY [Region/Governorate]
	),
cte_primary AS (
	SELECT [Region/Governorate], 
	AVG(CAST(part_primary AS FLOAT))*100 AS avg_part_primary
	FROM IraqEducation..hl
	WHERE [Age] BETWEEN 7 AND 8
	GROUP BY [Region/Governorate]
	),
cte_secondary AS (
	SELECT [Region/Governorate], 
	AVG(CAST(part_secondary AS FLOAT))*100 AS avg_part_secondary
	FROM IraqEducation..hl
	WHERE [Age] BETWEEN 14 AND 16
	GROUP BY [Region/Governorate]
	)
SELECT cte_levels.[Region/Governorate], cte_levels.avg_edulevel0, cte_levels.avg_edulevel1,
	cte_levels.avg_edulevel2, cte_levels.avg_edulevel3, cte_levels.avg_edulevel4,
	cte_ece.avg_part_ece, cte_primary.avg_part_primary, cte_secondary.avg_part_secondary
INTO IraqEducation..RegioFreq
FROM cte_levels
	JOIN cte_ece ON cte_ece.[Region/Governorate] = cte_levels.[Region/Governorate]
    JOIN cte_primary ON cte_primary.[Region/Governorate] = cte_levels.[Region/Governorate]
    JOIN cte_secondary ON cte_secondary.[Region/Governorate] = cte_levels.[Region/Governorate]
