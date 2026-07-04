CREATE DATABASE Medical; 
USE Medical;


CREATE TABLE Patients (
    Name VARCHAR(100), Age INT, Gender VARCHAR(10), Blood_Type VARCHAR(5),
    Medical_Condition VARCHAR(50), Date_of_Admission VARCHAR(20),
    Doctor VARCHAR(100), Hospital VARCHAR(100), Insurance_Provider VARCHAR(50),
    Billing_Amount DECIMAL(10,2), Room_Number VARCHAR(10),
    Admission_Type VARCHAR(20), Discharge_Date VARCHAR(20),
    Medication VARCHAR(100), Test_Results VARCHAR(20)
);

-- Import Data from CSV
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 9.5/Uploads/CSV_Healthcare_Cleaned.csv'
INTO TABLE Patients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Count of Rows
SELECT COUNT(*) FROM Medical.patients;

-- Basic Analysis
SELECT 
    COUNT(*) as Total_Patients,
    AVG(Age) as Avg_Age,
    AVG(Billing_Amount) as Avg_Billing,
    COUNT(DISTINCT Medical_Condition) as Unique_Conditions
FROM patients;


-- Billing by Conditoion Analysis
SELECT 
    Medical_Condition,
    COUNT(*) as Patient_Count,
    ROUND(AVG(Billing_Amount), 2) as Avg_Billing,
    SUM(Billing_Amount) as Total_Billing
FROM Patients 
GROUP BY Medical_Condition 
ORDER BY Total_Billing DESC;


-- Calculating LOS
SELECT 
    Date_of_Admission,
    Discharge_Date,
    DATEDIFF(Discharge_Date, Date_of_Admission) as LOS_Days
FROM Patients 
LIMIT 10;


-- Date Foramt Fix
SET SQL_SAFE_UPDATES=0;
UPDATE Patients SET Date_of_Admission = STR_TO_DATE(Date_of_Admission, '%d-%m-%Y');
UPDATE Patients SET Discharge_Date = STR_TO_DATE(Discharge_Date, '%d-%m-%Y');


-- LOS Analysis
SELECT 
    Medical_Condition,
    ROUND(AVG(DATEDIFF(Discharge_Date,Date_of_Admission)),1) AS Avg_LOS_Days,
    COUNT(*) AS Patient_Count
FROM Patients 
WHERE Discharge_Date > Date_of_Admission
GROUP BY Medical_Condition 
ORDER BY Avg_LOS_Days DESC;


SELECT * FROM Patients;