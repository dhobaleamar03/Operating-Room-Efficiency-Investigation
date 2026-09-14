-- 1. Total Surgical Volume
-- (How many surgeries were performed during the period covered by the dataset?)
SELECT COUNT(encounter_id) AS total_surgeries
FROM or_utilization;

--2. Operating Room Workload
-- (Which Operating Rooms performed the highest and lowest number of surgeries?)
SELECT
    or_suite,
    COUNT(encounter_id) AS total_surgeries
FROM or_utilization
GROUP BY or_suite
ORDER BY total_surgeries DESC;

-- 3. Specialty Workload Analysis
-- (Which medical specialties performed the highest and lowest number of surgeries?)
SELECT
    service,
    COUNT(encounter_id) AS total_surgeries
FROM or_utilization
GROUP BY service
ORDER BY total_surgeries DESC;

-- 4. Procedure Volume Analysis
-- (Which surgical procedures are performed most frequently?)
SELECT
    cpt_description,
    COUNT(encounter_id) AS total_surgeries
FROM or_utilization
GROUP BY cpt_description
ORDER BY total_surgeries DESC;

-- 5. Actual Procedure Duration
-- (Which surgical procedures take the longest time to complete?)
SELECT
    cpt_description,
    ROUND(AVG(procedure_duration_min), 2) AS avg_duration_min
FROM or_utilization
GROUP BY cpt_description
ORDER BY avg_duration_min DESC
LIMIT 10;

-- 6.Operating Room Occupancy
-- (Which Operating Rooms were occupied for the longest total time?)
SELECT
    or_suite,
    ROUND(SUM(or_occupancy_min) / 60.0, 2) AS total_occupancy_hours
FROM or_utilization
GROUP BY or_suite
ORDER BY total_occupancy_hours DESC;

-- 7.Scheduling Performance
-- (Which operating rooms experience the highest average schedule delay?)
SELECT
    or_suite,
    ROUND(AVG(schedule_delay_min), 2) AS avg_schedule_delay_min
FROM or_utilization
GROUP BY or_suite
ORDER BY avg_schedule_delay_min DESC;

-- 8. Daily Surgery Volume
-- (How many surgeries were performed on each day?)
SELECT
    surgery_date,
    COUNT(encounter_id) AS total_surgeries
FROM or_utilization
GROUP BY surgery_date
ORDER BY surgery_date;

-- average no. of surgeries per day
SELECT
    ROUND(AVG(daily_surgeries), 2) AS avg_daily_surgeries
FROM (
    SELECT
        surgery_date,
        COUNT(encounter_id) AS daily_surgeries
    FROM or_utilization
    GROUP BY surgery_date
) AS daily_summary;

-- 9. Planned vs Actual Procedure
-- (Are surgeries taking longer or shorter than their planned)
SELECT
    ROUND(AVG(booked_time_min), 2) AS avg_booked_time,
    ROUND(AVG(procedure_duration_min), 2) AS avg_actual_duration
FROM or_utilization;

SELECT
    ROUND(AVG(booked_time_min), 2) AS avg_booked_time,
    ROUND(AVG(procedure_duration_min), 2) AS avg_actual_duration,
    ROUND(AVG(procedure_duration_min - booked_time_min), 2) AS avg_difference
FROM or_utilization;

--  Booked Time vs Actual OR Occupancy( for better result than above one)
SELECT
    ROUND(AVG(booked_time_min), 2) AS avg_booked_time,
    ROUND(AVG(or_occupancy_min), 2) AS avg_actual_or_time,
    ROUND(AVG(or_occupancy_min - booked_time_min), 2) AS avg_variance
FROM or_utilization;


-- 10.Surgery Volume by Day of Week
-- (Which day of the week has the highest and lowest surgical volume?)
SELECT
    CASE EXTRACT(DOW FROM surgery_date)
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
    END AS day_of_week,
    COUNT(encounter_id) AS total_surgeries
FROM or_utilization
GROUP BY
    EXTRACT(DOW FROM surgery_date),
    day_of_week
ORDER BY
    EXTRACT(DOW FROM surgery_date);

	
-- 11. Specialty-wise Operating Room Occupancy
-- (Which medical specialties consume the most operating room time?)
SELECT
    service,
    ROUND(SUM(or_occupancy_min) / 60.0, 2) AS total_occupancy_hours
FROM or_utilization
GROUP BY service
ORDER BY total_occupancy_hours DESC;

-- 12. Specialty wise Scheduling Delay
 -- (Which medical specialties have the highest average scheduling delay?)
SELECT
    service,
    ROUND(AVG(schedule_delay_min), 2) AS avg_schedule_delay_min
FROM or_utilization
GROUP BY service
ORDER BY avg_schedule_delay_min DESC;

-- 13. Operating Room Performance Summary
-- (How does each operating room perform across key operational metrics?)

SELECT
    or_suite,
    COUNT(encounter_id) AS total_surgeries,
    ROUND(SUM(or_occupancy_min) / 60.0, 2) AS occupancy_hours,
    ROUND(AVG(schedule_delay_min), 2) AS avg_delay_min
FROM or_utilization
GROUP BY or_suite
ORDER BY or_suite;


SELECT *
FROM or_utilization
LIMIT 10;



