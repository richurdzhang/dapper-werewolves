SELECT AVG(allegation_count), AVG(civilian_compliment_count)
FROM data_officer
WHERE data_officer.active = 'Yes';