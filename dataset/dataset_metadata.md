# Dataset Metadata

## 1. Dataset Overview

**Project:** Operating Room Efficiency Investigation

The project uses a surgical encounter dataset containing Operating Room scheduling, procedure, and timestamp information. Each row represents one surgical encounter.

**Analysis period:** January 3, 2022 – March 31, 2022

**Records:** 2,172 surgical encounters

**Original columns:** 12

**OR suites:** 8

**Medical services/specialties:** 10

**CPT procedure types:** 32

**Operating dates:** 62

## 2. Dataset Source

**Source:** Kaggle — Operating Room Utilization dataset  
**Kaggle URL:** https://www.kaggle.com/datasets/thedevastator/optimizing-operating-room-utilization

**Original dataset/file:** `2022_Q1_OR_Utilization.csv`

**Original author:** Jennifer Falk

The repository retains the source attribution. Redistribution and adaptation should follow the licensing terms stated on the original Kaggle dataset page.

## 3. Original Columns

| Column | Description |
|---|---|
| encounter_id | Unique identifier for the surgical encounter |
| surgery_date | Date on which the surgery was performed |
| or_suite | Operating Room suite where the encounter took place |
| service | Medical specialty/service associated with the encounter |
| cpt_code | CPT code associated with the procedure |
| cpt_description | Description of the surgical procedure |
| booked_time_min | Planned/booked procedure time in minutes |
| or_schedule | Scheduled OR time |
| wheels_in | Time the patient entered the Operating Room |
| start_time | Actual procedure start time |
| end_time | Actual procedure end time |
| wheels_out | Time the patient left the Operating Room |

## 4. Derived Analysis Fields

Three fields were created during SQL preparation:

| Derived field | Definition |
|---|---|
| procedure_duration_min | `end_time - start_time` |
| or_occupancy_min | `wheels_out - wheels_in` |
| schedule_delay_min | `start_time - or_schedule` |

For schedule delay, a positive value means the procedure started after the scheduled OR time, while a negative value means it started before the scheduled OR time.

## 5. Data Validation

The dataset was checked before business analysis. Validation included:

- Total record count
- Distinct encounter IDs
- NULL values
- Duplicate encounter IDs
- Booked-time values greater than zero
- Actual OR timestamp consistency

Validation confirmed:

- No NULL values in the source dataset
- No duplicate encounter IDs
- All 2,172 encounter IDs are unique
- No booked-time values less than or equal to zero
- The actual OR timeline follows `wheels_in → start_time → end_time → wheels_out`

The scheduled OR time is evaluated separately through `schedule_delay_min`. It is not assumed that scheduled time must always occur before wheels-in.

## 6. Dataset Limitations

The dataset does not provide total available OR capacity hours for each suite. Therefore, a true OR utilization percentage cannot be calculated.

The available data can identify workload and scheduling patterns, but it cannot establish specific causes behind delays or workload differences. For example, the dataset does not contain enough information to conclude whether delays were caused by staffing, equipment, surgeon availability, patient factors, or other operational causes.

## 7. Privacy Note

The dataset schema does not contain obvious direct patient fields such as patient name, address, phone number, email address, or medical record number. However, it contains encounter-level healthcare information, timestamps, CPT/procedure information, and an encounter identifier.

Use and redistribution should therefore follow the source dataset's licensing terms and any applicable data-use restrictions.

## 8. Attribution

This project uses the **Operating Room Utilization** dataset published on Kaggle by **The Devastator**, with the source credited to **Jennifer Falk**.

**Source:** https://www.kaggle.com/datasets/thedevastator/optimizing-operating-room-utilization

Please refer to the original Kaggle dataset page for the current license and attribution requirements.
