SELECT daa.area_id, CAST(COUNT(*) as float) / CAST(tp.total_pop as float) as complaints_per_capita
FROM data_allegation_areas daa
JOIN (
   SELECT SUM(count) as total_pop, area_id
   FROM data_racepopulation
   GROUP BY area_id) as tp on daa.area_id = tp.area_id
GROUP BY daa.area_id, tp.total_pop
ORDER BY CAST(COUNT(*) as float) / CAST(tp.total_pop as float) DESC
LIMIT 10;