SELECT da.name as police_district,
    CAST(CAST(COUNT(*) as float) / CAST(tp.total_pop as float) as decimal(16,2)) as complaints_pc,
    CAST(CAST(bp.Black_population as float) / CAST(tp.total_pop as float) as decimal(16,2)) as p_Black,
    CAST(CAST(hp.Hispanic_population as float) / CAST(tp.total_pop as float) as decimal(16,2)) as p_Hispanic,
    CAST(CAST(ap.Asian_population as float) / CAST(tp.total_pop as float) as decimal(16,2)) as p_Asian,
    CAST(CAST(wp.White_population as float) / CAST(tp.total_pop as float) as decimal(16,2)) as p_White,
    CAST(CAST(op.Other_population as float) / CAST(tp.total_pop as float) as decimal(16,2)) as p_Other
FROM data_allegation_areas daa
JOIN (
    SELECT SUM(count) as total_pop, area_id
    FROM data_racepopulation
    GROUP BY area_id) as tp on daa.area_id = tp.area_id
JOIN (
    SELECT count as Black_population, area_id
    FROM data_racepopulation
    WHERE race = 'Black') as bp on daa.area_id = bp.area_id
JOIN (
    SELECT count as Hispanic_population, area_id
    FROM data_racepopulation
    WHERE race = 'Hispanic') as hp on daa.area_id = hp.area_id
JOIN (
    SELECT count as White_population, area_id
    FROM data_racepopulation
    WHERE race = 'White') as wp on daa.area_id = wp.area_id
JOIN (
    SELECT count as Asian_population, area_id
    FROM data_racepopulation
    WHERE race = 'Asian') as ap on daa.area_id = ap.area_id
JOIN (
    SELECT count as Other_population, area_id
    FROM data_racepopulation
    WHERE race = 'Asian') as op on daa.area_id = op.area_id
JOIN data_area da on daa.area_id = da.id
WHERE da.area_type = 'police-districts'
GROUP BY daa.area_id, tp.total_pop, da.name, da.area_type, bp.Black_population, hp.Hispanic_population, wp.White_population, ap.Asian_population, op.Other_population
ORDER BY CAST(COUNT(*) as float) / CAST(tp.total_pop as float) DESC
LIMIT 10;