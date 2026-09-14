SELECT COUNT(*) AS Total_records
FROM or_utilization;

SELECT COUNT(DISTINCT(encounter_id)) AS distinct_id
FROM or_utilization;

SELECT *
FROM or_utilization
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    COUNT(CASE WHEN encounter_id IS NULL THEN 1 END) AS encounter_id_nulls,
    COUNT(CASE WHEN surgery_date IS NULL THEN 1 END) AS surgery_date_nulls,
    COUNT(CASE WHEN or_suite IS NULL THEN 1 END) AS or_suite_nulls,
    COUNT(CASE WHEN service IS NULL THEN 1 END) AS service_nulls,
    COUNT(CASE WHEN cpt_code IS NULL THEN 1 END) AS cpt_code_nulls,
    COUNT(CASE WHEN cpt_description IS NULL THEN 1 END) AS cpt_description_nulls,
    COUNT(CASE WHEN booked_time_min IS NULL THEN 1 END) AS booked_time_min_nulls,
    COUNT(CASE WHEN or_schedule IS NULL THEN 1 END) AS or_schedule_nulls,
    COUNT(CASE WHEN wheels_in IS NULL THEN 1 END) AS wheels_in_nulls,
    COUNT(CASE WHEN start_time IS NULL THEN 1 END) AS start_time_nulls,
    COUNT(CASE WHEN end_time IS NULL THEN 1 END) AS end_time_nulls,
    COUNT(CASE WHEN wheels_out IS NULL THEN 1 END) AS wheels_out_nulls
FROM or_utilization;

SELECT encounter_id, COUNT(*) AS duplicate_count
FROM or_utilization
GROUP BY encounter_id
HAVING COUNT(*) > 1;

-- buisness rule validations check
-- Validate Booked Time ( non zero)
SELECT *
FROM or_utilization
WHERE booked_time_min <= 0;

--Validate Surgery Timeline
-- as usual or schdule> wheels in > start time > end time > wheels out 

--Rule 1 — Start Time should be after Wheels In
SELECT *
FROM or_utilization
WHERE start_time < wheels_in;

-- Rule 2 — End Time should be after Start Time
SELECT *
FROM or_utilization
WHERE end_time < start_time;

--Rule 3 — Wheels Out should be after End Time
SELECT *
FROM or_utilization
WHERE wheels_out < end_time;

-- The dataset passed all structural, completeness, uniqueness, 
--and business rule validation checks.

SELECT *
FROM or_utilization
LIMIT 10;
