CREATE TABLE or_utilization (
    encounter_id INT PRIMARY KEY,
    surgery_date DATE,
    or_suite INTEGER,
    service VARCHAR(100),
    cpt_code INTEGER,
    cpt_description TEXT,
    booked_time_min INTEGER,
    or_schedule TIMESTAMP,
    wheels_in TIMESTAMP,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    wheels_out TIMESTAMP
);

-- derived coulmns for easy insight retirval

-- Procedure Duration coulmn
-- Actual time taken to perform the surgery, i.e start time to end time and its duration
ALTER TABLE or_utilization
ADD COLUMN procedure_duration_min INTEGER;

UPDATE or_utilization
SET procedure_duration_min = EXTRACT(EPOCH FROM (end_time - start_time)) / 60;

-- OR Occupancy Time column
-- the time a pateint spends after entering the or_suite
ALTER TABLE or_utilization
ADD COLUMN or_occupancy_min INTEGER;

UPDATE or_utilization
SET or_occupancy_min = EXTRACT(EPOCH FROM (wheels_out - wheels_in)) / 60;

-- Schedule Delay column
-- difference between scheduled time and actual surgery starts
ALTER TABLE or_utilization
ADD COLUMN schedule_delay_min INTEGER;

UPDATE or_utilization
SET schedule_delay_min = EXTRACT(EPOCH FROM (start_time - or_schedule)) / 60;




SELECT *
FROM or_utilization
LIMIT 10;


	
