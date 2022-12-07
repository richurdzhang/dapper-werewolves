SELECT dac.category, dac.allegation_name, COUNT(*)
FROM data_allegation da JOIN data_allegationcategory dac on da.most_common_category_id = dac.id
WHERE da.is_officer_complaint = false
GROUP BY dac.category, dac.allegation_name
ORDER BY COUNT(*) DESC
LIMIT 10;