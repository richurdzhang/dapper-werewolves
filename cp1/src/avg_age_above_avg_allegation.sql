SELECT AVG(2022 - birth_year)
FROM data_officer
WHERE active = 'Yes'
 AND allegation_count > (SELECT AVG(allegation_count) FROM data_officer);