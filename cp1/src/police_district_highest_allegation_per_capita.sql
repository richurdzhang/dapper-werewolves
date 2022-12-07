SELECT daa.area_id, da.name, da.area_type, tp.total_pop, CAST(COUNT(*) as float) / CAST(tp.total_pop as float) as complaints_per_capita
FROM data_allegation_areas daa
JOIN (
   SELECT SUM(count) as total_pop, area_id
   FROM data_racepopulation
   GROUP BY area_id) as tp on daa.area_id = tp.area_id
JOIN data_area da on daa.area_id = da.id
WHERE da.area_type = 'police-districts'
GROUP BY daa.area_id, tp.total_pop, da.name, da.area_type
ORDER BY CAST(COUNT(*) as float) / CAST(tp.total_pop as float) DESC
LIMIT 10;
