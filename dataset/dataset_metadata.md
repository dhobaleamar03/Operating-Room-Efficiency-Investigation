# Dataset Metadata

The dataset used for this project contains surgical encounter records from Operating Room (OR) operations. The dataset was used to study surgical volume, OR workload, procedure duration, OR occupancy, scheduling delays, and booked versus actual OR time.

The analysis covers the period from January 3, 2022 to March 31, 2022.

The dataset contains 2,172 surgical encounters and 12 original columns. Each row represents one surgical encounter, and the `encounter_id` is used as the unique identifier for each encounter.


## Column Description

1. encounter_id: The 'encounter_id' column contains a unique identification number for each surgical encounter.

2. surgery_date: The 'surgery_date' column contains the date on which the surgery was performed.

3. or_suite: The 'or_suite' column identifies the Operating Room suite where the surgical encounter took place.

4. service: The 'service' column identifies the medical specialty or service associated with the surgical encounter.

5. cpt_code: The 'cpt_code' column contains the CPT code associated with the surgical procedure.

6. cpt_description: The 'cpt_description' column contains the description of the surgical procedure.

7. booked_time_min: The 'booked_time_min' column contains the planned time booked for the procedure, measured in minutes.

8. or_schedule: The 'or_schedule' column contains the scheduled time for the surgery.

9. wheels_in: The 'wheels_in' column contains the time when the patient entered the Operating Room.

10. start_time: The 'start_time' column contains the actual time when the surgical procedure started.

11. end_time: The 'end_time' column contains the actual time when the surgical procedure ended.

12. wheels_out: The 'wheels_out' column contains the time when the patient left the Operating Room.


## Derived Columns

Three additional columns were created during the SQL data preparation stage.

1. procedure_duration_min: This column contains the actual procedure duration in minutes. It is calculated from the difference between `start_time` and `end_time`.

2. or_occupancy_min: This column contains the OR occupancy time in minutes. It is calculated from the difference between `wheels_in` and `wheels_out`.

3. schedule_delay_min: This column contains the scheduling delay in minutes. It is calculated from the difference between the scheduled time (`or_schedule`) and the actual procedure start time (`start_time`).


## Dataset Validation

The dataset was checked before carrying out the business analysis.

The validation included:

1. Total record count check.

2. Distinct encounter ID check.

3. NULL value check for the main dataset fields.

4. Duplicate encounter ID check.

5. Validation of booked time to make sure the value was greater than zero.

6. Validation of the surgical timeline.

The expected timeline used for validation was:

`or_schedule → wheels_in → start_time → end_time → wheels_out`

The dataset passed the validation checks. No NULL values, duplicate encounter IDs, or invalid time sequences were found, and no data imputation or unnecessary data cleaning was required.


## Dataset Limitations

The dataset contains information about surgical encounters, OR occupancy, procedure timing, and scheduling. However, OR capacity hours are not available in the dataset.

Because of this, OR utilization percentage cannot be calculated.

The available data can be used to identify workload and scheduling patterns, but it cannot be used to establish the specific causes behind scheduling delays or differences in OR workload.

For example, the dataset does not contain information that would allow the analysis to conclude whether a delay was caused by staffing, equipment, surgeon availability, patient factors, or other operational reasons.


## 7. Source and Attribution

This project uses the Operating Room Utilization dataset published on Kaggle by The Devastator.

**Source:** https://www.kaggle.com/datasets/thedevastator/optimizing-operating-room-utilization

**Original author:** Jennifer Falk

The dataset should be redistributed and adapted according to the licensing terms stated on the original Kaggle dataset page. This repository retains the source attribution so the origin of the dataset is clear.

## 8. Privacy Note

The dataset schema used in this project does not contain obvious direct patient fields such as patient name, address, phone number, email address, or medical record number. However, it contains encounter-level healthcare information, timestamps, CPT/procedure information, and an encounter identifier. Use and redistribution should follow the source dataset's licensing terms and any applicable data-use restrictions.
