-- Telco Customer Churn Analysis
-- Project: Revenue Loss Estimation and Customer Retention Strategy
-- DBMS: MySQL 8.0+

CREATE DATABASE IF NOT EXISTS telco_churn_db;
USE telco_churn_db;

DROP TABLE IF EXISTS telco_churn_raw;

CREATE TABLE telco_churn_raw (
    customerID VARCHAR(20),
    gender VARCHAR(10),
    SeniorCitizen TINYINT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges VARCHAR(20),
    Churn VARCHAR(5)
);

-- CSV Import Example
-- 1. Put the CSV file in a local path.
-- 2. Enable local infile if needed:
--    SET GLOBAL local_infile = 1;
-- 3. Replace the file path below with your own path.
--
-- LOAD DATA LOCAL INFILE 'C:/path/to/WA_Fn-UseC_-Telco-Customer-Churn.csv'
-- INTO TABLE telco_churn_raw
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 LINES
-- (
--     customerID, gender, SeniorCitizen, Partner, Dependents, tenure,
--     PhoneService, MultipleLines, InternetService, OnlineSecurity,
--     OnlineBackup, DeviceProtection, TechSupport, StreamingTV,
--     StreamingMovies, Contract, PaperlessBilling, PaymentMethod,
--     MonthlyCharges, TotalCharges, Churn
-- );

DROP VIEW IF EXISTS telco_churn_clean;

CREATE VIEW telco_churn_clean AS
SELECT
    customerID,
    gender,
    SeniorCitizen,
    Partner,
    Dependents,
    tenure,
    PhoneService,
    MultipleLines,
    InternetService,
    OnlineSecurity,
    OnlineBackup,
    DeviceProtection,
    TechSupport,
    StreamingTV,
    StreamingMovies,
    Contract,
    PaperlessBilling,
    PaymentMethod,
    MonthlyCharges,
    CAST(NULLIF(TRIM(TotalCharges), '') AS DECIMAL(10,2)) AS TotalCharges,
    Churn,
    CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END AS ChurnFlag,
    CASE
        WHEN tenure <= 6 THEN '0-6 months'
        WHEN tenure <= 12 THEN '7-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_group
FROM telco_churn_raw;

-- 0. Data Quality Check
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS null_total_charges
FROM telco_churn_clean;

-- 1. Overall Churn Rate and Monthly Revenue Loss
SELECT
    COUNT(*) AS total_customers,
    SUM(ChurnFlag) AS churned_customers,
    ROUND(SUM(ChurnFlag) * 100.0 / COUNT(*), 2) AS churn_rate,
    ROUND(SUM(MonthlyCharges), 2) AS total_monthly_revenue,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS churned_monthly_revenue,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) * 100.0 / SUM(MonthlyCharges),
        2
    ) AS revenue_loss_rate
FROM telco_churn_clean;

-- 2. Churn Rate by Contract Type
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(ChurnFlag) AS churned_customers,
    ROUND(SUM(ChurnFlag) * 100.0 / COUNT(*), 2) AS churn_rate,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS churned_monthly_revenue
FROM telco_churn_clean
GROUP BY Contract
ORDER BY churn_rate DESC;

-- 3. Churn Rate by Payment Method
SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(ChurnFlag) AS churned_customers,
    ROUND(SUM(ChurnFlag) * 100.0 / COUNT(*), 2) AS churn_rate,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS churned_monthly_revenue
FROM telco_churn_clean
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

-- 4. Churn Rate by Internet Service
SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(ChurnFlag) AS churned_customers,
    ROUND(SUM(ChurnFlag) * 100.0 / COUNT(*), 2) AS churn_rate,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS churned_monthly_revenue
FROM telco_churn_clean
GROUP BY InternetService
ORDER BY churn_rate DESC;

-- 5. Churn Rate by Tenure Group
SELECT
    tenure_group,
    COUNT(*) AS total_customers,
    SUM(ChurnFlag) AS churned_customers,
    ROUND(SUM(ChurnFlag) * 100.0 / COUNT(*), 2) AS churn_rate,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS churned_monthly_revenue
FROM telco_churn_clean
GROUP BY tenure_group
ORDER BY
    CASE tenure_group
        WHEN '0-6 months' THEN 1
        WHEN '7-12 months' THEN 2
        WHEN '13-24 months' THEN 3
        WHEN '25-48 months' THEN 4
        ELSE 5
    END;

-- 6. High-Risk and High-Revenue Segment
SELECT
    Contract,
    PaymentMethod,
    InternetService,
    COUNT(*) AS total_customers,
    SUM(ChurnFlag) AS churned_customers,
    ROUND(SUM(ChurnFlag) * 100.0 / COUNT(*), 2) AS churn_rate,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS churned_monthly_revenue
FROM telco_churn_clean
GROUP BY Contract, PaymentMethod, InternetService
HAVING COUNT(*) >= 30
ORDER BY churned_monthly_revenue DESC, churn_rate DESC
LIMIT 15;
